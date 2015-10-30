class Common

	WAIT_SECONDS = 10

  def initialize(webdriver)
    @webdriver = webdriver
  end

  def self.find_n_click(driver, elem_locator, action_type = "click")
    action_success = false
    found_elem = wait_until_found(driver, elem_locator)
      if !found_elem.nil?
				puts "CLICKING #{elem_locator}"
				action_success = found_elem.click
        retval = found_elem
      else 
        puts "Cannot #{action_type} Elem not found: #{elem_locator}"
        action_success = false
      end
 
    return retval
  end

   def self.call_send_keys(web_element, keys_to_send)
    begin
      web_element.send_keys(keys_to_send)
    rescue Selenium::WebDriver::Error::NoSuchElementError
      return false
    end
    return true
  end

  def self.send_text(driver, elem_locator, text_to_send)
      input_elem = wait_until_found(driver, elem_locator)
      
      if !input_elem.nil?
        puts "SENDING #{text_to_send} to: #{elem_locator}"
        is_success = call_send_keys(input_elem, text_to_send)
      end
  end

  def self.wait_until_found(driver, elem_locator, wait_seconds = WAIT_SECONDS)
		found_elem = nil
    @wait = Selenium::WebDriver::Wait.new(:timeout => wait_seconds)
    begin
      @wait.until { driver.find_element(elem_locator) }
      found_elem = driver.find_element(elem_locator)
    rescue Selenium::WebDriver::Error::TimeOutError
      puts "SELENIUM: Timeout - #{elem_locator}"
      return nil
    rescue Selenium::WebDriver::Error::NoSuchElementError
      puts "SELENIUM: NoElement - #{elem_locator}"
      return nil
    rescue Selenium::WebDriver::Error::InvalidSelectorError
      puts 'SELENIUM: Invalid Selector Error - #{elem_locator}'
      return nil
    end
    if !found_elem.nil?
      puts "FOUND ELEMENT: #{elem_locator}"
    end
    return found_elem
  end

end
