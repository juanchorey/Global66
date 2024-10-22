## Funcionalidades

- **Interfaz de Usuario**: El componente LWC proporciona una interfaz para gestionar contactos con campos para nombre, apellido, correo electrónico y número de teléfono.
- **CRUD de Contactos**: Permite crear, actualizar y eliminar contactos en Salesforce.
- **Búsqueda**: Implementa una función de búsqueda para encontrar contactos por nombre, apellido o correo electrónico.
- **Manejo de Errores**: El controlador Apex está optimizado para manejar errores y devolver mensajes amigables.
- **Pruebas Unitarias**: Incluye una clase de prueba para garantizar que los métodos en el controlador Apex funcionen correctamente.

## Requisitos

Para implementar este proyecto, necesitarás:

- Salesforce DX o una instancia de Salesforce habilitada para desarrollo.
- Familiaridad con LWC y Apex.

## Instalación

1. Ejecuta Visual Studio Code, con la conexion al ambiende de desarrollo. Para configurar el proyecto correctamente, asegúrate de tener acceso a una organización de Salesforce con permisos para desarrollar componentes LWC y Apex.
2. Sube la clase Apex ContactManagementSystemController y su clase de prueba ContactManagementSystemControllerTest.
3. Implementa el LWC LWC_ContactManagementSystem que consta de los archivos LWC_ContactManagementSystem.html, LWC_ContactManagementSystem.js y LWC_ContactManagementSystem.js-meta.xml.
   
## Ejecucion de test class

- En Salesforce, ve a Setup > Apex Test Execution y ejecuta ContactManagementSystemControllerTest para verificar que todos los métodos pasan correctamente.

## USO del LWC

- El componente muestra una lista de contactos existentes en Salesforce.
- Puedes agregar un nuevo contacto haciendo clic en "Nuevo Contacto", lo cual abrirá un modal para ingresar la información.
- Puedes buscar contactos usando el campo de búsqueda.
- La tabla muestra acciones para eliminar contactos.

## Diseño

- Controlador Apex Class: Se eligió un enfoque modular para las operaciones CRUD, permitiendo manejar cada operación por separado y facilitar el manejo de errores.
- Manejo de Errores exceptions: Se utiliza AuraHandledException para devolver mensajes amigables al usuario en caso de errores.
- Interfaz LWC: El diseño es sencillo, con una tabla para mostrar los contactos y un modal para agregar o editar contactos. Se utiliza lightning-datatable para facilitar la edición en línea.