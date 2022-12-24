# G10-Holotourism-Front

proyecto donde se desarrolla el front end de Holotourism

# Holotourism front- version web (beta)!

Holotourism front- version web es una representación del front app disponible para dispositivos, con esta versión se busca extender la disponibilidad de la aplicación haciendo que pueda llegar a más usuarios.

# Despliegue en Firebase Hosting

Firebase hosting es un servicio de google que nos ofrece un servicio gratuito de hosting esencial para el despliegue de webs, posee una integración con 'github actions' lo cual le permite generar auto despliegues continuos

## applicationId

Ubicar el elemento: **_ android\app\build.gradle_**
Buscar el atributo **_applicationId "your.aplication.Id"_**

## Firebase Hosting

1.  Ingresar a Firebase y seleccionar la opción Hosting (se abrirá una guía de instalación)
2.  Instalar FirebaseCLI: npm install -g firebase-tools
3.  Inicializar el proyecto en el directorio del proyecto: firebase login
4.  Buildear el modo web de flutter: flutter build web
5.  Inicializar firebase para deployment: firebase init
6.  Seleccionar Hosting: Configure files for Firebase Hosting and set up Github actions
7.  Seleccionar Use an existing project
8.  En la pregunta what do you want as your public directory? escribir: build/web
9.  En la pregunta set up automatic builds and deploys with github? escribir N por el momento
10. En la pregunta Overwrite index.html, escribir N
11. En la línea de comando escribir: firebase deploy

Su aplicación ha sido desplegada en firebase hosting

## Conectar a GitHub Actions

1.  Ubicar .github/workflows dentro del proyecto
2.  copiar el siguiente contenido [main.yml](https://github.com/JohannesMilke/flutter_firebase_hosting/blob/master/.github/workflows/main.yml)
3.  Cambiar la línea 28: **args**: **_deploy --only identificardesuproyecto_**
4.  En la línea de comandos escribir: firebase login:ci
5.  copiar el token que se obtenga
6.  En el repositorio del proyecto ir a la sección actions
7.  Seleccionar la opción **secrets**
8.  escribir: **name: FIREBASE_TOKEN ; value: Token**
9.  crear una actualización del repositorio para probar que la configuración funcione
