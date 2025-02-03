require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'

  gem 'base64'
  gem 'playwright-ruby-client', require: 'playwright'
end

EMAIL = 'test@example.com'
PASSWORD = 'hogehoge'

def wait
  sleep rand(1..3)
end

Playwright.create(playwright_cli_executable_path: './node_modules/.bin/playwright') do |playwright|
  playwright.chromium.launch(headless: false) do |browser|
    page = browser.new_page

    page.goto('https://moneyforward.com/')
    page.goto('https://moneyforward.com/sign_in')

    wait

    page.locator('input[name="mfid_user[email]"]').click
    page.keyboard.type(EMAIL)
    page.locator('button#submitto').click

    wait

    page.locator('input[name="mfid_user[password]"]').click
    page.keyboard.type(PASSWORD)
    page.locator('button#submitto').click

    wait

    page.screenshot(path: './logged_in.png')
  end
end
