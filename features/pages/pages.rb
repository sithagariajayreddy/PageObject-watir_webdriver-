require 'rspec'
require 'watir-webdriver'
require 'cucumber'
require 'rake'
require 'spreadsheet'
require 'roo'
require 'page-object'
require 'faker'
require 'yaml'




include RSpec::Matchers

require File.dirname(__FILE__) + "/../pages/config/driver_config"
require File.dirname(__FILE__) + "/../pages/menard_pages/menard_homepage"
require File.dirname(__FILE__) + "/../pages/menard_pages/card_submission"
require File.dirname(__FILE__) + "/../pages/menard_pages/parse_xls"
require File.dirname(__FILE__) + "/../pages/get_homepage_url"

include Automation