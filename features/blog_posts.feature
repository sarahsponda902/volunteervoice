Feature: Managing Blog Posts
  In order to CRUD the Blog Posts
  As an admin
  
Scenario: Approving Admins
    Given I am signed in as an owner
	And There is an admin pending approval with email "approve_me@approve_me.com"
    When I go to the list of admins
    Then I should see "Listing Admins"