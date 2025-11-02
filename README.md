# 🚀 Ambiente seguro com Infraestrutura como Código

Um ambiente Docker completo e seguro com redes segregadas, implementado usando Terraform modular para máxima reutilização e conformidade com melhores práticas de segurança.

## 📋 Índice

- [Arquitetura](#-arquitetura)
- [Pré-requisitos](#-pré-requisitos)
- [Como usar](#-como-usar)
- [Outputs](#-outputs)
- [Troubleshooting](#-troubleshooting)
- [Contribuindo](#-contribuindo)
- [Autores](#-autores)

## 🏗️ Arquitetura

### Componentes
- 🌐 Proxy Nginx: Servidor web e proxy reverso (Rede Externa)
- ⚡ Backend API: Aplicação Node.js (Rede Interna)
- 📊 Frontend: Aplicação em html puro (Rede Interna)
- 🗄️ PostgreSQL: Banco de dados (Rede Interna)
- 🔒 Redes Segregadas: Comunicação controlada entre serviços

## 📋 Pré-requisitos
- Docker >= 20.0
- Docker Compose >= 2.0
- Terraform >= 1.0

### 🛠️ Instalação dos Pré-requisitos
#### Ubuntu/Debian:
```bash
# Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Docker Compose
sudo apt update
sudo apt install docker-compose-plugin

# Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update
sudo apt install terraform
```
#### macOS:
```bash
# Homebrew
brew install docker docker-compose terraform
```
## 🚀 Como usar
### 🐳 Método 1: Docker Compose

#### 1. Configure as variáveis de ambiente
```bash
cp .env.example .env
```

#### 2. Edite o arquivo .env com as configurações:
```bash
## Configurações gerais do Banco de dados
POSTGRES_DB=postgres
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres

## Configurações gerais da aplicação Backend
BACKEND_PORT=3001
DATABASE_PORT=5432
DATABASE_USER=postgres
DATABASE_PASSWORD=postgres
DATABASE_NAME=postgres
```

#### 3. Execute a aplicação:
```bash
docker-compose up --build
```
#### 4. Acesse a aplicação: http://localhost:80

### 🏗️ Método 2: Terraform
#### 1. Configure o ambiente de desenvolvimento
```bash
cd terraform/environments/dev
cp terraform.tfvars.example terraform.tfvars
```

#### 2. Edite o arquivo `terraform.tfvars`:
```yml
# Configurações do Projeto
project_name   = "secure-app"
environment    = "dev"

# Configurações do Banco de Dados
database_name     = "postgres"
database_user     = "postgres"
database_password = "postgres"

# Configurações de Portas
backend_port = 3001
proxy_port   = 80

# Configurações de Healthcheck
healthcheck_interval = "30s"
healthcheck_timeout  = "10s"
healthcheck_retries  = 3
```

#### 3. Inicialize e execute o Terraform
```bash
# Inicializar
terraform init

# Verificar plano
terraform plan -var-file="terraform.tfvars"

# Aplicar infraestrutura
# Confirme com "yes" quando solicitado
terraform apply -var-file="terraform.tfvars"

```
#### 4. Acesse a aplicação: http://localhost:80

#### 5. Destruir ambiente
```bash
terraform destroy -var-file="terraform.tfvars"
```

## 📊 Outputs
- Após o deploy, o Terraform mostrará:
```bash
Apply complete! Resources: 12 added, 0 changed, 0 destroyed.

Outputs:

application_url = "http://localhost:80"
containers_created = [
  "secure-app-dev-database",
  "secure-app-dev-backend",
  "secure-app-dev-proxy",
]
network_info = {
  "external" = "secure-app-dev-external"
  "internal" = "secure-app-dev-internal"
}
```

## 🛡️ Segurança
### Implementado:
- ✅ Redes segregadas (interna/externa)

- ✅ Database isolado na rede interna

- ✅ Health checks automáticos

- ✅ Volumes persistentes para dados

- ✅ Configurações por ambiente

- ✅ Variáveis sensíveis protegidas

## 🐛 Troubleshooting
- Erro comum: Provider Docker
```bash
Error: Failed to query available provider packages
```
- Solução:
```bash
rm -rf .terraform .terraform.lock.hcl
terraform init
```
- Erro: Porta ocupada
```bash
Error: port is already allocated
```
- Solução: Altere a porta no `terraform.tfvars` ou libere a porta.

## 🤝 Contribuindo
1. Fork o projeto

2. Crie uma branch: git checkout -b feature/nova-funcionalidade

3. Commit: git commit -m 'Add nova funcionalidade'

4. Push: git push origin feature/nova-funcionalidade

5. Abra um Pull Request

## Convenções de Commit:
- feat: Nova funcionalidade

- fix: Correção de bug

- docs: Documentação

- refactor: Refatoração de código

- test: Adição de testes

## 👥 Autores
- Fabio Silva