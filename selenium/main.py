from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium import webdriver
import time

print("Test Execution Started")
options = webdriver.ChromeOptions()
options.add_argument("--ignore-ssl-errors=yes")
options.add_argument("--ignore-certificate-errors")
driver = webdriver.Remote(
    command_executor="http://host.docker.internal:4444/wd/hub", options=options
)

# Open Google
driver.get("https://www.google.com")

# Find the search bar, input "github," and submit the search
search_bar = driver.find_element(By.NAME, "q")
search_bar.send_keys("github")
search_bar.send_keys(Keys.RETURN)

# Wait for the search results to load
wait = WebDriverWait(driver, 1)
wait.until(EC.presence_of_element_located((By.ID, "search")))

# Find the search bar again, input "lqss11 devops-tools," and submit the search
search_bar = driver.find_element(By.NAME, "q")
search_bar.clear()
search_bar.send_keys("lqss11 devops-tools")
search_bar.send_keys(Keys.RETURN)

# Wait for the search results to load
wait.until(EC.presence_of_element_located((By.ID, "search")))
print("Exiting in 10 seconds...")
time.sleep(10)
print("Test Execution Finished!")
# Quit the WebDriver session
driver.quit()
