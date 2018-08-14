# Symfony4 with docker

Desarrollo de symfony con docker.

## Uso

Para crear desde un repositorio existente

- `mkdir myProject && cd myProject`
- ``docker run --rm -v $PWD:/app -u `id -u`:`id -g` jjosep1989/symfony:4.1-alpine init https://github.com/[your_repository].git``
- `./symfony`

Proyecto desde cero: ``docker run --rm -v $PWD:/app -u `id -u`:`id -g` jjosep1989/symfony:4.1-alpine init``

<!-- Para los logs de php: `docker run --rm -v $PWD:/var/www/html -v $PWD/php-logs:php-logs jjosep1989/symfony4-with-docker init` -->

Se puede ejecutar cualquier comando hacia el contenedor de symfony usando `./symfony symfony-app/bin/console [command]`
El proyecto de symfony estara en la carpeta symfony-app


Se usa el puerto 80 para acceder a la aplicacion


