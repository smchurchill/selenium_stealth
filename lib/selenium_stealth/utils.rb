require "selenium-webdriver"
require_relative "wrapper"

module SeleniumStealth
    class Utils
        def self.with_utils(driver **kwargs)
            raise ArgumentError, "driver must be an instance of Selenium::WebDriver::Driver" unless driver.is_a?(Selenium::WebDriver::Driver)

            js_path = File.join(File.dirname(__FILE__), "js", "utils.js")
            js_content = File.read(js_path)
            Wrapper.evaluateOnNewDocument(driver, js_content)
        end
    end
end
