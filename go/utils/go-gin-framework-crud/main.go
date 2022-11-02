package main

import (
	"log"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

// Estrutura de um usuaŕio
type User struct {
	ID   string `json:"id"`
	Name string `json:"name"`
	Age  int    `json:"age"`
}

var Users []User // Array vazio

func main() {
	r := gin.Default() // inicializando o gin

	// Grupo de rotas -> users
	userRoutes := r.Group("/users")
	{
		userRoutes.GET("/", GetUsers)
		userRoutes.POST("/", CreateUser)
		userRoutes.PUT("/:id", EditUser)
		userRoutes.DELETE("/:id", DeleteUser)
	}

	if err := r.Run(":8080"); err != nil {
		log.Fatal(err.Error())
	}
}

// Listar os usuários do array
func GetUsers(c *gin.Context) {
	c.JSON(200, Users)
}

// Cadastrar um novo usuário no array
func CreateUser(c *gin.Context) {
	var reqBody User

	// Validação
	if err := c.ShouldBindJSON(&reqBody); err != nil {
		c.JSON(422, gin.H{
			"error":   true,
			"message": "invalid request body",
		})
		return
	}

	// Adicionando o id uuid
	reqBody.ID = uuid.New().String()

	// Adiciona o usuário no array
	Users = append(Users, reqBody)

	// Resposta de sucesso
	c.JSON(200, gin.H{"error": false})
}

// Editar dados do usuário
func EditUser(c *gin.Context) {
	id := c.Param("id") // Recebendo o id via parametro da URL
	var reqBody User

	// Validando se existe erro no JSON
	if err := c.ShouldBindJSON(&reqBody); err != nil {
		c.JSON(422, gin.H{
			"error":   true,
			"message": "invalid request body",
		})

		return
	}

	// Percorrer todo array para encontrar
	// o usuário com o id informado
	for i, u := range Users {
		if u.ID == id {
			Users[i].Name = reqBody.Name
			Users[i].Age = reqBody.Age

			c.JSON(200, gin.H{
				"error": false,
			})

			return
		}
	}

	// Mensagem de error
	c.JSON(404, gin.H{
		"error":   true,
		"message": "invalid user id",
	})
}

// Função para excluir um usuário do array
func DeleteUser(c *gin.Context) {
	id := c.Param("id") // Recebendo o id via parametro da URL

	// Percorrer todo o array de usuários
	// para encontrar e excluir
	for i, u := range Users {
		if u.ID == id {
			Users = append(Users[:i], Users[i+1:]...)

			// Mensagem de sucesso
			c.JSON(200, gin.H{
				"error": false,
			})

			return
		}
	}

	// Mensagem de error
	c.JSON(404, gin.H{
		"error":   true,
		"message": "invalid user id",
	})
}
