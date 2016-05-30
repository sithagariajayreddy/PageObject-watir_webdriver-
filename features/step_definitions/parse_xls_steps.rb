Given(/^I have worksheet$/) do
  puts "Test Executed on : #{Date.today.to_s}"
end

When(/^I provide sheet name (.*)$/) do|sheet_name|
  xls_parser = ParseXls.new
  @sheet_obj = xls_parser.get_sheet_by_name(sheet_name)
end

Then(/^I should see same sheet object$/) do
  xls_parser = ParseXls.new
  sheet_array = xls_parser.read_sheet(@sheet_obj)
  sheet_array
end