require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [ 1400, 1400 ] do |driver_options|
    # Informe ao Selenium onde está o seu navegador
    # Verifique o caminho real rodando 'which chromium-browser' ou 'which google-chrome'
    driver_options.binary = "/usr/bin/chromium-browser" # ou o caminho que o which retornou

    driver_options.add_argument("--headless")
    driver_options.add_argument("--no-sandbox")
    driver_options.add_argument("--disable-dev-shm-usage")
  end

  def login_as(user, password: "password")
    visit new_session_path
    fill_in "Enter your email address", with: user.email_address
    fill_in "Enter your password", with: password
    click_button "Sign in"
    assert_no_selector "h1", text: "Sign in"
  end
end
