# Caso Práctico: Despliegue de Registro de Contenedores y Subida de Imágenes en Azure

## Descripción

Este proyecto tiene como objetivo implementar un flujo de trabajo DevOps que incluya la creación de un Registro de Contenedores en Azure y la gestión de imágenes de contenedores. Se utilizarán herramientas como Docker y Azure DevOps para automatizar el proceso de construcción e implementación de aplicaciones en contenedores.

## Requisitos Previos

- **Cuenta de Azure**:
  - Una suscripción activa en [Microsoft Azure](https://azure.microsoft.com/).
- **Herramientas de Desarrollo**:
  - [Docker](https://www.docker.com/get-started) instalado en tu máquina local.
  - [Azure CLI](https://docs.microsoft.com/es-es/cli/azure/install-azure-cli) para interactuar con los servicios de Azure desde la línea de comandos.
  - [Visual Studio Code](https://code.visualstudio.com/) o cualquier editor de código de tu preferencia.
- **Conocimientos Básicos**:
  - Familiaridad con conceptos de contenedores y Docker.
  - Experiencia básica en el uso de la línea de comandos.

## Pasos para Implementar el Proyecto

### 1. Crear un Registro de Contenedores en Azure

Utilizaremos Azure Container Registry (ACR) para almacenar nuestras imágenes de Docker de forma privada.

1. **Crear un Grupo de Recursos**:
   ```bash
   az group create --name mi-grupo-recursos --location eastus
   ```


2. **Crear el Registro de Contenedores**:
   ```bash
   az acr create --resource-group mi-grupo-recursos --name miRegistroContenedores --sku Basic
   ```


3. **Habilitar el Usuario Administrador**:
   ```bash
   az acr update -n miRegistroContenedores --admin-enabled true
   ```


*Nota*: Asegúrate de que el nombre del registro esté en minúsculas y sea único a nivel global.

### 2. Construir y Etiquetar la Imagen de Docker

Construiremos la imagen de Docker y la etiquetaremos para que apunte a nuestro registro en Azure.

1. **Navegar al Directorio del Proyecto**:
   ```bash
   cd ruta/al/proyecto
   ```


2. **Construir la Imagen de Docker**:
   ```bash
   docker build -t mi-aplicacion:1.0 .
   ```


3. **Etiquetar la Imagen para ACR**:
   ```bash
   docker tag mi-aplicacion:1.0 miRegistroContenedores.azurecr.io/mi-aplicacion:1.0
   ```


### 3. Iniciar Sesión en el Registro de Azure

Antes de subir la imagen, debemos autenticarnos en nuestro ACR.


```bash
az acr login --name miRegistroContenedores
```


### 4. Subir la Imagen al Registro de Azure

Finalmente, subimos la imagen etiquetada a nuestro registro.


```bash
docker push miRegistroContenedores.azurecr.io/mi-aplicacion:1.0
```


## Referencias

- [Uso de Azure Pipelines para compilar e insertar imágenes de contenedor en un registro](https://learn.microsoft.com/es-es/azure/devops/pipelines/ecosystems/containers/push-image?view=azure-devops)
- [Crear una canalización YAML que compile e inserte una imagen de Docker en Azure Container Registry](https://learn.microsoft.com/es-es/azure/devops/pipelines/ecosystems/containers/acr-template?view=azure-devops)

