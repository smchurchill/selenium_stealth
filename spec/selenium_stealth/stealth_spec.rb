# frozen_string_literal: true

require "base64"
require "selenium-webdriver"
require "selenium_stealth"
require "rspec"
require "fileutils"
require "mini_magick"

RSpec.describe "Stealth Tests" do
  let(:driver) do
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument("start-maximized")
    options.add_argument("--headless")

    Selenium::WebDriver.for(:chrome, options: options)
  end

  before do
    SeleniumStealth::Stealth.apply(driver: driver) # Call your stealth method here

    path = File.join(Dir.pwd, "tests/static/test.html").tr("\\", "/")
    url = "file://#{path}"
    driver.get(url)
    sleep 10

    metrics = driver.execute_cdp("Page.getLayoutMetrics")
    width = metrics["contentSize"]["width"].to_f.ceil
    height = metrics["contentSize"]["height"].to_f.ceil
    screen_orientation = { angle: 0, type: "portraitPrimary" }

    driver.execute_cdp("Emulation.setDeviceMetricsOverride", **{
                         mobile: false,
                         width: width,
                         height: height,
                         deviceScaleFactor: 1,
                         screenOrientation: screen_orientation
                       })

    clip = { x: 0, y: 0, width: width, height: height, scale: 1 }
    opt = { format: "png", clip: clip }

    @result = driver.execute_cdp("Page.captureScreenshot", **opt)
    @html = driver.page_source
  end

  after do
    driver.quit
  end

  it "checks for 'failed-text'" do
    expect(@html).not_to include("failed-text")
    expect(@html).to include("passed")
  end

  it "checks for warnings" do
    expect(@html).not_to include("warn")
    expect(@html).to include("passed")
  end
end
