#Author: rajat.nolastname@telus.com
#Keywords Summary :
#Feature: List of scenarios.
#Scenario: TC001_Get_CCE_tn_Info
Feature: Validate the CCCI API response payload for WLS/WLN TN and BAN combinations.

  Background: 
    * url baseURL
    * configure ssl = true
    * header accept = 'application/json'
    * header env = env
    * configure readTimeout = 20000
    * header Authorization = 'Bearer '+authInfo.response.access_token;
    * print authInfo.response.access_token
    #* def data_file = 'tn_ban_feature_data_'+env+'.json'
    * def mockResponseWLS_RES_ACTIVE = callonce read("../data/getTestData_Consumer_IT01.feature@getdata_resWLS_Active")
    #* def data_file2 = 'tn_ban_Cods_business_customer-account_feature_data_'+env+'.json'
    * def mockResponseWLN_BIZ_ACTIVE = callonce read("../data/getTestData_TN_Business_IT01.feature@getdatabizWLN")
    #* def data_file3 = 'tn_ban_kb_business_customer-account_feature_data_'+env+'.json'
    * def mockResponseWLS_BIZ_ACTIVE = callonce read("../data/getTestData_TN_Business_IT01.feature@getdatabizWLS")
    #* def data_file4 = 'tn_ban_kb_corp_customer-account_feature_data_'+env+'.json'
    * def mockResponseWLS_CORP_ACTIVE = callonce read("../data/getTestData_CCE_CORP_BAN_IT01.feature@getdataCorpActive")

  Scenario Outline: TC001_Get_CCE_tn_BAN_CustomerInfo fetched against TN and BAN combination for WLS Consumer
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    And param ban = '<ban>'
    When method get
    Then status 200
    And assert response.accountList != null
    And assert response.accountList[0].domain == "wireless"

    Examples: 
      #| read('classpath:data/'+data_file) |
      | mockResponseWLS_RES_ACTIVE.mockResponseWLS_RES_ACTIVE |

  Scenario Outline: TC002_Get_CCE_tn_BAN_WLN_Business_CustomerInfo fetched for WLN Biz account against TN and BAN combination
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["B"]
    And match response.accountList[*].businessUnit == ["biz"]

    Examples: 
      #| read('classpath:data/'+data_file2) |
      | mockResponseWLN_BIZ_ACTIVE.mockResponseWLN_BIZ_ACTIVE |

  Scenario Outline: TC003_Get_CCE_tn_BAN_WLS_Business_CustomerInfo fetched for WLS Biz account against TN and BAN combination
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["B"]

    #And match response.accountList[*].businessUnit == ["biz"]
    Examples: 
      #| read('classpath:data/'+data_file3) |
      | mockResponseWLS_BIZ_ACTIVE.mockResponseWLS_BIZ_ACTIVE |
      

  Scenario Outline: TC004_Get_CCE_tn_BAN_kb_corp_CustomerInfo fetched for a WLS Corp account against TN and BAN combination
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["C"]
    #And match response.accountList[*].businessUnit == ["corp"]

    Examples: 
      #| read('classpath:data/'+data_file4) |
      | mockResponseWLS_CORP_ACTIVE.mockResponseWLS_CORP_ACTIVE |
