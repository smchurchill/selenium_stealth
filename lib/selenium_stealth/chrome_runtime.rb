require "selenium-webdriver"
require_relative "wrapper"

module SeleniumStealth
    class ChromeRuntime
        def self.apply(driver, run_on_insecure_origins = false, **kwargs)
            raise ArgumentError, "driver must be an instance of Selenium::WebDriver::Driver" unless driver.is_a?(Selenium::WebDriver::Driver)

            js_path = File.join(File.dirname(__FILE__), "js", "chrome.runtime.js")
            js_content = File.read(js_path)
            Wrapper.evaluate_on_new_document(driver, js_content, run_on_insecure_origins)
        end
    end
end
