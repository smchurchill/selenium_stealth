# frozen_string_literal: true

require "selenium-webdriver"
require_relative "wrapper"

module SeleniumStealth
  # defines the graphics library vendor
  class WebglVendor
    def self.apply(driver, webgl_vendor:, renderer:, **_kwargs)
      unless driver.is_a?(Selenium::WebDriver::Driver)
        raise ArgumentError,
              "driver must be an instance of Selenium::WebDriver::Driver"
      end

      js_path = File.join(File.dirname(__FILE__), "js", "webgl.vendor.js")
      js_content = File.read(js_path)
      Wrapper.evaluate_on_new_document(driver, js_content, webgl_vendor, renderer, vendor)
    end
  end
end
