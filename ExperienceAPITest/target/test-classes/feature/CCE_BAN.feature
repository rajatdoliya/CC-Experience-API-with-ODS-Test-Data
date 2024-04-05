#Author: your.email@your.domain.com
#Keywords Summary :
#Feature: List of scenarios.
#Scenario: TC001_Get_CCE_Ban_Info
Feature: Validate the response for different bans

  Background: 
    * url baseURL
    * configure ssl = true
    * header accept = 'application/json'
    * header env = env
    * configure readTimeout = 20000
    * header Authorization = 'Bearer '+authInfo.response.access_token;
    * print authInfo.response.access_token
    #* def data_file = 'ban_feature_data_'+env+'.json'
     * def mockResponseWLS_REZ = callonce read("../data/getTestData_CCE_BAN_IT01.feature@getdatarezWLS")
     
   # * def data_file2 = 'ban_Cods_Business_customer-account_data_'+env+'.json'
    * def mockResponseWLN_BIZ = callonce read("../data/getTestData_CCE_BAN_IT01.feature@getdatabizWLN")
   # * def data_file3 = 'ban_kb_business_customer-account_data_'+env+'.json'
    * def mockResponseWLS_BIZ = callonce read("../data/getTestData_CCE_BAN_IT01.feature@getdatabizWLS")
       
    * print mockResponseWLS_REZ
    * print mockResponseWLN_BIZ
    * print mockResponseWLS_BIZ

  Scenario Outline: TC001_Get_CCE_Ban_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    When method get
    Then status 200

    Examples: 
      | mockResponseWLS_REZ.mockResponseWLS_REZ |

  Scenario Outline: TC003_Get_CCE_Ban_Cods_customer_Business_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["B"]
    And match response.accountList[*].businessUnit == ["biz"]
    And match response.accountList[*].domain == ["wireline"]

    Examples: 
     # | read('classpath:data/'+data_file2) |
      | mockResponseWLN_BIZ.mockResponseWLN_BIZ |

  Scenario Outline: TC003_Get_CCE_Ban_kb_customer_Business_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["B"]
    And match response.accountList[*].domain == ["wireless"]

    #And match response.accountList[*].businessUnit == ["biz"]
    Examples: 
     # | read('classpath:data/'+data_file3) |
      | mockResponseWLS_BIZ.mockResponseWLS_BIZ |