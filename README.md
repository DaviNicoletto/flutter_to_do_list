# To-do List

Este projeto é uma aplicação mobile para Android.

Consiste em uma interface de criação de lembretes, permitindo ao usuário criar lembretes para datas definidas.

## Como executar:

Para executar e visualizar a aplicação basta realizar a instalação do app, disponível no [Google Drive](https://drive.google.com/file/d/1WfdRvDLP7C7iUxWHS87ujAs4p2RUR5RG/view?usp=sharing).

**Observação importante:**
- É provável que o sistema do telefone reconheça o app como potencialmente nocivo, por ter sido baixado por fora. Entretanto é seguro realizar a instalação.

Também é possível visualizar em modo de depuração clonando o repositório e iniciando o debug do arquivo `lib\main.dart` em um dispositivo Android físico ou emulado.

## Premissas assumidas para o projeto:

1. Os campos "nome" e "data" devem ser preenchidos, ou o lembrete não é adicionado;
2. A data inserida deve ser no futuro, caso contrário não será possível criar o lembrete;
3. Os lembretes criados devem ser exibidos em ordem cronológica das datas;
4. Caso existam múltiplos lembretes na mesma data, eles devem ser exibidos como um grupo;
5. O usuário pode remover lembretes da lista através de um botão.

## Decisões para o projeto:

Para a execução do projeto, optei por montar um formulário com dois campos do tipo `TextFormField` (Um para o nome e outro para a data). No caso do campo "data", foi utilizado o método `showDatePicker` para selecionar a data através de uma interface de calendário, no lugar de simplesmente digitar como um texto. Também utilizei o pacote "intl" para formatar a data inserida para o padrão brasileiro e validar a mesma (verificar se o dia selecionado se encontra no futuro).

Para montar a lista dos lembretes, fiz de forma que ao apertar o botão "Criar", o sistema recebe os dados inseridos nos campos e transforma em um objeto `novoLembrete`, da classe `Lembrete` e então adiciona este objeto na lista `meusLembretes`. Feito isso, a lista organizada por orgem cronológica das datas de cada lembrete e exibida na tela.

Foram também definidos os devidos testes de funcionamneto da aplicação, disponíveis na pasta `\test`.



