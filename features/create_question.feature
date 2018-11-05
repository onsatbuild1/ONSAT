Feature: Create Question
  As a user
  In order to evaluate risk
  I want to create a question

  Scenario: Questions page shown
    Given I am on the questions page
    Then I should see "Outsourcing of Network Services Assessment Tool"
    And I should see "All Questions"
    
  Scenario: Create Questions page shown
    Given I am on the questions page
    When I follow "Add new question"
    Then I should see "Create New Question"

#creating question is broken and we don't have to implement it    
  Scenario: Questions are created
    Given I am on the new question page
    When I fill in "question_keyword" with "TestQuestion"
    And I fill in "question_description" with "This is a test"
    And I fill in "question_answer" with "This question has no response"
    And I fill in "question_weight" with "0"
    And I press "Save Changes"
    Then I should be on the questions page
    And I should see "TestQuestion"
    
  # sad paths
  
  Scenario: Wrong Questions are not created
    Given I am on the new question page
    When I fill in "question_keyword" with ""
    And I fill in "question_description" with "This is a test"
    And I fill in "question_answer" with "This question has no response"
    And I fill in "question_weight" with "0"
    Then I should be on the new question page
    And the "Save Changes" button should be disabled