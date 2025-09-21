Feature: Obtener usuario en Swagger PetStore

  Background:
    * url 'https://petstore.swagger.io/v2'
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'

  Scenario: Obtener un usuario existente por username
    Given path 'user', 'usuario_juan'
    When method GET
    Then status 200
    And match response.username == "usuario_juan"
    And match response.email == "juan@test.com"

  Scenario: Error al consultar un usuario con username vacío
    Given path 'user', ''
    When method GET
    Then status 405

  Scenario: Error al consultar un usuario que no existe
    Given path 'user', 'usuario_inexistente'
    When method GET
    Then status 404

  Scenario: Error al consultar un usuario con caracteres inválidos
    Given path 'user', '\@.{}'
    When method GET
    Then status 404
