Feature: Submit a file to Outsourcing of Network Services Assessment Tool System
As a user of the system
I should be able to upload a csv file to the system

Scenario: Submit an existing form to and display the question list
Given I am on the upload page
And I choose the file and press upload
Then the file should be parsed
And the content is stored in the database
And I should see the page of questions listed

#sad paths

Scenario: No file and try to upload
Given I am on the upload page
And I do not choose a file but press upload
Then the page should stay the same

Scenario: Try to upload twice
  Given I am on the upload page
  And I upload the same file twice
  Then the page should not list duplicates