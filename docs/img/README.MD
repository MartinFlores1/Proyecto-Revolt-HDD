## 📸 Evidencias

📂 Registro de Evidencias - Sprint 1
Colaborador: Ian Andrade

🛠️ 1. Configuración de Entorno e Infraestructura (VS Code)
Se estableció el entorno de desarrollo utilizando Visual Studio Code, configurando las herramientas necesarias para un flujo de trabajo profesional:

Servidor de Aplicaciones: Configuración y vinculación de Apache Tomcat 10 mediante extensiones de VS Code, permitiendo el despliegue local y la gestión del ciclo de vida del servidor.

Entorno Java: Ajuste del java.configuration.runtimes y el cumplimiento del nivel de lenguaje a JDK 17, resolviendo conflictos de compatibilidad con las dependencias de Maven del proyecto.

Despliegue en Tiempo Real: Configuración de la estructura de salida para que VS Code refleje los cambios en el servidor Tomcat de manera inmediata tras la compilación.

📁 2. Organización y Estructura del Proyecto
Se intervino la arquitectura de archivos directamente desde el explorador de VS Code para asegurar que el proyecto sea "buildable":

Estructura Maven/Web: Reorganización de la carpeta raíz y el directorio WEB-INF, asegurando que el descriptor de despliegue (web.xml) sea reconocido correctamente por la extensión de Tomcat.

Gestión del Blog: Reestructuración integral del apartado de blog, optimizando la jerarquía de archivos y eliminando redundancias entre la versión inicial y la final.

Control de Versiones (Git): Uso de la terminal integrada de VS Code para la gestión de ramas (ian-docs) y la resolución de conflictos en el historial del repositorio.

📋 3. Resumen de Mejoras Técnicas (Pull Request)
Accesibilidad: Inclusión de etiquetas ARIA para mejorar la navegación con lectores de pantalla.

Refactorización: Migración a HTML5 semántico en las vistas del blog.

Localización: Traducción y corrección ortográfica de la interfaz de usuario al español.
