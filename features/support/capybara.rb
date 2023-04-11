# frozen_string_literal: true

# Capybara defaults to CSS3 selectors rather than XPath.
# If you'd prefer to use XPath, just uncomment this line and adjust any
# selectors in your step definitions to use the XPath syntax.
# Capybara.default_selector = :xpath

Capybara.configure do |config|
  config.server = :puma, { Silent: true }

  if ENV['SHOW_BROWSER'] == 'true'
    Capybara.register_driver :selenium_chrome do |app|
      browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
        opts.args << '--window-size=1920,1080'
      end
      Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
    end
    config.javascript_driver = :selenium_chrome
  else
    config.javascript_driver = :selenium_chrome_headless
  end

  # config.javascript_driver = :selenium

  config.default_max_wait_time = 5
end
