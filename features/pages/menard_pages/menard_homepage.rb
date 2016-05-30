class MenardHomepage
  include PageObject
  include Automation
  ENV['SECTION'] = 'web'
  ENV['BRAND']='menards'
  # include PageObject::PageFactory

  def initialize(browser)
    @browser = browser
  end

  def set_firstname
    self.first_name_text_field.set "Ajay"
  end

  def verify_textbox_firstname
    self.first_name_text_field.present?
  end

  def get_base_url(section ='', brand='')
    section = 'web' if section ==''
    brand = 'menards' if brand ==''
    home_page = GetHomepageURL.new
    base_url = home_page.get_url(section, brand)
    base_url
  end

  # @param [Object] section which section url req from yml
  # @param [Object] brand which brand url req from yml
  def open(section ='', brand='')
    base_url = self.get_base_url(section, brand)
    @browser.goto(base_url)
  end

  def is_current_page?
    @browser.title.include?('Menards BIG Card - Your Information')
  end

  def select_hamburger_menu
    @browser.element(:link, "Secure").click
  end

  def select_privacy_pdf_opt_out
    begin
      @browser.element(css: "div.menu-button button#accessible-menu.animated.oui-icon-menu-image").click
    rescue
      @browser.element(:css, "img.icon-menu-image").click
    end

    wait_for_some_time 1
    begin
      @browser.element(:css, "ul#menu.animated li.ng-scope a.main-menu-link.ng-scope span.oui-icon-locked.oui-icon-filled").click
    rescue
      @browser.element(:link, "Privacy & Opt-Out Notice").click
    end
  end

  def get_footer_links
    wait_for_some_time 7
    footer_error_links = []
    self.footer.each do |footer_ele|
      message = footer_ele.text
      #puts message
      if message != ''
        footer_error_links << message
      end
    end
    footer_error_links.join(" ")
  end
  # def verify_privacy_statement(sheet_cell)
  #   if sheet_cell.include?(self.privacy_statement.text)
  #     puts "Excel: #{sheet_cell}"
  #     puts "\n Webpage: #{self.privacy_statement.text}"
  #     true
  #   else
  #     return false
  #   end
  #   if sheet_cell.include?(self.get_privacy_statement_text)
  #     puts "Excel: #{sheet_cell}"
  #     puts "\n Webpage: #{self.get_privacy_statement_text}"
  #     true
  #   else
  #     return false
  #   end
  #   true
  # end

  def get_header_product_detail()
    self.wait_for_some_time 1
    self.header_product_details_expander.click
    self.wait_for_some_time 2
    product_body_detail = self.header_product_detail_body.text
    product_header_details = self.header_product_detail.text
    product_header_details.to_s + product_body_detail.to_s
  end

  def verify_header_heading(sheet)
    header_heading_text = self.header_heading.text
    # puts "Actual : #{sheet}"
    # puts "Expected : #{header_heading_text}"
    sheet == header_heading_text
  end

  def select_footer_links_by_name(hyperlink_text)
    footer.each do |footer_element|
      if footer_element.text.downcase == hyperlink_text.downcase
        wait_for_some_time 1
        footer_element.click
        break
      end
    end
    #wait_for_some_time 2
  end

  def get_new_page_title
    wait_for_some_time 3
    Watir::Wait.until { browser.windows.size == 2 }
    wait_for_some_time 3
    window = @browser.window(title: "Capital One | Our Accessibility Commitment").use
    title  = @browser.title
    window.close
    title
  end

  def get_modal_title
    wait_for_some_time 5
    # modal_title = @browser.element(css: "#modal.outer-container div.inner-container.ng-scope h1.ng-binding").text
    # @browser.element(css: "#modal > div.fixed-close > button").click
    modal_title = @browser.element(css: "#modal h1.ng-binding").text
    wait_for_some_time 5
    @browser.element(css: "#modal > .close").click
    modal_title
  end

  def get_privacy_opt_out_modal
    modal_title = @browser.element(css: "div.inner-container.ng-scope header.columns h1").text
    @browser.element(css: "div.fixed-close button.close").click
    modal_title
  end

  def switch_to_modal_verify_title(title_text)
    @browser.alert.exists?
    @browser.alert.text
    @browser.alert.close
  end

  def select_continue
    wait_for_some_time 2
    self.continue_submit_button.click
   wait_for_some_time 2
  end

  # def get_form_end_errors
  #   wait_for_some_time 3
  #   footer_error_messages = Array.new
  #   errors = self.form_end_error
  #   errors.each do |error_footer_message|
  #     message = error_footer_message.text
  #    # puts message
  #     footer_error_messages << message if message != ''
  #   end
  #   footer_error_messages
  # end


  def get_form_end_errors
    self.select_continue
    wait_for_some_time 3
    footer_error_messages = Array.new
    errors = self.form_end_error
    errors.each do |error_footer_message|
      message = error_footer_message.text
      # puts "In Loop#{message}"
      footer_error_messages << message if message != ''
    end
    footer_error_messages.join(" ")
  end

  def get_inline_errors
    wait_for_some_time 3
   # sleep 3
    inline_error_messages = Array.new
    # puts"\nPage Inline Erros"
    errors = self.inline_errors
    errors.each do |error_inline_message|
      message = error_inline_message.text
      # puts "#{message}"
      inline_error_messages << message if message != ''
    end
    inline_error_messages.join(" ")
  end

  def select_ssn
    self.ssn_text_box.click
   # wait_for_some_time 2
  end

  def get_ssn_tool_tip
    sleep 2
    tool_tip = self.ssn_tool_tip.text
    #puts "Expected : #{tool_tip}"
    tool_tip
  end

  def select_income
    self.income_text_box.click
    wait_for_some_time 2
  end

  def get_income_tool_tip
    wait_for_some_time 2
    tool_tip = self.income_tool_tip.text
   # puts "Expected : #{tool_tip}"
    tool_tip
  end

  def select_email
    wait_for_some_time 2
    email_text_box.click
  end

  def get_email_tool_tip
    wait_for_some_time 2
    content = email_tool_tip.text
    content
  end

  def select_accessible_menu
    wait_for_some_time 3
    self.accessible_menu.click
    #wait_for_some_time 2
  end

  def get_faqs
    wait_for_some_time 1
    self.accessible_menu_faqs.click
    wait_for_some_time 2
    self.faqs_content.text
  end

  def get_rate_fee_content_long
    self.accessible_menu_rate_fee_link.click
    wait_for_some_time 5
    # self.accessible_menu_rate_fee_long.text
    self.accessible_menu_rate_fee_long
  end

  def get_rate_fee_content_short
    wait_for_some_time 5
    self.accessible_menu_rate_fee_short.text
  end

  def get_customer_agreement
    self.accessible_menu_rate_fee_link.click
    wait_for_some_time 4
    # self.accessible_menu_rate_fee_long.click
    # wait_for_some_time 1
    self.accessible_menu_customer_agreement.click
    wait_for_some_time 4
    self.customer_agreement_content.text
  end

  def get_privacy_pdf_and_opt_out
    self.accessible_menu_privacy_pdf_and_opt_out.click
   # sleep 3
    wait_for_some_time 5
    self.privacy_pdf_and_opt_out.text
  end

  #################Locators##################
  def accessible_menu
    @browser.element(css: "div.menu-button button#accessible-menu.animated.oui-icon-menu-image")
  end

  def accessible_menu_faqs
    @browser.element(link: "FAQs")
  end

  def faqs_content
    @browser.element(css: "div.ng-scope div.wrapper div.outer-container ")
  end


  def accessible_menu_customer_agreement
    #@browser.element(css: "#modal.outer-container div.row.ng-scope.open div.outside.large-12.columns").click
    #self.wait_for_some_time 5
    @browser.element(id: "customer-agreement")
  end

  def customer_agreement_content
    # content_header = @browser.element(css: 'div#modal.outer-container div.row.ng-scope.open div.outside.large-12.columns' ).text
    # content_body = @browser.element(css: "modal section.terms.customer-agreement.container div.large-12.columns.ng-scope").text
    # content = content_header + content_body
    # content
    @browser.element(:css, "drawer.ng-isolate-scope[content-key='customer-agreement']")
  end

  def accessible_menu_rate_fee_long
    @browser.element(css: "div#modal.outer-container drawer.large-12.columns div.row.ng-scope.open").text
  end

  def accessible_menu_rate_fee_short
    #sleep 3
    # begin
    #   @browser.element(:css, "section.terms.rate-fee-short.container")
    # rescue
    #   @browser.elements(:css, "div.drawer")[1]
    # end
    @browser.element(css: "drawer.ng-isolate-scope[content-key = 'rate-fee-short']")
  end

  def accessible_menu_rate_fee_link
    #self.wait_for_some_time 3
    @browser.element(css: "ul#menu.animated li.ng-scope a.main-menu-link span.oui-icon-document.oui-icon-filled")
  end

  def accessible_menu_privacy_pdf_and_opt_out
    @browser.element(:link, "Privacy & Opt-Out Notice")
  end

  def privacy_pdf_and_opt_out
    @browser.element(:css, "drawer.ng-isolate-scope[content-key='privacy-opt-out']")
  end

  def income_text_box
    @browser.element(:id, "income")
  end

  def income_tool_tip
    @browser.element(css: "div.container-income tooltip.ng-isolate-scope div#tooltip-income")
  end

  def email_text_box
    @browser.element(id: "emailAddress")
  end

  def email_tool_tip
    @browser.element(css: " div.container-emailAddress tooltip.ng-isolate-scope div#tooltip-emailAddress")
  end

  def ssn_text_box
    @browser.element(:id, "taxId")
  end

  def ssn_tool_tip
   # @browser.element(css: "field.ng-scope.ng-isolate-scope div.container-taxId tooltip.ng-isolate-scope div#tooltip-taxId")
    @browser.element(css: "div.container-taxId tooltip.ng-isolate-scope div#tooltip-taxId")
  end


  def inline_errors
    @browser.elements(class: "errormsg")
  end

  def footer
    @browser.elements(:css => "footer.row a")
  end

  def privacy_statement_center
    @browser.element(:css => "footer.row div.large-12.columns div.ng-scope div.ng-binding")
  end

  def get_privacy_statement_text
    wait_for_some_time
    @browser.elements(:css => "footer.row div.large-12.columns div.ng-scope div.ng-binding p")[0].text +
        @browser.elements(:css => "footer.row div.large-12.columns div.ng-scope div.ng-binding p")[1].text
  end

  def privacy_statement
    @browser.element(:css => "footer.row div.large-12.columns div.ng-scope div.ng-binding p.center")
  end

  def first_name_text_field
    @browser.text_field(:id => "firstName")
  end

  def header_product_detail
    @browser.element(css: "app-header section.container.head h1")
  end

  def header_product_detail_body
    @browser.element(css: "div.productDetails.animated")
    # @browser.element(css: "productDetails-body")
  end

  def header_product_details_expander
    @browser.element(:css, "h2.productDetails-title span")
  end

  def header_heading
    wait_for_some_time
    @browser.element(:css => "h1.ng-binding")
    # @browser.element(css: "app-header section.container.head h1.ng-binding")
  end

  def continue_submit_button
   # wait_for_some_time
    @browser.element(id: "apply-continue")
  end

  def form_end_error
    @browser.elements(:css, "div.errorSum ul li button.ng-binding")
  end
end