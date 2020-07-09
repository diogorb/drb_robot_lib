# DRB Robot Lib
Projeto Robot para Automatização de Testes de regressão.
Criando alguns recursos legais em Robot.

# Status do desenvolvimento
1. Arquivo Base.robot possui
- Login básico.
- Opção de rodar browser headless ou normal.
- Rotina para montagem dinamica de casos de testes.
Exemplo de uso: Em um ERP, suponha que possui vários menus de relatórios, um para cada "módulo" do sistema. E que algo em torno de 80% dos relatórios do sistema tem uma característica de ter uma tela de execução que já carrega automaticamente todos os seus parâmetros preenchidos. 
Neste exemplo, seria então viável fazer uma automação simples para cada relatório, ou seja, criar um test case para cada!? Sim, poderia fazer um teste para cada report, mas isso geraria muita alteração manual, pouco reaproveitamento, etc, etc. Mas deste modo não estaria fazendo um código "DRY" (don't repeat yourself).

Cria cada teste isoladamente, copiar, colar, alterar cada um...

Ai que vem a mágica!

Achei uma lib que cria testes dinamicamente, adaptei ao meu cenário, e estou aqui compartilhando.

A solução então consiste em:
   1. Usar lib python que cria casos de testes dinamicamente (Fonte: https://gerg.dev/2018/09/dynamically-create-test-cases-with-robot-framework/)
   2. Para criar os testes, tenho uma rotina que é carregada no Suite Setup, onde abro um determinado menu do sistema que tem as opções de relatórios (*Setup one test for each item "${caminho}"*)
   3, Obtenho os elementos (Get Web Elements) da página e pela classe deles detecto se:
      3.1. Elemento se trata de um sub-menu? Chamo a mesma rotina novamente (recursividade) passando o caminho deste sub-menu
      3.2. Elemento é uma opção de menu? Crio um caso de teste (que é chamado na sequência, ficando em memória).
   4. Para viabilizar reuso, criei rotina que abre qualquer menu no formado "Módulo>Opção"
   5. Foi ainda criada uma lib bem inicial de manipulação de datas em python, para utilização em testes de regressão e testes funcionais.

# Rodar todos os testes de relatórios:
python -m robot -v url:https://seusite.com.br -d ./logs ./web/tests/ReportsAuto_*.robot

