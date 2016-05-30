Given(/^I am on (menards) (in store private) home page$/) do |brand, section|
  homepage = MenardHomepage.new(@browser)
  section = section.downcase.gsub!(' ', '_')
  homepage.open(section, brand)
  wait_for_some_time 2
end