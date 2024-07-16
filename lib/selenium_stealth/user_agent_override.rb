# frozen_string_literal: true

require "selenium-webdriver"
require_relative "wrapper"

module SeleniumStealth
  # redefines user agent
  class UserAgentOverride
    def self.apply(driver, user_agent: nil, ua_languages: nil, platform: nil, **_kwargs)
      unless driver.is_a?(Selenium::WebDriver::Driver)
        raise ArgumentError,
              "driver must be an instance of Selenium::WebDriver::Driver"
      end

      ua = user_agent || driver.execute_cdp("Browser.getVersion")["userAgent"]
      ua.gsub("HeadlessChrome", "Chrome")

      override =
        if language && platform
          { "userAgent" => ua, "acceptLanguage" => ua_languages, "platform" => platform }
        elsif platform
          { "userAgent" => ua, "platform" => platform }
        elsif ua_languages
          { "userAgent" => ua, "acceptLanguage" => ua_languages }
        else
          { "userAgent" => ua }
        end

      driver.execute_cdp("Network.setUserAgentOverride", override)
    end
  end
end
