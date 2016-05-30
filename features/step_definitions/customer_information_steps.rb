When(/^I provide the customer information$/) do
  user_info = {'home' => 'Approved'}
  card_submission = CardSubmission.new(@browser)
  card_submission.submit_information_form user_info
end

When(/^I provide the in store private customer information$/) do
  user_info = {'in_store_private' => 'Yes'}
  card_submission = CardSubmission.new(@browser)
  card_submission.submit_information_form(user_info)
end

When(/^I provide the in store public ipad customer information$/) do
  user_info = {'home' => 'Approved'}
  card_submission = CardSubmission.new(@browser)
  card_submission.submit_information_form (user_info)
end

Then(/^I should see the confirmation pending message$/) do
  card_submission = CardSubmission.new(@browser)
  xls_parser = ParseXls.new
  sheet_content = xls_parser.get_sheet('Pending Decision')
  decision_pending_message_page = card_submission.get_submission_message
  decision_pending_message_sheet = sheet_content[1]
  puts"Page: #{decision_pending_message_page}"
  puts"Excel: #{decision_pending_message_sheet}"
  decision_pending_message_page.include?(decision_pending_message_sheet).should == true
end

Then(/^I should see the correct short Rate & Fee Information$/) do
  xls_parser = ParseXls.new
  sheet_content = xls_parser.get_sheet("AccessibleMenu")
  homepage = MenardHomepage.new(@browser)
  rate_and_fee_text = homepage.get_rate_fee_content_short
  puts "\nActual :  \n#{rate_and_fee_text}"
  puts "Expected : \n#{sheet_content[1]}"
  expect(sheet_content[1]).to include(rate_and_fee_text)
end

Then(/^I should see the menards in store private correct short Rate & Fee Information$/) do
  xls_parser = ParseXls.new
  sheet_content = xls_parser.get_sheet("PrivateAccessibleMenu")
  homepage = MenardHomepage.new(@browser)
  rate_and_fee_text = homepage.get_rate_fee_content_short
  puts "\nActual :  \n#{rate_and_fee_text}"
  puts "Expected : \n#{sheet_content[3]}"
  expect(sheet_content[3]).to include(rate_and_fee_text)
end

And(/^I agree to term and conditions$/) do
  card_submission = CardSubmission.new(@browser)
  card_submission.i_agree
end

Then(/^I should see the processing page$/) do
  card_submission = CardSubmission.new(@browser)
  processing_page_text = card_submission.get_processing_page
  xls_parser = ParseXls.new
  processing_sheet_text = xls_parser.get_sheet("Processing").join(" ")
  expect(processing_sheet_text).to include(processing_page_text)
  puts "Actual: #{processing_page_text}"
  puts "Expected: #{processing_sheet_text}"
end


When(/^In Store Pvt I provide first name as (Test) ssn (\d+) and address as (.*)$/) do |first_name, ssn, addressLine1|

  user_info = {
      'firstName' => first_name,
      'ssn' => ssn,
      'home' => addressLine1,
      'in_store_private' => 'Yes'
  }
  card_submission = CardSubmission.new(@browser)
  card_submission.submit_information_form(user_info)
end


When(/^I provide first name as (Test) ssn (\d+) and address as (.*)$/) do |first_name, ssn, addressLine1|
  user_info = {
      'firstName' => first_name,
      'ssn' => ssn,
      'home' => addressLine1
  }
  card_submission = CardSubmission.new(@browser)
  card_submission.submit_information_form(user_info)
end


Then(/^I should see the confirmation message as (.*)$/) do |final_message|
  card_submission = CardSubmission.new(@browser)
  message_on_page =''
   wait_for_some_time 8
  if final_message == "Congratulations, Test! You're approved."
    message_on_page = card_submission.get_successful_message
  end
   wait_for_some_time 8
  if final_message == "You will receive a letter in the mail within 10 to 30 days with more information."
    message_on_page = card_submission.get_submission_message
  end
  # if final_message == "You will receive a letter in the mail within 10 to 30 days with more information."
  #   message_on_page = card_submission.get_submission_message
  # end
   wait_for_some_time 8
  if final_message == 'Please call us now at 555-555-5555 to complete this application.'
    message_on_page = card_submission.get_submission_message
  end
   wait_for_some_time 8
  if final_message == "Thanks for your patience"
    message_on_page = card_submission.get_submission_message
  end
  # if final_message == "Our apologies! We're having some technical difficulties."
  #   message_on_page = card_submission.get_submission_message
  # end
  # if final_message == "Our apologies! We're having some technical difficulties."
  #   message_on_page = card_submission.get_submission_message
  # end
  # if final_message == "Our apologies! We're having some technical difficulties."
  #   message_on_page = card_submission.get_submission_message
  # end
  # if final_message == 'Thanks for applying.  We need more time to review your application, so look out for a letter from us in 10-30 days with more information.'
  #   message_on_page = card_submission.get_submission_message
  # end
  # if final_message == "Congratulations, Test! You're approved."
  #   message_on_page = card_submission.get_successful_message
  # end
  # if final_message == "Congratulations, Test! You're approved."
  #   message_on_page = card_submission.get_successful_message
  # end
  puts "Actual : \n#{message_on_page}"
  puts "Expected : \n#{final_message}"

  message_on_page.downcase.include?(final_message.downcase).should be true
end


Then(/^I should see the correct Electronic Disclosure Consent$/) do
  xls_parser = ParseXls.new
  sheet_content = xls_parser.get_sheet("Electronic").join(" ")
  card_submission = CardSubmission.new(@browser)
  electronic_page = card_submission.get_electronic_disclosure
  puts "Actual: #{electronic_page}"
  puts "Expected: #{sheet_content}"
  expect(sheet_content).to include(electronic_page)
end

Then(/^I should see the menards in store private correct Electronic Disclosure Consent$/) do
  xls_parser = ParseXls.new
  sheet_content = xls_parser.get_sheet("Private Electronic").join(" ")
  card_submission = CardSubmission.new(@browser)
  electronic_page = card_submission.get_electronic_disclosure
  puts "Actual: #{electronic_page}"
  puts "Expected: #{sheet_content}"
  expect(electronic_page).to include(sheet_content)
end