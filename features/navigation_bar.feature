Feature: Universal Navigation Bar
  As a user
  While using website
  I want to go to different pages

  Scenario: Questions page shown
    Given I am on the Home page
    When I follow "Input"
    Then I should see "All Questions"
    
  Scenario: Home page shown
    Given I am on the questions page
    When I follow "Home"
    Then I should see "home tab"
    
  Scenario: Output page shown
    Given I am on the questions page
    When I follow "Output"
    Then I should see "output page"
    
  Scenario: Formulae page shown
    Given I am on the questions page
    When I follow "Formulae"
    Then I should see "formulae tab"