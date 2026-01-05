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
end
