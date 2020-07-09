# DRB Robot Lib
Projeto Robot para Automatização de Testes de regressão.
Criando alguns recursos legais em Robot.

# Status do desenvolvimento
1. Arquivo Base.robot possui
- Login básico.
- Opção de rodar browser headless ou normal.
- Rotina para montagem dinamica de casos de testes.
Exemplo de uso: Em um ERP, suponha que possui vários menus de relatórios, um para cada "módulo" do sistema. E que algo em torno de 80% dos relatórios do sistema tem uma característica de ter uma tela de execução que já carrega automaticamente todos os seus parâmetros preenchidos. 
Neste exemplo, uma automação simples que clica em gerar e testa se o report foi gerado, garante que não ocorreu uma regressão. 
Mas qual a parte chata? Cria cada teste isoladamente, copiar, colar, alterar cada um...
Ai que vem a mágica!
Achei uma lib que cria testes dinamicamente, adaptei ao meu cenário, e estou aqui compartilhando.

A solução então consiste em:
   1. Usando uma lib python que cria casos de testes dinamicamente (Fonte: https://gerg.dev/2018/09/dynamically-create-test-cases-with-robot-framework/), carrego um determinado menu do sistema e crio um caso de teste para cada elemento do menu.
   2. Criei rotina que abre qualquer menu no formado "Módulo>Opção"
   3. Criada lib de manipulação de data em python, para utilização em testes de regressão.

# Rodar todos os testes de relatórios:
python -m robot -v url:https://seusite.com.br -d ./logs ./web/tests/ReportsAuto_*.robot

