require "selenium-webdriver"
require_relative "chrome_app"
require_relative "chrome_runtime"
require_relative "iframe_content_window"
require_relative "media_codecs"
require_relative "navigator_languages"
require_relative "navigator_permissions"
require_relative "navigator_plugins"
require_relative "navigator_vendor"
require_relative "navigator_webdriver"
require_relative "user_agent_override"
require_relative "utils"
require_relative "webgl_vendor"
require_relative "window_outerdimensions"
require_relative "hairline_fix"

module SeleniumStealth
    class stealth
        def self.apply(
            driver:,
            user_agent: nil,
            languages: nil,
            vendor: "Google Inc.",
            platform: nil,
            webgl_vendor: "Intel Inc.",
            renderer: "Intel Iris OpenGL Engine",
            fix_hairline: false,
            run_on_insecure_origins: false,
            **kwargs
        )
            raise
                ArgumentError,
                "driver must be an instance of Selenium::WebDriver::Driver" unless 
                driver.is_a?(Selenium::WebDriver::Driver)
            languages ||= ["en-US", "en"]
            ua_languages = languages.join(',')
            Utils.with_utils(driver, **kwargs)
            ChromeApp.apply(driver, **kwargs)
            ChromeRuntime.apply(driver, run_on_insecure_origins, **kwargs)
            IframeContentWindow.apply(driver, **kwargs)
            MediaCodecs.apply(driver, **kwargs)
            NavigatorLanguages.apply(driver, languages, **kwargs)
            NavigatorPermissions.apply(driver, **kwargs)
            NavigatorPlugins.apply(driver, **kwargs)
            NavigatorVendor.apply(driver, vendor, **kwargs)
            NavigatorWebdriver.apply(driver, **kwargs)
            UserAgentOverride.apply(driver, user_agent, ua_languages, platform, **kwargs)
            WebglVendor.apply(driver, webgl_vendor, renderer, **kwargs)
            WindowOuterDimensions.apply(driver, **kwargs)
            HairlineFix.apply(driver, **kwargs) if fix_hairline
        end
    end
end
