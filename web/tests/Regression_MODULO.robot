***Settings
Documentation   Testes regressivos de MODULO 
Resource        base.robot
Suite Setup     Nova Sessão
Test Teardown   Encerra Sessão


***Variables
${url}      https://seusite.com.br

*** Test cases ***
Dado que preciso consultar SERVIÇO
    [tags]      regression
    Quando eu clico no menu "MODULO>SERVIÇO"
    E preencho data de abertura do SERVIÇO
    E clico no primeira SERVIÇO que aparece
    Então devo ver o resumo do SERVIÇO

***Keywords
E preencho data de abertura do SERVIÇO
    ${doisMesesAntes} =  DateExtraction.Return Inicio dois Meses Antes
    Select Frame                xpath=//div[@id="ID_DIV"]//iframe[@class='FRAME_CLASS']
    Convert To String           ${doisMesesAntes}
    Wait Until Element Is Visible       id:vDATAINICIO
    sleep                       3
    Click Element               id:vDATAINICIO
    Press Keys                  id:vDATAINICIO          CTRL+a+BACKSPACE
    Input Text                  id:vDATAINICIO          ${doisMesesAntes}
    Press keys                  id:vDATAINICIO          ENTER
    Click Element               xpath=//input[contains(@onclick, 'REFRESH')]

E clico no primeiro SERVIÇO que aparece
    Click Element               xpath=//tr[@id='ID_GRID_ELEMENT1']//a
    sleep                       5

Então devo ver o resumo do SERVIÇO
    Wait Until Element Is Visible        id:TABELADADOS
    Capture Page Screenshot     

