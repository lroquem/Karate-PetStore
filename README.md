# Swagger PetStore - Pruebas con Karate

Este proyecto contiene pruebas automatizadas utilizando **Karate**  sobre la API de ejemplo **Swagger PetStore**, enfocándonos en el modelo **User**.

La API pública utilizada es:  
[Swagger PetStore](https://petstore.swagger.io)

---

## Endpoints usados (User)
Según la documentación de Swagger, los endpoints principales del modelo **User** son:

- **POST /user** → Crear un nuevo usuario.
- **GET /user/{username}** → Obtener un usuario por `username`.
- **PUT /user/{username}** → Actualizar un usuario existente.
- **DELETE /user/{username}** → Eliminar un usuario existente.

---

## Estructura del Proyecto
```
Karate-PetStore/
│── src/
│   └── test/
│       └── java/
│           └── user/
│               ├── user.feature          # Archivo con los escenarios en Gherkin
│               ├── UserTestsRunner.java  # Runner para ejecutar las pruebas
│── pom.xml                               # Dependencias de Karate (Maven)
└── README.md
```

---

## Ejecución del Proyecto

### Clonar repositorio
```bash
git clone https://github.com/lroquem/Karate-PetStore.git
cd Karate-PetStore
```

### Ejecutar pruebas
Ejecutar la clase **UserTestsRunner.class**

---

## Escenarios de prueba (User)

### Crear usuario (POST /user)
- Verificar que se cree correctamente un usuario con un `id`, `username`, `firstName`, `lastName`, `email`, `password`, `phone` y `userStatus`
- Validar que el status code sea **200**.

### Consultar usuario (GET /user/{username})
- Obtener el usuario recién creado.
- Validar que los datos devueltos coincidan.

### Actualizar usuario (PUT /user/{username})
- Modificar valores del usuario (ejemplo: `firstName`, `lastName`, `email`).
- Confirmar que la respuesta sea correcta.

### Eliminar usuario (DELETE /user/{username})
- Eliminar al usuario creado.
- Verificar que al consultarlo nuevamente devuelva un error **404**.

---

## Reportes
Karate genera reportes en la carpeta:
```
target/karate-reports/karate-summary.html
```
Abrir el archivo `.html` en el navegador para ver los resultados de ejecución.

---

**Autor**: Luis Roque