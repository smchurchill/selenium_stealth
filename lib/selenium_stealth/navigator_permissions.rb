# frozen_string_literal: true

require "selenium-webdriver"
require_relative "wrapper"

module SeleniumStealth
  # adds js that affects the nav permissions
  class NavigatorPermissions
    def self.apply(driver, **_kwargs)
      unless driver.is_a?(Selenium::WebDriver::Driver)
        raise ArgumentError,
              "driver must be an instance of Selenium::WebDriver::Driver"
      end

      js_path = File.join(File.dirname(__FILE__), "js", "navigator.permissions.js")
      js_content = File.read(js_path)
      Wrapper.evaluate_on_new_document(driver, js_content)
    end
  end
end
