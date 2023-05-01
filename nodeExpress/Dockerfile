# Define a imagem base
FROM node:14-alpine

# Define o diretório de trabalho da aplicação dentro do container
WORKDIR /usr/src/app

# Copia o arquivo package.json para o diretório de trabalho
COPY . .

# Instala as dependências da aplicação
RUN npm install

# Expõe a porta 3000 utilizada pela aplicação
EXPOSE 3000

# Define o comando para iniciar a aplicação
ENTRYPOINT [ "node", "index.js" ]
# CMD ["node", "index.js"]
