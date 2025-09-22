Feature: Modificar usuario en Swagger PetStore

  Background:
    * url 'https://petstore.swagger.io/v2'
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'
    * def sleep = function(millis){ java.lang.Thread.sleep(millis) }

  Scenario: Actualizar usuario existente con datos válidos
    Given path 'user', 'usuario_juan'
    And retry until responseStatus == 200
    When method GET
    Then status 200

    Given path 'user', 'usuario_juan'
    And retry until responseStatus == 200
    And request
      """
      {
        "id": 1001,
        "username": "usuario_juan",
        "firstName": "juanMod",
        "lastName": "perezMod",
        "email": "juan.mod@test.com",
        "password": "654321",
        "phone": "900000000",
        "userStatus": 1
      }
      """
    When method PUT
    Then status 200
    And match response.message == "1001"

    # Verificar modificaciones con GET
    Given path 'user', 'usuario_juan'
    And retry until responseStatus == 200 && response.firstName == "juanMod"
    When method GET
    Then status 200
    And match response.firstName == "juanMod"
    And match response.lastName == "perezMod"
    And match response.email == "juan.mod@test.com"
    And match response.phone == "900000000"

  Scenario: Error al actualizar un usuario que no existe
    * def userID = 'user_' + java.util.UUID.randomUUID().toString()
    # Verificar que no existe con GET
    Given path 'user', userID
    When method GET
    Then status 404

    # Modificar
    Given path 'user', userID
    And request
      """
      {
        "id": 2001,
        "username": #(userID),
        "firstName": "No",
        "lastName": "Existe",
        "email": "no.existe@test.com",
        "password": "123456",
        "phone": "977777777",
        "userStatus": 1
      }
      """
    When method PUT
    Then status 404

  Scenario: Error al actualizar usuario con body vacío
    Given path 'user', 'usuario_juan'
    And request {}
    When method PUT
    Then status 500

  Scenario: Error al actualizar usuario con ID inválido (string en lugar de número)
    Given path 'user', 'usuario_juan'
    And request
      """
      {
        "id": "abc",
        "username": "usuario_test",
        "firstName": "Luis",
        "lastName": "Torres",
        "email": "luis.torres@test.com",
        "password": "xyz123",
        "phone": "966666666",
        "userStatus": 1
      }
      """
    When method PUT
    Then status 500
