Feature: Submit all the answers
  As a user
  In order to update my answers to questions
  I need to be able to push submit the answers

  Scenario: Push button and the page refresh and gives a notice
    Given I am on the questions page
    Then I should see "Outsourcing of Network Services Assessment Tool"
    And I should see "All Questions"
    And I press submit
    Then I should see "Submission Pushed"