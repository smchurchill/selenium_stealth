require "selenium-webdriver"
require_relative "wrapper"

module SeleniumStealth
    class NavigatorVendor
        def self.apply(driver, vendor, **kwargs)
            raise ArgumentError, "driver must be an instance of Selenium::WebDriver::Driver" unless driver.is_a?(Selenium::WebDriver::Driver)

            js_path = File.join(File.dirname(__FILE__), "js", "navigator.vendor.js")
            js_content = File.read(js_path)
            Wrapper.evaluate_on_new_document(driver, js_content, vendor)
        end
    end
end
