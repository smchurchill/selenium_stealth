require "selenium-webdriver"
require "json"

module SeleniumStealth
    class Wrapper
        def self.evaluation_string(fun, *args)
            _args = args.map { |arg| arg.nil? ? "undefined" arg.to_json }.join(", ")
            expr = "(#{fun})(#{_args})"
            expr
        end

        def self.evaluate_on_new_document(driver, page_function, *args)
            js_code = evaluation_string(page_function, *args)
            driver.execute_cdp("Page.addScriptToEvaluateOnNewDocument", { 
                "source" => js_code
            })
        end
    end
end
