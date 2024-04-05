#Author: your.email@your.domain.com
#Keywords Summary :
#Feature: List of scenarios.
#Scenario: Business rule through list of steps with arguments.
#Given: Some precondition step
#When: Some key actions
#Then: To observe outcomes or validation
#And,But: To enumerate more Given,When,Then steps
#Scenario Outline: List of steps for data-driven as an Examples and <placeholder>
#Examples: Container for s table
#Background: List of steps run before each of the scenarios
#""" (Doc Strings)
#| (Data Tables)
#@ (Tags/Labels):To group Scenarios
#<> (placeholder)
#""
## (Comments)
#Sample Feature Definition Template
@tag
Feature: Fetch test data from ODS Test API for CCE_CORP_BAN feature file
  I want to use this template for my feature file

Background: some resuable code
    * url baseURL
    And configure ssl = true
    And header Content-Type = 'application/json'
    And header env = env
    And header Authorization = 'Bearer '+authInfo.response.access_token
    * print mockResponseWLS_CORP_ACTIVE
    * print mockResponseWLS_CORP_SUSPENDED
    * print mockResponseWLS_CORP_CANCELLED

	@getdataCorpActive
  Scenario: WLS_REZ_BIZ_Active_Account
    Given path 'customer/contactCenterOdsData/v1/account'
    And param lob = 'WIRELESS'
    And param businessUnit = 'CORP'
    And param brand = 'TELUS'
    And param limit = '1'
    And param status = 'ACTIVE'
    When method get
    And print response
    And def mockResponseWLS_CORP_ACTIVE = response
    And karate.write(response, "testdata/output.json")
    * print mockResponseWLS_CORP_ACTIVE

	@getdataCorpSuspended
  Scenario: WLS_REZ_BIZ_Active_Account
    Given path 'customer/contactCenterOdsData/v1/account'
    And param lob = 'WIRELESS'
    And param businessUnit = 'CORP'
    And param brand = 'TELUS'
    And param limit = '1'
    And param status = 'SUSPENDED'
    When method get
    And print response
    And def mockResponseWLS_CORP_SUSPENDED = response
    And karate.write(response, "testdata/output.json")
    * print mockResponseWLS_CORP_SUSPENDED
    
  @getdataCorpCancelled
  Scenario: WLS_REZ_BIZ_Active_Account
    Given path 'customer/contactCenterOdsData/v1/account'
    And param lob = 'WIRELESS'
    And param businessUnit = 'CORP'
    And param brand = 'TELUS'
    And param limit = '5'
    And param status = 'Cancelled'
    When method get
    And print response
    And def mockResponseWLS_CORP_CANCELLED = response
    And karate.write(response, "testdata/output.json")
    * print mockResponseWLS_CORP_CANCELLED