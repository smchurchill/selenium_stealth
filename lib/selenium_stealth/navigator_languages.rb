require "selenium-webdriver"
require_relative "wrapper"

module SeleniumStealth
    class NavigatorLanguages
        def self.apply(driver, languages:, **kwargs)
            raise ArgumentError, "driver must be an instance of Selenium::WebDriver::Driver" unless driver.is_a?(Selenium::WebDriver::Driver)

            js_path = File.join(File.dirname(__FILE__), "js", "navigator.languages.js")
            js_content = File.read(js_path)
            Wrapper.evaluate_on_new_document(driver, js_content, languages)
        end
    end
end
