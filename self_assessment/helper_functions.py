import random
import string
import urlparse
import re
import hashlib
import time

def create_user(driver, username = None, password = None):
    if not username:
        username = id_generator(size=5)
    if not password:
        password = id_generator(size=6)
        
    uname_input = driver.find_element_by_name('username')
    uname_input.send_keys(username)    
    uname_input.clear()
    uname_input.send_keys(username)

    pass_input = driver.find_element_by_name('password')
    pass_input.clear()
    pass_input.send_keys(password)

    pass_conf_input = driver.find_element_by_name('password_confirm')
    pass_conf_input.clear()
    pass_conf_input.send_keys(password)

    driver.find_element_by_xpath("//input[@name='submit']").click()
    time.sleep(.5)

    return username, password

def login_user(driver, username, password):
    uname_input = driver.find_element_by_name('username')
    uname_input.send_keys(username)    
    uname_input.clear()
    uname_input.send_keys(username)

    pass_input = driver.find_element_by_name('password')
    pass_input.clear()
    pass_input.send_keys(password)

    driver.find_element_by_xpath("//input[@name='submit']").click()
    time.sleep(.5)

def create_and_login_user(base_url, driver):
    get(driver, urlparse.urljoin(base_url, "user/register"))
    time.sleep(.5)
    username, password = create_user(driver)

    get(driver, urlparse.urljoin(base_url, "user/login"))
    login_user(driver, username, password)

    return username, password

def id_generator(size=6, chars=string.ascii_lowercase + string.ascii_uppercase + string.digits):
    return ''.join(random.choice(chars) for _ in range(size))
    

def add_message(driver, title=None, text=None):
    if title is None:
        title = id_generator(size=10, chars=string.ascii_lowercase + string.ascii_uppercase + string.digits)
    if text is None:
        text = id_generator(size=6, chars=string.ascii_lowercase + string.ascii_uppercase + string.digits + ".,") + ' ' + id_generator(size=6, chars=string.ascii_lowercase + string.ascii_uppercase + string.digits + ".,") + ' ' + id_generator(size=6, chars=string.ascii_lowercase + string.ascii_uppercase + string.digits + ".,")

    title_input = driver.find_element_by_name('title')
    title_input.send_keys(title)    
    title_input.clear()
    title_input.send_keys(title)

    message_input = driver.find_element_by_name('message')
    message_input.clear()
    message_input.send_keys(text)

    driver.find_element_by_xpath("//input[@name='submit']").click()
    time.sleep(.5)

    return title, text

def create_user_and_add_message(base_url, driver):
    username, password = create_and_login_user(base_url, driver)

    get(driver, urlparse.urljoin(base_url, "message/add"))
    time.sleep(.5)

    title, text = add_message(driver)

    return username, password, title, text


# Adapted from StackOverflow here:
# http://stackoverflow.com/questions/13482352/xquery-looking-for-text-with-single-quote
def clean_string_for_xpath(str):  
    parts = []
    for match in re.findall("""[^'"]+|['"]""", str):
        if match == "'":
            parts.append('"\'"')
        elif (match == '"'):
            parts.append("'\"'")
        else:
            parts.append("'" + match + "'")
    if len(parts) == 1:
        return "'%s'" % str        
    else:
        return "concat(" + ",".join(parts) + ")"

def compute_knock_sequence(username):
    mapping = [ "user/register", "user/login", "message/add", "message/list" ]

    hash = hashlib.md5(username).hexdigest()
    knock_sequence = []
    for i in xrange(0, 4):
        simple = hash[i]        
        as_int = int(simple, 16)
        knock_sequence.append(mapping[as_int % 4])

    return knock_sequence

def get(driver, url, sleep_time = .5):
    driver.get(url)
    time.sleep(sleep_time)
