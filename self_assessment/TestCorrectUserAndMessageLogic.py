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

class CorrectUserAndMessageLogic(unittest.TestCase):
    
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(5)
        self.base_url = BASEURL
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_correct_user_logout(self):
        test_description = "test correct user logout"
        print "Testing " + test_description
        driver = self.driver

        username, password, title, text = helper_functions.create_user_and_add_message(self.base_url, driver)
        helper_functions.get(driver, urljoin(self.base_url, "message/list"))
        
        xpath_title = helper_functions.clean_string_for_xpath(title)
        message = driver.find_element_by_xpath("//div[@class='message' and contains(., %s)]" % (xpath_title,))
        self.assertTrue(message.text.find(text) != -1)

        helper_functions.get(driver, urljoin(self.base_url, "user/logout"))
        
        helper_functions.get(driver, urljoin(self.base_url, "message/list"))

        xpath_title = helper_functions.clean_string_for_xpath(title)
        self.assertFalse(self.is_element_present(By.XPATH, "//div[@class='message' and contains(., %s)]" % (xpath_title,)))
        


    def test_correct_message_creation(self):
        test_description = "test correct message creation"
        print "Testing " + test_description
        driver = self.driver
        username, password, title, text = helper_functions.create_user_and_add_message(self.base_url, driver)

        helper_functions.get(driver, urljoin(self.base_url, "message/list"))

        xpath_title = helper_functions.clean_string_for_xpath(title)
        message = driver.find_element_by_xpath("//div[@class='message' and contains(., %s)]" % (xpath_title,))
        self.assertTrue(message.text.find(text) != -1)
        

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
