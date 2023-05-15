# Considerações Gerais

Você deverá usar este repositório como o repo principal do projeto, i.e., todos os seus commits devem estar registrados aqui, pois queremos ver como você trabalha.

A escolha de tecnologias é livre para a resolução do problema. Utilize os componentes e serviços que melhor domina, pois, a apresentação na entrega do desafio deverá ser como uma aula em que você explica em detalhes cada decisão que tomou.

Registre tudo: testes que foram executados, ideias que gostaria de implementar se tivesse tempo (explique como você as resolveria, se houvesse tempo), decisões que foram tomadas e seus porquês, arquiteturas que foram testadas e os motivos de terem sido modificadas ou abandonadas. Crie um arquivo COMMENTS.md ou HISTORY.md no repositório para registrar essas reflexões e decisões.


# O Problema

O desafio que você deve resolver é criação, implantação e monitoramento de uma API simples de Comentários (apenas backend) usando linguagem e ferramentas open source da sua preferência. 

Você precisa criar o ambiente de execução desta API com o maior número de passos automatizados possível, inclusive a esteira de deploy. 

Você deve instrumentar a aplicação/ambiente de execução e demonstrar ao menos um dashboard simples para acompanhamento da operação da aplicação. 

A aplicação será uma API REST que deverá ser disponibilizada neste repositório. Caso não tenha muito domínio de técnicas de programação, pode utilizar ferramentas que auxiliem em parte com a geração de código, mas é imprecindível demonstrar ao menos a capacidade de ajustar e personalizar o código gerado. O objetivo da API é permitir que internautas enviem comentários em texto a respeito de uma máteria e acompanhem o que outras pessoas estão falando sobre o assunto em destaque. Para isso, a API deve conter ao menos 2 rotas, uma para inserção de comentários e uma para listagem dos comentários feitos sobre o assunto. 

Os comandos de interação com a API são os seguintes:

* Criando e listando comentários por matéria

```
# matéria 1
curl -sv <host>:<port>/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"alice@example.com","comment":"first post!","content_id":1}'
curl -sv <host>:<port>/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"alice@example.com","comment":"ok, now I am gonna say something more useful","content_id":1}'
curl -sv <host>:<port>/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"bob@example.com","comment":"I agree","content_id":1}'

# matéria 2
curl -sv <host>:<port>/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"bob@example.com","comment":"I guess this is a good thing","content_id":2}'
curl -sv <host>:<port>/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"charlie@example.com","comment":"Indeed, dear Bob, I believe so as well","content_id":2}'
curl -sv <host>:<port>/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"eve@example.com","comment":"Nah, you both are wrong","content_id":2}'

# listagem matéria 1
curl -sv <host>:<port>/api/comment/list/1

# listagem matéria 2
curl -sv <host>:<port>/api/comment/list/2
```
OBS: Subistituir \<host\>:\<port\> com o respectivo endereço e porta onde a sua API for disponibilizada. 

Você é livre para implementar outras rotas, se desejar.


# O que será avaliado na sua solução?

* Capacidade de programar ou ajustar o código da API usando uma linguagem de programação

* Automação da infra, provisionamento dos hosts 

* Automação de setup e configuração dos hosts

* Pipeline de CI/CD automatizado

* Monitoração básica da aplicação 


# Dicas

Use ferramentas e bibliotecas open source, mas documente as decisões e porquês;

Automatize o máximo possível;

Em caso de dúvidas, pergunte.
