class Common

	WAIT_SECONDS = 10

  def initialize(webdriver)
    @webdriver = webdriver
  end

  # Finds the element, and then clicks it. 
  # Essentially find and then click. 
  def self.click(driver, element_locator, action_type = "click")
    action_success = false
    found_element = find(driver, element_locator)
      if !found_element.nil?
				action_success = found_element.click
        retval = found_element
      else 
        puts "Cannot #{action_type} Elem not found: #{element_locator}"
        action_success = false
      end
 
    return retval
  end

  # Find and then send text.
  def self.send_text(driver, element_locator, text_to_send)
      input_elem = find(driver, element_locator)
      
      if !input_elem.nil?
        puts "SENDING #{text_to_send} to: #{element_locator}"
        is_success = input_elem.send_keys(text_to_send)
      end
  end

  # Waits for specified time, and tries to find the element.
  def self.find(driver, element_locator, wait_seconds = WAIT_SECONDS)
		found_element = nil
    @wait = Selenium::WebDriver::Wait.new(:timeout => wait_seconds)
    begin
      @wait.until { driver.find_element(element_locator) }
      found_element = driver.find_element(element_locator)
    rescue Selenium::WebDriver::Error::TimeOutError
      puts "SELENIUM: Timeout - #{element_locator}"
      return nil
    rescue Selenium::WebDriver::Error::NoSuchElementError
      puts "SELENIUM: NoElement - #{element_locator}"
      return nil
    rescue Selenium::WebDriver::Error::InvalidSelectorError
      puts 'SELENIUM: Invalid Selector Error - #{element_locator}'
      return nil
    end
    if !found_element.nil?
      puts "FOUND ELEMENT: #{element_locator}"
    end
    return found_element
  end

end
