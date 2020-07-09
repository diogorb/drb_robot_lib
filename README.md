# DRB Robot Lib
Pequena Lib iniciada para compartilhar um pouco de conhecimento sobre Automatização de Testes com RobotFramework utilizando SeleniumLibrary.
Com esta lib, pode já sair do zero para iniciar a montar sua lib de testes de regressão e testes funcionais.
Comecei compartilhando a seguir alguns recursos legais em Robot e pretendo seguir criando e compartilhando por aqui. 

# Resumo - Base.robot
1. Base.robot é onde estão as principais Keywords usadas no projeto, a idéia é que vá desenvolvendo as suas Keywords que podem ser reusadas e coloque-as juntas.
Este arquivo tem basicamente:
- Login básico com checagem de abertura da página.
- Opção de rodar browser headless ou normal (passando variável browser na linha de comando).
- Rotina para criação de casos de testes em tempo de execuço

# Rotina para criação de casos de testes em tempo de execução? como funciona?

- Com uma inquietação minha relacionada a "ter pouco reaproveitamento", pesquisei sobre criação de casos de testes dinamicamente com RobotFramework. E não é que encontrei algo muito interessante? Link: https://gerg.dev/2018/09/dynamically-create-test-cases-with-robot-framework/
- Achei uma forma então de criar testes dinamicamente, adaptei ao meu cenário, e estou aqui compartilhando.
- Veja a lib DynamicTestCases.py. No meu código então passei a ter como criar um teste em tempo de execução.
- Para criar os testes, tenho uma rotina que é carregada no Suite Setup, onde abro um determinado menu do sistema que tem as opções de relatórios (*Setup one test for each item "${caminho}"*).É essa rotina que usa a mais nova Keyword que foi implementada na lib python ()
- A keyword (*Setup one test for each item "${caminho}"*) cria então casos de testes dinamicamente e é recursiva, ou seja, se tiver um sub-menu, ela pode gerar casos para os itens de sub-menus (através da classe)

# Como funciona (*Setup one test for each item "${caminho}"*)?
- Obtenho os elementos (Get Web Elements) do menu que foi aberto.
- Pela classe de cada elemento detecto:
   - Elemento se trata de um sub-menu? 
      Caso positivo, chamo a mesma rotina novamente (recursividade) passando o caminho deste sub-menu
   - Elemento é uma opção de menu normal? 
      Crio um caso de teste (que é chamado na sequência, ficando em memória).
   
# Como funciona (*Quando eu clico no menu "${caminho}"*)?
- Faço split do caminho passado como argumento, usando como separardor o ">" (Para entender sobre como fiz o split e testei, veja testeSplit.robot.)
- Abre qualquer menu no formado "Módulo>Opção"

# Exemplo de uso: Em um ERP
- Suponha que possui vários menus de relatórios, um para cada "módulo" do sistema. 
- E que algo em torno de 80% dos relatórios do sistema tem uma característica de ter uma tela de execução que já carrega automaticamente todos os seus parâmetros preenchidos. 
- Neste exemplo, seria então viável fazer uma automação simples para cada relatório, ou seja, criar um test case para cada! Mas isso geraria muita alteração manual, pouco reaproveitamento, etc. 
- Criar cada teste isoladamente, copiar, colar, alterar cada um... Deste modo não estaria aplicando o "DRY" (don't repeat yourself).


# testeDate.robot
   Foi ainda criada uma lib bem inicial de manipulação de datas em python (libs/DateExtraction.py), para utilização em testes de regressão e testes funcionais.
   A importaço da lib está sendo feita no arquivo base.robot (Library     ../../libs/DateExtraction.py)

# Rodar todos os testes de relatórios:
python -m robot -v url:https://seusite.com.br -d ./logs ./web/tests/ReportsAuto_*.robot

