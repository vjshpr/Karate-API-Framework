Feature:

Background: Login to Conduit App and Obtain Auth Token
    Given url 'https://conduit-api.bondaracademy.com/api'
    * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature') { email: 'karateuser100@test.com', password: 'Test1234' }
    * def authToken = tokenResponse.authToken

@ignore
Scenario: Create an Article
    Given path 'articles'
    Given header Authorization = 'Token ' + authToken
    Given request {"article": {"title": "Karate Article2","description": "About Karate APIs","body": "Karate API Automation","tagList": ["Karate, API,100"]}}
    When method Post
    Then status 201
    Then match response.article.title == "Karate Article2"

@debug
Scenario: Create and Delete an Article
    Given path 'articles'
    Given header Authorization = 'Token ' + authToken
    Given request {"article": {"title": "Delete Article","description": "Delete Karate APIs","body": "Karate DELETE API Automation","tagList": []}}
    When method Post
    Then status 201
    Then match response.article.title == "Delete Article"
    * def articleId = response.article.slug

    Given path 'articles'
    Given params { limit:20, offset:0 }
    Given header Authorization = 'Token ' + authToken
    When method Get
    Then status 200
    Then match response.articles[0].title == "Delete Article"

    Given path 'articles/' + articleId
    Given header Authorization = 'Token ' + authToken
    When method Delete
    Then status 204

    Given path 'articles'
    Given params { limit:10, offset:0 }
    When method Get
    Then status 200
    Then match response.articles[0].title != "Delete Article"