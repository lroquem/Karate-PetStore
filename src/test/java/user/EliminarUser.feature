Feature: Eliminar usuario en Swagger PetStore

  Background:
    * url 'https://petstore.swagger.io/v2'
    * header Content-Type = 'application/json'
    * configure retry = { count: 5, interval: 2000 }

  Scenario: Eliminar un usuario existente
    Given path 'user', "usuario_juan"
    And retry until responseStatus == 200
    When method delete
    Then status 200

    Given path 'user', "usuario_juan"
    And retry until responseStatus == 404
    When method get
    Then status 404

  Scenario: Eliminar usuario inexistente
    * def userID = 'user_' + java.util.UUID.randomUUID().toString()
    Given path 'user', userID
    When method delete
    Then status 404

  Scenario: Eliminar usuario con username vacío
    Given path 'user', ''
    When method delete
    Then status 405
