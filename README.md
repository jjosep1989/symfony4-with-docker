# Symfony with docker

Desarrollo de symfony con docker.

## Usage

install and run a new self-contained instance of VulcanJS (for example)

- `mkdir myProject && cd myProject`
- `docker run --rm -v {$PWD}:/app assetsagacity/meteor-do init https://github.com/VulcanJS/Vulcan.git`
- `./meteor`

Or create a new empty meteor project: `docker run --rm -v $PWD:/app assetsagacity/meteor-do init`



And perform standard meteor operations using `./meteor`, for example:

- `./meteor` runs the project
- `./meteor npm install --save somePackage`
- `./meteor shell`



## Install

1. install [docker](https://docs.docker.com/engine/installation/)
and [docker-compose](https://docs.docker.com/compose/install/)
1. create a folder for your new project and go into it
1. init: `docker run --rm -v ${PWD}:/app assetsagacity/meteor-do init`
1. now run your server: `./meteor`
1. you can access it at http://localhost:3000/