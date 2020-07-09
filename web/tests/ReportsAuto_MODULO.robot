***Settings
Documentation   Relatórios do MODULO X criados de modo Automático (reports que geram com valores default ao abrir a tela)
Resource        base.robot
Library         ../../libs/DynamicTestCases.py
Library         String
Suite setup     Inicia Recursividade
Suite Teardown  Encerra Sessão 

***Variables
${url}          https://qatoriba.dealernetworkflow.com.br

*** Test cases ***
PlaceHolder Test
    Log     Test fake, a magica está no suitesetup

***Keywords
Inicia Recursividade
    Nova Sessão
    Setup one test for each item "MODULO>Relatórios"

