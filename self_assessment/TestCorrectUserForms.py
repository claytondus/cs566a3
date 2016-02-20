#!/usr/bin/env python

# -*- coding: utf-8 -*-
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
import unittest, time, re
from urlparse import urljoin

import helper_functions

global BASEURL

class CorrectUserForms(unittest.TestCase):
    
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(10)
        self.base_url = BASEURL
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_correct_register_forms(self):
        test_description = "test correct register forms"
        print "Testing " + test_description
        driver = self.driver
        helper_functions.get(driver, urljoin(self.base_url, "user/register"))
        self.assertTrue(self.is_element_present(By.XPATH, "//form[@name='register']"))
        self.assertTrue(self.is_element_present(By.XPATH, "//input[@name='username'][@type='text']"))
        self.assertTrue(self.is_element_present(By.XPATH, "//input[@name='password'][@type='password']"))
        self.assertTrue(self.is_element_present(By.XPATH, "//input[@name='password_confirm'][@type='password']"))
        self.assertTrue(self.is_element_present(By.XPATH, "//input[@name='submit'][@type='submit']"))

    def test_correct_login_forms(self):
        test_description = "test correct login forms"
        print "Testing " + test_description
        driver = self.driver
        helper_functions.get(driver, urljoin(self.base_url, "user/login"))
        self.assertTrue(self.is_element_present(By.XPATH, "//form[@name='login']"))
        self.assertTrue(self.is_element_present(By.XPATH, "//input[@name='username'][@type='text']"))
        self.assertTrue(self.is_element_present(By.XPATH, "//input[@name='password'][@type='password']"))
        self.assertTrue(self.is_element_present(By.XPATH, "//input[@name='submit'][@type='submit']"))                        
        

    def is_element_present(self, how, what):
        try: self.driver.find_element(by=how, value=what)
        except NoSuchElementException, e: return False
        return True
    
    def is_alert_present(self):
        try: self.driver.switch_to_alert()
        except NoAlertPresentException, e: return False
        return True
    
    def close_alert_and_get_its_text(self):
        try:
            alert = self.driver.switch_to_alert()
            alert_text = alert.text
            if self.accept_next_alert:
                alert.accept()
            else:
                alert.dismiss()
            return alert_text
        finally: self.accept_next_alert = True
    
    def tearDown(self):
        self.driver.quit()
        #self.assertEqual([], self.verificationErrors)
        
    @classmethod
    def tearDownClass(cls):
        pass

if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1:
        BASEURL = sys.argv.pop()
    unittest.main()
