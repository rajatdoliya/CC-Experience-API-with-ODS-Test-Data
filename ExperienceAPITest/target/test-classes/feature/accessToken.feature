#Author: your.email@your.domain.com
#Keywords Summary :
#Feature: Generate Access Oauth2 token
#Scenario: get access token
Feature: Get access token

  Background: 
    * url authTokenURL
    * configure ssl = true
    * form field grant_type = 'client_credentials'
    * form field client_id = karate.properties['clientId']
    * form field client_secret = karate.properties['clientSecret']
    * form field scope = '1987 3987'

  Scenario: Generate access token
    Given url authTokenURL
    And header accept = 'application/json'
    When method post
    Then status 200
    And print response
