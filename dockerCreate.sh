#!/bin/bash

# Variáveis
IMAGE_HUB="nginx:latest" # IMAGEM https://hub.docker.com/_/nginx
NAME_IMAGE="nginx-real"  # NOME DA IMAGEM PERSONALIZADA
NAME_CONTAINER="nginx-real-container" # NOME DO CONTAINER QUE SERÁ EXECUTADO
PORT_SERVICE_CONTAINER="80" # PORTA DO CONTAINER
PORT_SERVICE_SERVER="9005"  # PORTA DA MAQUINA QUE VAI ESPELHAR A DO CONTAINER
DIR_MOUNT=""$(pwd)"/app"    # DIRETORIO DE COMPARTILHAMENTO DE ARQUIVOS
TARGET="/usr/share/nginx/html"  # RAIZ DA PASTA DE UTILIZAÇÃO DO SERVIÇO "VERIFICAR NA DOCUMENTAÇÃO"
ATRIBUTE="--mount type=bind,source=$DIR_MOUNT,target=$TARGET" # CASO NÃO QUEIRA ESPECIFICAR COMENTE ESSA LINHA


# Função para criar arquivo Dockerfile
create_dockerfile() {
  echo -e "Criando arquivo Dockerfile"
  #
  {
    cat > dockerfile <<EOF
FROM $IMAGE_HUB
EXPOSE $PORT_SERVICE_CONTAINER
EOF
  }
  #
  echo -e "\n"$(pwd)"/dockerfile\n"
  echo "dockerfile criado com sucesso!"
  echo -e "\n ................................... \n"
}

# Função para build da imagem
build_image() {
  echo -e "Build da imagem"
  docker build -t $NAME_IMAGE .
  echo -e "\n $NAME_IMAGE $(docker inspect -f '{{.Created}}' $NAME_IMAGE) \n"
  echo -e "\n ................................... \n"
}

# Função para inicialização do container
start_container() {
  echo -e "inicialização do container"
  docker run -d --name $NAME_CONTAINER -p $PORT_SERVICE_SERVER:$PORT_SERVICE_CONTAINER $ATRIBUTE $NAME_IMAGE

  sleep 6

  echo -e "\n $NAME_CONTAINER \n 
            "$(docker inspect -f'
              \n | ID Container: {{json .Config.Hostname}} |  
              \n | Porta Interna do Container: {{json .Config.ExposedPorts}} |' $NAME_CONTAINER)" 
          "
  echo -e "\n ................................... \n"
}

#INTRO SCRIPT ###############
echo -e "\n ...................................\n Iniciando a Criação do Seu Container Docker \n ................................... \n"
# FUNÇÕES     ###############
{
  create_dockerfile
  build_image
  start_container
}