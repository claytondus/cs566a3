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

class CorrectUserLogic(unittest.TestCase):
    
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(10)
        self.base_url = BASEURL
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_correct_create_user(self):
        test_description = "test correct create user"
        print "Testing " + test_description
        driver = self.driver
        helper_functions.create_and_login_user(self.base_url, driver)
        

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
