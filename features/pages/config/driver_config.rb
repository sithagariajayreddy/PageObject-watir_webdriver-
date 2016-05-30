module Automation

  def launch_browser

    chromedriver_path = File.join(File.absolute_path('../../..', File.dirname(__FILE__)),"resource","chromedriver.exe")
    Selenium::WebDriver::Chrome.driver_path = chromedriver_path

    @browser = Watir::Browser.new :chrome
   # @browser = Watir::Browser.new :firefox
    @browser.driver.manage.timeouts.implicit_wait = 10
    @browser.driver.manage.window.maximize
  end

  def wait_for_some_time(timeout = 5)
    sleep timeout
    # wait_condition = @browser.execute_script("return jQuery.active") == 0
    # while wait_condition
    #   sleep 1
    # end
  end

  def browser
    @browser
  end

  def quit_browser
    @browser.close
  end

  def wait_for_page(timeout=30)
    browser.driver.manage.timeouts.page_load = timeout
  end


  def wait_for_text(text)
    Watir::Wait.until { @browser.text.include? text }
  end

  def wait_for_element_displayed(element, timeout=10)
    timeout.each do
      if element.displayed?
           return
      end
      sleep 1
    end
  end
  def get_screenshot(scenario_name, step_name)
    Dir::mkdir('screenshots') if not File.directory?('screenshots')
    Dir.chdir("screenshots")
    scenario_folder_name = "#{scenario_name.gsub(" ", "_").gsub(/[^0-9A-Za-z_]/, '')}"
    Dir::mkdir(scenario_folder_name) if not File.directory?(scenario_folder_name)
    Dir.chdir(scenario_folder_name)
    file_name = step_name.gsub(" ", "_").gsub(/[^0-9A-Za-z_]/, '')+".png"
    @browser.driver.save_screenshot file_name
    Dir.chdir("..")
    Dir.chdir("..")
  end

  def clean_screenshots
    FileUtils.rm_rf('screenshots') if File.directory?('screenshots')
  end

end
