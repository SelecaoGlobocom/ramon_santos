# Comentarios 

1- Comecei criando a API com auxilio do ChatGPT para gerar o código de acordo com o a solicitação e o planejamento, a intenção inicial é 
executar em uma plataforma de orquestração de container sem persistencia e gravar os dados em uma base de dados externa.

Aqui então a sugestão do ChatGPT foi utilizar FLask para o webapp e psycopg2 para a interação com o banco, a aplicação irá exibir nos logs
Falha ou sucesso ao iniciar a conexão com o banco (e se construiu ou não a tabela comments) e ao realizar as operações de inserção de comentário 
e listagem dos comentários por thread também exibir falha ou sucesso nos logs, além dos logs do webapp referente as requisições e código HTTP.