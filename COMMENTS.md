# Comentarios 

1- Comecei criando a API com auxilio do ChatGPT para gerar o código de acordo com o a solicitação e o planejamento, a intenção inicial é 
executar em uma plataforma de orquestração de container sem persistencia e gravar os dados em uma base de dados externa.

Aqui então a sugestão do ChatGPT foi utilizar FLask para o webapp e psycopg2 para a interação com o banco, a aplicação irá exibir nos logs
Falha ou sucesso ao iniciar a conexão com o banco (e se construiu ou não a tabela comments) e ao realizar as operações de inserção de comentário 
e listagem dos comentários por thread também exibir falha ou sucesso nos logs, além dos logs do webapp referente as requisições e código HTTP.

2- Na infraestrutura estou usando terraform para criar e automatizar os seguintes componentes no google cloud, a intenção foi me aproximar o máximo possível da stack que comentamos na primeira entrevista usando Google Cloud e tecnologias abertas para o monitoramento como Grafana, Loki e Prometheus.

- Cluster GKE
- Instancia CloudSQL
- VPC
- Artifact Registry repo
- Criar os componentes estaticos no kubernetes como namespace e secret sem expor o valor sensível.
- Realizar a instalação dos helm charts

3- Como automação para CI/CD estou usando Github Actions onde os seguintes valores sensíveis devem ficar armazenados como secret no repositorio:

- GCP_PROJECT_ID = id do projeto na GCP
- TF_VAR_CREDENTIALS = Chave JSON da service account
- TF_VAR_DB_PASS = Senha para criação do usuario no banco e configuração da secret no kubernetes
- TF_VAR_DB_USER = Usuario para criação no banco e configuração da secret no kubernetes

Foram criadas neste repositorio 3 automações:

- Deploy do GKE = Faz o build da imagem e push para o registry e atualiza o deployment no kubernetes e é disparado a cada commit na branch "main"
- Terraform Plan = Executa o terraform plan e é disparado manualmente
- Terraform Apply = Executa o terraform apply e é disparado manualmente

Pendências:

Ficou pendente completar a configuração do Loki como provedor de logs para o Grafana para poder desligar o Stackdriver e eu gostaria também de realizar a exposição do grafana e da aplicação usando ingress, neste momento apenas é exposto direto com service do tipo load-balancer.

