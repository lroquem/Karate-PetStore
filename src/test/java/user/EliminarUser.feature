Feature: Eliminar usuario en Swagger PetStore

  Background:
    * url 'https://petstore.swagger.io/v2'
    * header Content-Type = 'application/json'

  Scenario: Eliminar un usuario existente
    Given path 'user', "usuario_juan"
    When method delete
    Then status 200

    Given path 'user', "usuario_juan"
    And retry until responseStatus == 404
    When method get
    Then status 404

  Scenario: Eliminar usuario inexistente
    Given path 'user', 'hubhas74465485'
    When method delete
    Then status 404

  Scenario: Eliminar usuario con username vacío
    Given path 'user', ''
    When method delete
    Then status 405
