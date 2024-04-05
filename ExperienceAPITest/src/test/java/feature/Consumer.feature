Feature: Validate the response for different bans

  Background: 
    * url baseURL
    * configure ssl = true
    * header accept = 'application/json'
    * header env = env
    * configure readTimeout = 20000
    * header Authorization = 'Bearer '+authInfo.response.access_token;
    * print authInfo.response.access_token
    #* def data_file = 'tn_Consumer_feature_data_'+env+'.json'
    * def mockResponseWLS_RES_ACTIVE = callonce read("../data/getTestData_Consumer_IT01.feature@getdata_resWLS_Active")
    #* def data_file1 = 'tn_Consumer_feature_suspnded_'+env+'.json'
    * def mockResponseWLS_RES_SUSPENDED = callonce read("../data/getTestData_Consumer_IT01.feature@getdata_resWLS_Suspended")
    #* def data_file2 = 'tn_Consumer_feature_cancel_'+env+'.json'
    #* def data_file3 = 'ban_Consumer_feature_prepaid_data_'+env+'.json'
    #* def data_file4 = 'tn_Cods_Consumer_Customer-account_feature_data_'+env+'.json'
    * def mockResponseWLN_RES_ACTIVE = callonce read("../data/getTestData_Consumer_IT01.feature@getdata_resWLN_Active")
    #* def data_file5 = 'tn_ban_Cods_consumer_customer-account_feature_data_'+env+'.json'
    #* def data_file6 = 'ban_Cods_Consumer_customer-account_data_'+env+'.json'
    #* def data_file7 = 'ban_kb_Consumer_customer-account_data_'+env+'.json'
    #* def data_file8 = 'tn_kb_Consumer_Customer-account_feature_data_'+env+'.json'
    #* def data_file9 = 'tn_ban_kb_consumer_customer-account_feature_data_'+env+'.json'

  #* def data_file3 = 'tn_business_feature_suspnded_'+env+'.json'
  #* def data_file4 = 'tn_business_feature_accts_prodts_'+env+'.json'
  #* def data_file5 = 'tn_feature_data_'+env+'_morethan3acct.json'
  
  Scenario Outline: TC001_CCCI_API_GET_Consumer_TN_BU R Accounts_200
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    When method get
    Then status 200
    And match response.accountList[*].billingType == ["postpaid"]
    And match response.accountList[*].accountTypeCd == ["I"]

    #And match response.accountList[*].businessUnit == ["R"]
    Examples: 
      #| read('classpath:data/'+data_file) |
      | mockResponseWLS_RES_ACTIVE.mockResponseWLS_RES_ACTIVE |

  #Examples:
  #| read('classpath:data/'+data_file1) |
  #Scenario Outline: TC004_CCCI_API_GET_Consumer_Cancelled_200
  #Given path 'customer/contactCenterCustomerInfo/v1/account'
  # And param tn = '<request_tn>'
  # When method get
  #Then status 200
  # And match response.accountList[*].billingType == ["postpaid"]
  #And match response.accountList[*].accountTypeCd == ["I"]
  #And match response.accountList[*].state == ["cancelled"]
  #Examples:
  #| read('classpath:data/'+data_file2) |
  Scenario Outline: TC002_CCCI_API_GET_WLS_RES_Consumer_suspended_200
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    When method get
    Then status 200
    #And match response.accountList[*].billingType == ["postpaid"]
    #And match response.accountList[*].accountTypeCd == ["I"] #This condition may fail as account type is depended on Ban Segment and subsegment#
    And match response.accountList[*].state == ["suspended"]

    Examples: 
      #| read('classpath:data/'+data_file1) |
      | mockResponseWLS_RES_SUSPENDED.mockResponseWLS_RES_SUSPENDED |

  Scenario Outline: TC003_Get_CCE_Ban_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    When method get
    Then status 200
    #And match response.accountList[*].billingType == ["prepaid"]
    And match response.accountList[*].accountTypeCd == ["I"]

    Examples: 
      #| read('classpath:data/'+data_file3) |
      | mockResponseWLS_RES_ACTIVE.mockResponseWLS_RES_ACTIVE |

  Scenario Outline: TC004_CCCI_API_GET_Cods_tn_Consumer_customeraccount_200
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    When method get
    Then status 200
    #And match response.accountList[*].billingType == ["postpaid"]
    And match response.accountList[*].accountTypeCd == ["R"]
    And match response.accountList[*].businessUnit == ["res"]

    Examples: 
      #| read('classpath:data/'+data_file4) |
      | mockResponseWLN_RES_ACTIVE.mockResponseWLN_RES_ACTIVE |

  Scenario Outline: TC005_Get_CCE_tn_BAN_Cods_Consumer_customeraccount_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["R"]
    And match response.accountList[*].businessUnit == ["res"]

    Examples: 
      #| read('classpath:data/'+data_file5) |
      | mockResponseWLN_RES_ACTIVE.mockResponseWLN_RES_ACTIVE |

  Scenario Outline: TC006_Get_CCE_Ban_Cods_customer_consumer_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["R"]
    And match response.accountList[*].businessUnit == ["res"]

    Examples: 
      #| read('classpath:data/'+data_file6) |
      | mockResponseWLN_RES_ACTIVE.mockResponseWLN_RES_ACTIVE |

  Scenario Outline: TC007_Get_CCE_Ban_kb_customer_consumer_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["I"]
    And match response.accountList[*].businessUnit == ["res"]

    Examples: 
      #| read('classpath:data/'+data_file7) |
      | mockResponseWLS_RES_ACTIVE.mockResponseWLS_RES_ACTIVE |

  Scenario Outline: TC008_CCCI_API_GET_kb_tn_Consumer_customeraccount_200
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    When method get
    Then status 200
    #And match response.accountList[*].billingType == ["postpaid"]
    And match response.accountList[*].accountTypeCd == ["I"]
    And match response.accountList[*].businessUnit == ["res"]

    Examples: 
      #| read('classpath:data/'+data_file8) |
      | mockResponseWLS_RES_ACTIVE.mockResponseWLS_RES_ACTIVE |

  Scenario Outline: TC009_CCCI_API_GET_kb_tn_ban_Consumer_customeraccount_200
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["I"]
    And match response.accountList[*].businessUnit == ["res"]

    Examples: 
      #| read('classpath:data/'+data_file9) |
      | mockResponseWLS_RES_ACTIVE.mockResponseWLS_RES_ACTIVE |
