@homepage_page1
Feature: Menard Homepage
  As a user
  I want to
  Register to menard's big

#  @watir
#  Scenario: verify the label on registration page
#    Given I am on registration home page
#    When I see first name label
#     Then I should see first name

#Excel reading scenario
  @watir
  Scenario: Read the worksheet with sheet name
    Given I have worksheet
    When I provide sheet name Global Footer
    Then I should see same sheet object


  @watir
  Scenario: Verify the global footer on homepage
    Given I am on registration home page
    When I look for Global Footer
    Then I should see correct footer links
    And correct privacy statement

  @watir
  Scenario: Verify the global header on homepage
    Given I am on registration home page
    When I look for Global Header
    Then I should see correct header heading
    And correct header product details

  @watir
   Scenario Outline: Verify all the footer links
     Given I am on registration home page
     When I should look for <footer_links>
     Then I should see the correct <footer_links> is opened
    Examples:
     |footer_links                |
     |Privacy & Security          |
     |FAQs                        |
     |Contact Us                  |
     |Website Terms & Conditions  |
     |Accessibility               |

  @watir
  Scenario: Verify hamburger menu privacy link
    Given I am on registration home page
    When I select hamburger menu
    Then I should see the correct Privacy & Security is opened

#  @watir
#  Scenario: Verify privacy pdf and opt out
#    Given I am on registration home page
#    When I select privacy pdf and opt out
#  Then I should see the modal title Jordan's Furniture PowerCharge® Card Important Disclosures

#    Error Messages
  @watir
  Scenario: Verify the error messages
    Given I am on registration home page
    When I select continue button
    Then I should error message inline
    And see consolidate error messages in the end of the page

#Tool Tips
  @watir
  Scenario: Verify the tool tips
    Given I am on registration home page
    When I select social security number
    And I select social income
    Then I should see tool tips

# FAQS content
  @watir
  Scenario: Verify the FAQS in accessible menu
    Given I am on registration home page
    When I select accessible menu
    Then I should see the correct FAQS

    #Pre Decision Long AOD
  @watir
  Scenario: Verify the Rate & Fee Information in accessible menu
    Given I am on registration home page
    When I select accessible menu
    Then I should see the correct long Rate & Fee Information

  @watir
  Scenario: verify the customer agreement in hamburger menu
    Given I am on registration home page
    When I select accessible menu
    Then I should see the correct customer agreement

  @watir
  Scenario:Verify privacy pdf and opt out
    Given I am on registration home page
    When I select accessible menu
    Then I should see the correct privacy pdf and opt out

