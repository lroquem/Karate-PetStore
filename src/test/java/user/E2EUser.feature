Feature: Prueba E2E de User en Swagger PetStore

  Background:
    * url 'https://petstore.swagger.io/v2'
    * header Content-Type = 'application/json'
    * def username = 'user_e2e_' + java.util.UUID.randomUUID().toString()
    * def sleep = function(millis){ java.lang.Thread.sleep(millis) }
    * configure retry = { count: 5, interval: 2000 }

  Scenario: Crear, obtener, modificar y eliminar un usuario
    # Crear usuario
    Given path 'user'
    And request
      """
      {
        "id": 3001,
        "username": #(username),
        "firstName": "Jose",
        "lastName": "Valdivia",
        "email": "jose@test.com",
        "password": "1234",
        "phone": "999999999",
        "userStatus": 1
      }
      """
    When method post
    Then status 200

    # Obtener usuario creado
    Given path 'user', username
    And retry until responseStatus == 200
    When method get
    Then status 200
    And match response.username == username
    And match response.firstName == "Jose"
    And match response.lastName == "Valdivia"
    And match response.email == "jose@test.com"

    # Modificar usuario
    Given path 'user', username
    And retry until responseStatus == 200
    And request
      """
      {
        "id": 3001,
        "username": #(username),
        "firstName": "JoseMod",
        "lastName": "ValdiviaMod",
        "email": "josemod@test.com",
        "password": "abcd",
        "phone": "111111111",
        "userStatus": 1
      }
      """
    When method put
    Then status 200

    * eval sleep(5000)

    # Verificar modificación
    Given path 'user', username
    And retry until responseStatus == 200 && response.firstName == "JoseMod"
    When method get
    Then status 200
    And match response.firstName == "JoseMod"
    And match response.lastName == "ValdiviaMod"
    And match response.email == "josemod@test.com"

    # Eliminar usuario
    Given path 'user', username
    And retry until responseStatus == 200
    When method delete
    Then status 200

    # Confirmar eliminación
    Given path 'user', username
    And retry until responseStatus == 404
    When method get
    Then status 404
