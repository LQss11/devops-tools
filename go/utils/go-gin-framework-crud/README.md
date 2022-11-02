# Criando uma API usando golang e Gin
go get
go build main.go
curl -X POST http://localhost:8080/users -H "Content-Type: application/json" -d @req.json
## Requisições http
### Listar usuários
[GET] http://localhost:3131/users/

### Cadastrar usuário
[POST] http://localhost:3131/users/

### Editar usuário
[PUT] http://localhost:3131/users/:id

### Excluir usuários
[DELETE] http://localhost:3131/users/:id
