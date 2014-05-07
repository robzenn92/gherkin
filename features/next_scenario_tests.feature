# language: en
Feature: Gherkin Feature lexer
  In order to make it easy to control the Gherkin syntax
  As a Gherkin developer bent on Gherkin world-domination
  I want a feature lexer that uses a feature parser to
  make all the syntax decisions for me

  Background: 
    Given a "ruby" "root" parser

    Scenario: Without Next Scenario keyword
    Given the following text is parsed:
      """
      Feature: Test
        Scenario: name of the scenario
          Given I have the following fruits in my pantry
          When I have the following fruits in my pantry
          Then I have the following fruits in my pantry
      """
    Then there should be no parse errors

    Scenario: Single Next Scenario keyword before EOF
    Given the following text is parsed:
      """
      Feature: Test
        Scenario: name of the scenario
          Given I have the following fruits in my pantry
          When I have the following fruits in my pantry
          Then I have the following fruits in my pantry

        Next Scenario: Login
      """
    Then there should be no parse errors

    Scenario: Multiple Next Scenario keywords before EOF
    Given the following text is parsed:
      """
      Feature: Test
        Scenario: name of the scenario
          Given I have the following fruits in my pantry
          When I have the following fruits in my pantry
          Then I have the following fruits in my pantry

        Next Scenario: Login
        Next Scenario: Logout
        Next Scenario: CreateOffer
      """
    Then there should be no parse errors

    Scenario: One scenario with Next Scenario keyword, one without it
    Given the following text is parsed:
      """
      Feature: Test
        Scenario: name of the scenario
          Given I have the following fruits in my pantry
          When I have the following fruits in my pantry
          Then I have the following fruits in my pantry

        Next Scenario: Login
        Next Scenario: Logout

        Scenario: name of the scenario
          Given I have the following fruits in my pantry
          When I have the following fruits in my pantry
          Then I have the following fruits in my pantry
      """
    Then there should be no parse errors

    Scenario: Multiple Next Scenario for each scenario in the feature
    Given the following text is parsed:
      """
      Feature: Test
        Scenario: scenario1
          Given I have the following fruits in my pantry
          When I have the following fruits in my pantry
          Then I have the following fruits in my pantry

        Next Scenario: scenario2
        Next Scenario: scenario3

        Scenario: scenario2
          Given I have the following fruits in my pantry
          When I have the following fruits in my pantry
          Then I have the following fruits in my pantry

        Next Scenario: scenario1
        Next Scenario: scenario3

        Scenario: scenario3
          Given I have the following fruits in my pantry
          When I have the following fruits in my pantry
          Then I have the following fruits in my pantry

        Next Scenario: scenario3
      """
    Then there should be no parse errors
