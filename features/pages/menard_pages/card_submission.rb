class CardSubmission < MenardHomepage

  def initialize(browser)
    @browser = browser
  end

  def get_user_information(info={})
    user_info = Hash.new( "month" )
    user_info = {
        'firstName' => Faker::Name.first_name,
        'lastName' => Faker::Name.last_name,
        'emailAddress' => Faker::Internet.email,
        'home' => Faker::Address.street_address,
        'addressLine2' => '213',
        'addressCity' => Faker::Address.city,
        'addressPostalCode' => '45343',
        'homePhoneNumber' => Faker::Number.number(10),
        'dateOfBirth' => "12121967",
        'income' => "5676",
        'ssn' => "999999999",
        'monthlyHousingPaymentAmount' => '750',
        'addressState' => 'California',
        'housingStatus' => 'Own',
        'employmentStatus' => 'Full Time',
        'paidEvery' => 'Weekly'
    }
    user_info.update info
    puts "New User Data:  #{user_info}"
    user_info
  end

  def fill_customer_formation_card(info={})
    user_info = self.get_user_information info
    # puts "fill_customer_formation_card #{user_info}"
    @browser.text_field(:id, "firstName").set user_info['firstName']
    @browser.text_field(:id, "lastName").set user_info['lastName']
    @browser.text_field(:id, "emailAddress").set user_info['emailAddress']
    if user_info['in_store_private']
      @browser.text_field(:id, "emailAddressConfirm").set user_info['emailAddress']
    end
    @browser.text_field(:id, "autocomplete").set user_info['home']
    sleep 2
    #wait_for_some_time 2
    @browser.text_field(:id, "lastName").click
    sleep 2
    #wait_for_some_time 2
    @browser.text_field(:id, "addressLine1").set user_info['home']
    #
    # begin
    #     @browser.text_field(:id, "home").set user_info['home']
    #     wait_for_some_time 5
    # rescue
    #   @browser.text_field(:id, "addressLine1").set user_info['home']
    # end
    # wait_for_some_time 5
    @browser.text_field(:id, "addressLine2").set user_info['addressLine2']
    #wait_for_some_time 3

    @browser.text_field(:id, "addressCity").set user_info['addressCity']
    @browser.text_field(:id, "addressPostalCode").set user_info['addressPostalCode']
    @browser.text_field(:id, "homePhoneNumber").set user_info['homePhoneNumber']
    @browser.text_field(:id, "dateOfBirth").set user_info['dateOfBirth']

    # begin
    #   @browser.text_field(:id, "home").set user_info['home']
    #   wait_for_some_time 5
    # rescue
    #   @browser.text_field(:id, "addressLine1").set user_info['home']
    # end
    # wait_for_some_time 5
    # @browser.text_field(:id, "addressLine2").set user_info['addressLine2']
    # wait_for_some_time 3
    @browser.text_field(:id, "income").set user_info['income']
    @browser.text_field(:id, "taxId").set user_info['ssn']
    @browser.text_field(:id, "monthlyHousingPaymentAmount").set user_info['monthlyHousingPaymentAmount']
    @browser.select_list(:id, "addressState").option(:text => user_info['addressState']).select
    @browser.select_list(:id, "housingStatus").option(:text => user_info['housingStatus']).select
    @browser.select_list(:id, "employmentStatus").option(:text => user_info['employmentStatus']).select
    @browser.select_list(:id, "paidEvery").option(:text => user_info['paidEvery']).select
    user_info
  end

  def submit_information_form info={}
    user_info = self.fill_customer_formation_card info
    # puts "submit_information_form #{user_info}"
    # puts user_info
  end


  def get_electronic_disclosure
    wait_for_some_time 3
    self.electronic_disclosure.text
  end

# def get_modal_text
#   modal_text = @browser.element(css: "div#loader").text
#   puts modal_text
#   modal_text
# end

  def get_submission_message
    #wait_for_some_time 6
    # begin
    #   @browser.element(css: 'div.container').text
    # rescue
    @browser.element(css: 'div.large-9.medium-8.small-12.columns').text.split("\n")[0]
    # end
  end

  def get_successful_message
    #wait_for_some_time 6
    # begin
    @browser.element(css: '.medium-8.large-8.columns h1.ng-binding').text.split("\n")[0]
    # rescue
    #   @browser.element(css: '.large-8.medium-10.small-10.columns div.col-right h1.ng-binding').text
    # end
  end


#############################Locators#####################################################

  def i_agree
    # @browser.checkbox(id: 'agree').set
    wait_for_some_time 2
    @browser.element(css: 'checkbox#agree-check').click
    #wait_for_some_time 1
    @browser.button(css: 'button#verify-submit.progressive.right').click
    #wait_for_some_time 5
  end

  def get_processing_page
    @browser.element(css: "#overlay-wrapper").text
  end

  def electronic_disclosure
    @browser.element(css: "drawer.ng-isolate-scope[content-key = 'electronic-info']")
  end



end