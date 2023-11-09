# CurrentPosition

O CurrentPosition é um aplicativo construído utilizando o framework Flutter na versão 3.13.7, seguindo a arquitetura Clean Architecture. Este aplicativo permite que os usuários obtenham informações sobre sua localização atual, utilizando a localização do dispositivo ou uma localização aproximada pelo endereço IP da rede.

A estrutura do projeto segue a divisão em três camadas principais: Presentation, Domain e Data, garantindo uma separação clara de responsabilidades e uma organização eficaz do código.

### Pré-requisitos

Antes de começar a usar o CurrentPosition, certifique-se de que você atenda aos seguintes pré-requisitos:

Flutter 3.13.7 ou superior instalado no seu sistema.

### Instalação

#### Geração dos modelos usando o build_runner

`dart run build_runner build`

flutter run
Agora o aplicativo CurrentPosition deve estar em execução no seu dispositivo ou emulador.

### Uso

Ao iniciar o aplicativo, ele irá solicitar permissão para acessar a localização do dispositivo. Após a permissão ser concedida, o CurrentPosition exibirá informações sobre a localização atual do dispositivo. Para carregar os tiles do mapa será necessário uma primeira conexão com a internet, depois que uma parte do mapa é carregado a mesma é armazenada em um cache no dispositivo e poderá ser utilizada novamente mesmo sem acesso a internet. Ao abrir o aplicativo pela primeira vez sem o devido acesso a internet um erro será exibido, mas n impedirá de exibir a posição do dispositivo (só não será possível visualizar o mapa). Caso a localização esteja indisponível no dispositivo o APP tentará pegar a posição aproximada fornecida pelo provedor de internet utilizando o endereço IP do dispositivo. `http://ip-api.com/json/`

### Estrutura do Projeto

A estrutura do projeto CurrentPosition segue a arquitetura Clean Architecture, com a divisão em três camadas principais:

presentation: Contém a camada de apresentação, responsável pela interface do usuário, o controller dessa interface, sua store e o module, esse último sendo responsável pela injeção das dependências.

domain: Camada de domínio, onde são definidas as regras de negócio e os casos de uso do aplicativo.

data: Camada de dados, responsável por lidar com fontes de dados externas e drivers do dispositivo.

test: Contém testes unitários abrangentes para todas as camadas.

O projeto utiliza o gerenciamento de estados do GetX e a injeção de dependência do flutter_modular.

### Contato

Se você tiver alguma dúvida ou precisar de suporte, sinta-se à vontade para entrar em contato em avictortcosta@gmail.com.
