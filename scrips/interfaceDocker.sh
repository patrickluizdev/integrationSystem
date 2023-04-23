#!/bin/bash
define_ambient(){
  local confirm="n"
  while [[ "$confirm" != "y" ]]; do
      read -p "Informe a imagem do hub (ex: nginx:latest): " IMAGE_HUB
      read -p "Informe o nome para sua imagem personalizada: " NAME_IMAGE
      read -p "Informe o nome do container que será executado: " NAME_CONTAINER
      read -p "Informe a porta da sua máquina que irá espelhar a do container: (Caso seja mais de uma use espaço para separar ex: 4000)" PORT_SERVICE_SERVER
      read -p "Informe a porta do container: (Caso seja mais de uma use espaço para separar ex: 80)" PORT_SERVICE_CONTAINER
      echo "Você escolheu a imagem: <$IMAGE_HUB>, o nome de sua imagem será <$NAME_IMAGE>, seu container foi nomeado <$NAME_CONTAINER>, a porta do seu serviço no container será <$PORT_SERVICE_CONTAINER> direcionadas para a porta <$PORT_SERVICE_SERVER> do seu servidor"

      read -p "As informações acima estão corretas? [y/n] " confirm
  done
}

define_directory(){
  local confirm=""
    read -p "Seu container terá pasta compartilhada com o servidor ? [y/n] " confirm
  if [[ "$confirm" == "y" ]]; then
    echo -e "\n Sua pasta compartilhada será configurada como a pasta atual.\n "
    echo -e "\n DIRETORIO DE COMPARTILHAMENTO DE ARQUIVOS $DIR_MOUNT \n"
    mkdir app
    DIR_MOUNT="$(pwd)/app"    # DIRETORIO DE COMPARTILHAMENTO DE ARQUIVOS
    echo -e "\n DIRETORIO DO CONTAINER ("VERIFICAR NA DOCUMENTAÇÃO") \n"
    read -p "Defina o diretorio do container que será compartilhado (utilize / para todo container (não aconcelhavel))" TARGET
    return
    else
    echo "Sua instalação será padrão"
    return
  fi
  ATRIBUTE="--mount type=bind,source=$DIR_MOUNT,target=$TARGET"
}
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
  define_ambient
  define_directory
  create_dockerfile
  build_image
  start_container
}