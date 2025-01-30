## 📌 Sobre o Projeto

Este projeto é uma API GraphQL para gerenciamento do organograma de empresas. Ele permite o cadastro de empresas e colaboradores, além de estabelecer relações hierárquicas entre eles. O sistema foi desenvolvido para ser escalável e seguir boas práticas de desenvolvimento.

## 🚀 Tecnologias Utilizadas

- Ruby on Rails 8
- GraphQL
- RSpec (para testes)

## 📜 Funcionalidades Implementadas

### 📂 Empresa
- Criar uma empresa
- Listar todas as empresas
- Exibir detalhes de uma empresa

### 👥 Colaboradores
- Cadastrar um colaborador em uma empresa
- Listar colaboradores de uma empresa
- Remover um colaborador de uma empresa

### 🔗 Organograma
- Associar um colaborador como gestor de outro dentro da mesma empresa
  - Respeitando a regra de que ambos devem pertencer à mesma empresa.
  - Garantindo que cada colaborador tenha no máximo um gestor.
  - Impedindo loops hierárquicos.
- Listar pares de um colaborador (colegas que compartilham o mesmo gestor).
- Listar liderados diretos de um colaborador.
- Listar liderados dos liderados de um colaborador (segundo nível).

## 🛠 Como Rodar o Projeto Localmente

### 1️⃣ Pré-requisitos

Certifique-se de ter instalado em sua máquina:
- [Ruby 3.3.5](https://www.ruby-lang.org/en/downloads/)
- [Rails 8](https://rubyonrails.org/)
- [GraphQL](https://graphql.org/)
- [RSpec](https://rspec.info/) (para testes)

### 2️⃣ Clonar o Repositório

```
git clone https://github.com/seu-usuario/company-org-chart-api.git
cd uol-challenge-api
```
### 3️⃣ Instalar Dependências
```
bundle install
````
### 4️⃣ Configurar o Banco de Dados
```
rails db:create db:migrate
```
### 5️⃣ Rodar o Servidor
```
rails s
```

A API GraphQL estará disponível em http://localhost:3000/graphql. Para testar as queries, você pode usar GraphiQL o acessando.

### 🧪 Como Rodar os Testes
Testes unitários e de integração
```
rspec
```
### 📌 Observações
A API foi implementada utilizando GraphQL, conforme a sugestão do desafio.
O projeto segue princípios de Clean Code, boas práticas de arquitetura e orientação a objetos.
Testes foram implementados com RSpec, incluindo testes unitários e de integração.
Todas as consultas e mutações GraphQL estão documentadas no próprio GraphiQL.
