# Multistage Dockerfiles
### Este repositório contém Dockerfiles que utilizam o conceito de multistage building. Cada Dockerfile é específico para um serviço diferente.

### Sobre o multistage building
#### O conceito de multistage building no Docker permite criar imagens mais leves e eficientes, dividindo o processo de construção em várias etapas, onde cada estágio pode ser construído com uma imagem diferente. Já as networks são usadas para conectar os contêineres, permitindo que eles se comuniquem e troquem informações entre si. Combinando multistage building com networks, é possível criar sistemas mais escaláveis e modularizados, que podem ser atualizados e expandidos facilmente.

### Serviços disponíveis

#### PHP Laravel
##### https://hub.docker.com/repository/docker/jatabara/laravel/general

#### Node
##### https://hub.docker.com/repository/docker/jatabara/hellonode/general

#### PHP Laravel - Nginx Reverse Proxy
##### https://github.com/patrickluizdev/integrationSystem/blob/main/laravelCompose/docker-compose.yml


### Imagens Dockerhub
#### https://hub.docker.com/u/jatabara