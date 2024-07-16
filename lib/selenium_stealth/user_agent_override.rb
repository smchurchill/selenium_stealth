require "selenium-webdriver"
require_relative "wrapper"

module SeleniumStealth
    class UserAgentOverrid
        def self.apply(driver,  user_agent: nil, ua_languages: nil, platform: nil, **kwargs)
            raise ArgumentError, "driver must be an instance of Selenium::WebDriver::Driver" unless driver.is_a?(Selenium::WebDriver::Driver)
            ua = user_agent ||  driver.execute_cdp("Browser.getVersion")['userAgent']
            ua.gsub("HeadlessChrome", "Chrome")

            override =
                if language && platform
                    { "userAgent" => ua, "acceptLanguage" => language, "platform" => platform }
                elsif platform
                    { "userAgent" => ua, "platform" => platform }
                elsif language
                    { "userAgent" => ua, "acceptLanguage" => language }
                else
                    { "userAgent" => ua }
            end

            driver.execute_cdp('Network.setUserAgentOverride', override)
        end
    end
end
