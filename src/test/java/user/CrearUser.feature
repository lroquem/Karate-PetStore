Feature: Crear usuario en Swagger PetStore

  Background:
    * url 'https://petstore.swagger.io/v2'
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'

  Scenario: Crear usuario exitosamente con datos válidos
    Given path 'user'
    And request
      """
      {
        "id": 1001,
        "username": "usuario_juan",
        "firstName": "juan",
        "lastName": "perez",
        "email": "juan@test.com",
        "password": "123456",
        "phone": "999999999",
        "userStatus": 1
      }
      """
    When method POST
    Then status 200
    And match response.message == "1001"

  Scenario: Error al crear usuario con id inválido (string en vez de número)
    Given path 'user'
    And request
      """
      {
        "id": "abc",
        "username": "usuario_luis",
        "firstName": "luis",
        "lastName": "perez",
        "email": "luis@test.com",
        "password": "xyz123",
        "phone": "966666666",
        "userStatus": 1
      }
      """
    When method POST
    Then status 500

  Scenario: Error al crear usuario sin username
    Given path 'user'
    And request
      """
      {
        "id": 2001,
        "firstName": "pedro",
        "lastName": "perez",
        "email": "pedro@test.com",
        "password": "123456",
        "phone": "977777777",
        "userStatus": 1
      }
      """
    When method POST
    Then status 500

  Scenario: Error al crear usuario sin body en el request
    Given path 'user'
    And request {}
    When method POST
    Then status 500
