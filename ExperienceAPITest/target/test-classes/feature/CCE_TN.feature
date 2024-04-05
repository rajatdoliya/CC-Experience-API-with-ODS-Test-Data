#Author: your.email@your.domain.com
#Keywords Summary :
#Feature: List of scenarios.
#Scenario: TC001_Get_CCE_tn_Info
Feature: Validate the response for different TNs

  Background: 
    * url baseURL
    * configure ssl = true
    * header accept = 'application/json'
    * header env = env
    * configure readTimeout = 20000
    * header Authorization = 'Bearer '+authInfo.response.access_token;
    * print authInfo.response.access_token
    * def data_file = 'tn_feature_data_'+env+'.json'
    * def data_file1 = 'tn_kb_corp_Customer-account_feature_data_'+env+'.json'

  Scenario Outline: TC001_Get_CCE_tn_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<request_tn>'
    When method get
    Then status 200
    And match response.accountList[*].billingType == ["postpaid"]

    Examples: 
      | read('classpath:data/'+data_file) |

  Scenario Outline: TC001_Get_CCE_kb_tn_Corp_customeraccount_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<request_tn>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["C"]
    #And match response.accountList[*].businessUnit == ["corp"]

    Examples: 
      | read('classpath:data/'+data_file1) |
