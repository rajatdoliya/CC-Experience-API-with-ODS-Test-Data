#Author: rajat.nolastname@telus.com

Feature: Fetch test data from ODS Test API for CCE_BAN feature file
  I want to use this template for my feature file

  Background: some resuable code
    * url baseURL
    And configure ssl = true
    And header Content-Type = 'application/json'
    And header env = env
    And header Authorization = 'Bearer '+authInfo.response.access_token
    * print mockResponseWLS_REZ
    * print mockResponseWLN_BIZ
    * print mockResponseWLS_BIZ

	@getdatarezWLS
  Scenario: WLS_REZ_BIZ_Active_Account
    Given path 'customer/contactCenterOdsData/v1/account'
    And param lob = 'WIRELESS'
    And param businessUnit = 'RES'
    And param brand = 'TELUS'
    And param limit = '1'
    And param status = 'ACTIVE'
    When method get
    And print response
    And def mockResponseWLS_REZ = response
    And karate.write(response, "testdata/output.json")
    * print mockResponseWLS_REZ

  @getdatabizWLN
  Scenario: Title of your scenario
    Given path 'customer/contactCenterOdsData/v1/account'
    And param lob = 'WIRELINE'
    And param businessUnit = 'BIZ'
    And param brand = 'TELUS'
    And param limit = '1'
    And param status = 'ACTIVE'
    When method get
    And print response
    And def mockResponseWLN_BIZ = response
    #And karate.write(response, "testdata/output.json")
    * print mockResponseWLN_BIZ
    
  @getdatabizWLS
  Scenario: Title of your scenario
    Given path 'customer/contactCenterOdsData/v1/account'
    And param lob = 'WIRELESS'
    And param businessUnit = 'BIZ'
    And param brand = 'TELUS'
    And param limit = '1'
    And param status = 'ACTIVE'
    When method get
    And print response
    And def mockResponseWLS_BIZ = response
    #And karate.write(response, "testdata/output.json")
    * print mockResponseWLS_BIZ