Feature: Validate the response for different bans

  Background: 
    * url baseURL
    * configure ssl = true
    * header accept = 'application/json'
    * header env = env
    * configure readTimeout = 20000
    * header Authorization = 'Bearer '+authInfo.response.access_token;
    * print authInfo.response.access_token
    * def data_file = 'ban_feature_data_'+env+'_404.json'
    * def data_file1 = 'tn_feature_data_'+env+'_404.json'
    * def data_file2 = 'tn_ban_feature_data_'+env+'_404.json'
    * def data_file3 = 'tn_ban_feature_data_'+env+'_400.json'
    * def data_file4 = 'tn_feature_data_'+env+'_400.json'
    * def data_file5 = 'ban_feature_data_'+env+'_400.json'
    
   # * def mockResponse = callonce read("../data/getTestData.feature@getdata")

  Scenario Outline: TC001_notfounderror_Get_CCE_Ban_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    When method get
    Then status 404

    Examples: 
      | read('classpath:data/'+data_file) |

  Scenario Outline: TC001_notfounderror_Get_CCE_TN_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<request_tn>'
    When method get
    Then status 404

    Examples: 
      | read('classpath:data/'+data_file1) |

  Scenario Outline: TC001_notfounderror_Get_CCE_TN_BAN_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    And param ban = '<ban>'
    When method get
    Then status 404

    Examples: 
      | read('classpath:data/'+data_file2) |

  Scenario Outline: TC005_Invalid_Get_CCE_Ban_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    When method get
    Then status 400

    Examples: 
      | read('classpath:data/'+data_file5) |

  Scenario Outline: TC005_Invalid_Get_CCE_tn_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<request_tn>'
    When method get
    Then status 400

    Examples: 
      | read('classpath:data/'+data_file4) |

  Scenario Outline: TC001_Invalid_Get_CCE_TN_BAN_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    And param ban = '<ban>'
    When method get
    Then status 400

    Examples: 
      | read('classpath:data/'+data_file3) |
