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
    #* def data_file = 'ban_Corporate_feature_data_'+env+'.json'
    * def mockResponseWLS_CORP_ACTIVE = callonce read("../data/getTestData_CCE_CORP_BAN_IT01.feature@getdataCorpActive")
    #* def data_file1 = 'ban_Corporate_feature_Suspended_data_'+env+'.json'
    * def mockResponseWLS_CORP_SUSPENDED = callonce read("../data/getTestData_CCE_CORP_BAN_IT01.feature@getdataCorpSuspended")
    #* def data_file2 = 'ban_kb_corp_customer-account_data_'+env+'.json'
    * def mockResponseWLS_CORP_CANCELLED = callonce read("../data/getTestData_CCE_CORP_BAN_IT01.feature@getdataCorpCancelled")

  #* def data_file2 = 'ban_Corporate_feature_Canceled_data_'+env+'.json'
  Scenario Outline: TC001_Get_CCE_Ban_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].billingType == ["postpaid"]
    And match response.accountList[*].accountTypeCd == ["C"]
    * print response
    * print mockResponseWLS_CORP_ACTIVE

    #And match response.accountList[*].businessUnit == ["R"]
    Examples: 
      | mockResponseWLS_CORP_ACTIVE.mockResponseWLS_CORP_ACTIVE |

  Scenario Outline: TC002_Get_CCE_Ban_Suspended_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    And param tn = '<tn>'
    When method get
    Then status 200
    #And match response.accountList[*].billingType == ["postpaid"]
    And match response.accountList[*].accountTypeCd == ["C"]
    And match response.accountList[*].products[*].statusCd == ["suspended"]
    * print response
    * print mockResponseWLS_CORP_SUSPENDED

    Examples: 
      #| read('classpath:data/'+data_file1) |
      | mockResponseWLS_CORP_SUSPENDED.mockResponseWLS_CORP_SUSPENDED |

  #Examples:
  #| read('classpath:data/'+data_file2) |
  Scenario Outline: TC002_Get_CCE_Ban_kb_corp_Cancelled_Info
  	* print mockResponseWLS_CORP_CANCELLED
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    And param tn = '<tn>'
    When method get
    Then status 200
    #And match response.accountList[*].billingType == ["postpaid"]
    And match response.accountList[*].accountTypeCd == ["C"]
    #And match response.accountList[*].products[*].statusCd == ["cancelled"]
    
    * print response

    Examples: 
      #| read('classpath:data/'+data_file2) |
      | mockResponseWLS_CORP_CANCELLED.mockResponseWLS_CORP_CANCELLED |
