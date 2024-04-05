Feature: Validate response for different WLS/WLN Customers with different account status and product type.

  Background: 
    * url baseURL
    * configure ssl = true
    * header accept = 'application/json'
    * header env = env
    * configure readTimeout = 20000
    * header Authorization = 'Bearer '+authInfo.response.access_token;
    * print authInfo.response.access_token
    * def data_file = 'tn_business_feature_bu_r_'+env+'.json'
    #* def data_file1 = 'tn_business_feature_bu_b_'+env+'.json'
    * def mockResponseWLS_BIZ_ACTIVE = callonce read("../data/getTestData_TN_Business_IT01.feature@getdatabizWLS")
    #* def data_file2 = 'tn_business_feature_cancel_'+env+'.json'
    #* def data_file3 = 'tn_business_feature_suspnded_'+env+'.json'
    * def mockResponseWLS_BIZ_SUSPENDED = callonce read("../data/getTestData_TN_Business_IT01.feature@getdatabizWLS_Suspended")
    #* def data_file4 = 'tn_business_feature_accts_prodts_'+env+'.json'
    * def data_file5 = 'tn_feature_data_'+env+'_morethan3acct.json'
    # * def data_file7 = 'tn_Cods_business_customer-account_feature_data_'+env+'.json'
    * def mockResponseWLN_BIZ_ACTIVE = callonce read("../data/getTestData_TN_Business_IT01.feature@getdatabizWLN")

  #* def data_file8 = 'tn_kb_business_customer-account_feature_data_'+env+'.json'
  #Scenario Outline: TC001_CCCI_API_GET_Business_TN_BU R Accounts_200
    #Given path 'customer/contactCenterCustomerInfo/v1/account'
    #And param tn = '<request_tn>'
    #When method get
    #Then status 200
    #And match response.accountList[*].billingType == ["postpaid"]
    #And match response.accountList[*].accountTypeCd == ["B"]
    #And match response.accountList[*].businessUnit == ["res"]
#
    #Examples: 
      #| read('classpath:data/'+data_file) |

  Scenario Outline: TC001_CCCI_API_GET_WLS_Business_TN_status_active_BizUnit_B Accounts_200
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    When method get
    Then status 200
    #And match response.accountList[*].billingType == ["postpaid"]
    And match response.accountList[*].accountTypeCd == ["B"]
    And match response.accountList[*].businessUnit == ["biz"]

    Examples: 
      #| read('classpath:data/'+data_file1) |
      | mockResponseWLS_BIZ_ACTIVE.mockResponseWLS_BIZ_ACTIVE |

  #Scenario Outline: TC004_CCCI_API_GET_Business_Cancelled_200
  #Given path 'customer/contactCenterCustomerInfo/v1/account'
  # And param tn = '<request_tn>'
  #When method get
  # Then status 200
  # And match response.accountList[*].billingType == ["postpaid"]
  #And match response.accountList[*].accountTypeCd == ["B"]
  # And match response.accountList[*].state == ["cancelled"]
  #Examples:
  #| read('classpath:data/'+data_file2) |
  Scenario Outline: TC002_CCCI_API_GET_Business_status_suspended_200
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    And param ban = '<ban>'
    When method get
    Then status 200
    # And match response.accountList[*].billingType == ["postpaid"]
    And match response.accountList[*].accountTypeCd == ["B"]
    And match response.accountList[*].products[*].statusCd == ["suspended"]

    Examples: 
      #| read('classpath:data/'+data_file3) |
      | mockResponseWLS_BIZ_SUSPENDED.mockResponseWLS_BIZ_SUSPENDED |

  Scenario Outline: TC003_CCCI_API_GET_Business_accountsandproducts_200
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    When method get
    Then status 200
    And match response.accountList[*].billingType == ["postpaid"]
    And match response.accountList[*].accountTypeCd == ["B"]
    And match response.accountList[*].state == ["active"]
    # And match response.accountList[*].products[*].networkType == ["H"] [This particular response match is not feasible everytime as the networkType can vary (C/H), hence removing this conmatch condition.]
    And match response.accountList[*].products[*].productTypeCd == ["C"]

    Examples: 
      #| read('classpath:data/'+data_file4) |
      | mockResponseWLS_BIZ_ACTIVE.mockResponseWLS_BIZ_ACTIVE |

  Scenario Outline: TC004_CCCI_API_GET_Business_morethan3Accounts_200
    # This scenario can't be executed with dynamic data from Test API as it specifically tests for a suscriber count of more than 3
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<request_tn>'
    When method get
    Then status 200
    #And match response.accountList[*].billingType == ["postpaid"]
    And match response.accountList[*].accountTypeCd == ["B"]

    Examples: 
      | read('classpath:data/'+data_file5) |

  Scenario Outline: TC005_CCCI_API_GET_Cods_WLN_Business_customeraccount_200
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    When method get
    Then status 200
    #And match response.accountList[*].billingType == ["postpaid"]
    And match response.accountList[*].accountTypeCd == ["B"]
    And match response.accountList[*].businessUnit == ["biz"]

    Examples: 
      #| read('classpath:data/'+data_file7) |
      | mockResponseWLN_BIZ_ACTIVE.mockResponseWLN_BIZ_ACTIVE |

#Scenario Outline: TC007_CCCI_API_GET_kb_Business_customeraccount_200
  # This is the same validation as in TC002 in this feature. We should remove this from our suite.
  #  Given path 'customer/contactCenterCustomerInfo/v1/account'
  #  And param tn = '<request_tn>'
  #  When method get
  #  Then status 200
    #And match response.accountList[*].billingType == ["postpaid"]
  #  And match response.accountList[*].accountTypeCd == ["B"]
  #  #And match response.accountList[*].businessUnit == ["biz"]
  #  Examples: 
  #    | read('classpath:data/'+data_file8) |