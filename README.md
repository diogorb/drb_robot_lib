# DRB Robot Lib
Pequena Lib iniciada para compartilhar um pouco de conhecimento sobre Automatização de Testes com RobotFramework utilizando SeleniumLibrary.
Com esta lib, pode já sair do zero para iniciar a montar sua lib de testes de regressão e testes funcionais.
Comecei compartilhando a seguir alguns recursos legais em Robot e pretendo seguir criando e compartilhando por aqui. 

# Resumo
1. Base.robot é onde estão as principais Keywords usadas no projeto, a idéia é que vá desenvolvendo as suas Keywords que podem ser reusadas e coloque-as juntas.
Este arquivo tem basicamente:
- Login básico com checagem de abertura da página.
- Opção de rodar browser headless ou normal (passando variável browser na linha de comando).
- Rotina para montagem dinamica de casos de testes (Fonte: https://gerg.dev/2018/09/dynamically-create-test-cases-with-robot-framework/).
- Exemplo de uso: Em um ERP, suponha que possui vários menus de relatórios, um para cada "módulo" do sistema. E que algo em torno de 80% dos relatórios do sistema tem uma característica de ter uma tela de execução que já carrega automaticamente todos os seus parâmetros preenchidos. 
Neste exemplo, seria então viável fazer uma automação simples para cada relatório, ou seja, criar um test case para cada!? Sim, poderia fazer um teste para cada report, mas isso geraria muita alteração manual, pouco reaproveitamento, etc. 
Criar cada teste isoladamente, copiar, colar, alterar cada um... Deste modo não estaria fazendo um código "DRY" (don't repeat yourself).

Ai que vem a mágica!

Achei uma lib que cria testes dinamicamente, adaptei ao meu cenário, e estou aqui compartilhando.

A solução então consiste em:
   1. Para criar os testes, tenho uma rotina que é carregada no Suite Setup, onde abro um determinado menu do sistema que tem as opções de relatórios (*Setup one test for each item "${caminho}"*).
   2. A rotina acima usa lib python que cria casos de testes dinamicamente. Esta rotina é recursiva, se tiver um sub-menu, ela pode gerar casos para os itens de sub-menus (através da classe), vide a seguir.
   Como funciona?
   3. Obtenho os elementos (Get Web Elements) do menu que foi aberto.
   4. Pela classe de cada elemento detecto:
   - Elemento se trata de um sub-menu? 
      Caso positivo, chamo a mesma rotina novamente (recursividade) passando o caminho deste sub-menu
   - Elemento é uma opção de menu normal? 
      Crio um caso de teste (que é chamado na sequência, ficando em memória).
   
   5. Para viabilizar reuso, criei rotina que abre qualquer menu no formado "Módulo>Opção" (*Quando eu clico no menu "${caminho}"*)
   Para entender sobre como fiz o split e testei, veja testeSplit.robot.

# testeDate.robot
   Foi ainda criada uma lib bem inicial de manipulação de datas em python, para utilização em testes de regressão e testes funcionais. (Veja )

# Rodar todos os testes de relatórios:
python -m robot -v url:https://seusite.com.br -d ./logs ./web/tests/ReportsAuto_*.robot

