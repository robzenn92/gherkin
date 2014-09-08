# language: en
Feature: Gherkin Feature lexer
  In order to make it easy to control the Gherkin syntax
  As a Gherkin developer bent on Gherkin world-domination
  I want a feature lexer that uses a feature parser to
  make all the syntax decisions for me

  Background: 
    Given a "ruby" "root" parser

    Scenario: Without Next_Scenario keyword
    Given the following text is parsed:
      """
      Feature: Test
        Scenario: name of the scenario
          Given I have the following fruits in my pantry
          When I have the following fruits in my pantry
          Then I have the following fruits in my pantry
      """
    Then there should be no parse errors

    Scenario: Single Next_Scenario keyword after Scenario empty
    Given the following text is parsed:
      """
      Feature: Test
        Scenario: name of the scenario
        Next_Scenario: Login
      """
    Then there should be no parse errors

    Scenario: Single Next_Scenario keyword before EOF
    Given the following text is parsed:
      """
      Feature: Test
        Scenario: name of the scenario
          Given I have the following fruits in my pantry
          When I have the following fruits in my pantry
          Then I have the following fruits in my pantry

        Next_Scenario: Login
      """
    Then there should be no parse errors

    Scenario: Multiple Next_Scenario keywords before EOF
    Given the following text is parsed:
      """
      Feature: Test
        Scenario: name of the scenario
          Given I have the following fruits in my pantry
          When I have the following fruits in my pantry
          Then I have the following fruits in my pantry

        Next_Scenario: Login
        Next_Scenario: Logout
        Next_Scenario: CreateOffer
      """
    Then there should be no parse errors

    Scenario: One scenario with Next_Scenario keyword, one without it
    Given the following text is parsed:
      """
      Feature: Test
        Scenario: name of the scenario
          Given I have the following fruits in my pantry
          When I have the following fruits in my pantry
          Then I have the following fruits in my pantry

        Next_Scenario: Login
        Next_Scenario: Logout

        Scenario: name of the scenario
          Given I have the following fruits in my pantry
          When I have the following fruits in my pantry
          Then I have the following fruits in my pantry
      """
    Then there should be no parse errors

    Scenario: Multiple Next_Scenario for each scenario in the feature
    Given the following text is parsed:
      """
      Feature: Test
        Scenario: scenario1
          Given I have the following fruits in my pantry
          When I have the following fruits in my pantry
          Then I have the following fruits in my pantry

        Next_Scenario: scenario2
        Next_Scenario: scenario3

        Scenario: scenario2
          Given I have the following fruits in my pantry
          When I have the following fruits in my pantry
          Then I have the following fruits in my pantry

        Next_Scenario: scenario1
        Next_Scenario: scenario3

        Scenario: scenario3
          Given I have the following fruits in my pantry
          When I have the following fruits in my pantry
          Then I have the following fruits in my pantry

        Next_Scenario: scenario3
      """
    Then there should be no parse errors

    Scenario: A step after Next_Scenario keyword
    Given the following text is parsed:
      """
      Feature: Test
        Scenario: scenario1
          Given I have the following fruits in my pantry
          When I have the following fruits in my pantry
          Then I have the following fruits in my pantry

        Next_Scenario: scenario2
        Then I have the following fruits in my pantry

        Scenario: scenario2
          Given I have the following fruits in my pantry
          When I have the following fruits in my pantry
          Then I have the following fruits in my pantry

        Next_Scenario: scenario1
      """
    Then there should be some parse errors

    Scenario: A step after Next_Scenario keyword
    Given the following text is parsed:
      """
      Feature: Test
        Scenario: scenario1
          Given I have the following fruits in my pantry
          When I have the following fruits in my pantry
          And I have the following fruits in my pantry
          Next_Scenario: scenario2
          Then I have the following fruits in my pantry

        Scenario: scenario2
          Given I have the following fruits in my pantry
          When I have the following fruits in my pantry
          Then I have the following fruits in my pantry

        Next_Scenario: scenario1
      """
    Then there should be some parse errors
