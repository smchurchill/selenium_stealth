# frozen_string_literal: true

require "selenium-webdriver"
require "json"

module SeleniumStealth
  # wraps js functions
  class Wrapper
    def self.evaluation_string(fun, *args)
      comma_args = args.map { |arg| arg.nil? ? "undefined" : arg.to_json }.join(", ")
      "(#{fun})(#{comma_args})"
    end

    def self.evaluate_on_new_document(driver, page_function, *args)
      js_code = evaluation_string(page_function, *args)
      driver.execute_cdp("Page.addScriptToEvaluateOnNewDocument", source: js_code)
    end
  end
end
