Feature: Home Page API Testing

Background: Define API Base URL
    Given url 'https://conduit-api.bondaracademy.com/api'

Scenario: Verify Tags in Home Page
    Given path 'tags'
    When method Get
    Then status 200
    Then match response.tags contains ['YouTube', 'Test']
    Then match response.tags !contains 'Amazon'
    Then match response.tags == "#array"
    Then match each response.tags == "#string"
    

Scenario: Verify Articles in Home Page
    Given path 'articles'
    Given params { limit:10, offset:0 }
    When method Get
    Then status 200
    Then print response
    And match response.articlesCount == 10
    And match response.articles[0].author.username == 'Artem Bondar'
    And match response.articles == "#[10]"