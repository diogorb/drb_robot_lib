***Settings
Documentation   Criação de user para a automação de testes
Resource        base.robot
Suite Setup     Nova Sessão
Test Teardown   Encerra Sessão


***Variables
${url}      https://desenvolvimento.dealernetworkflow.com.br/union

***Test cases
Dado que preciso ter um usuário testautomation
    [tags]      cria
    Quando eu clico no menu "Administração>Segurança>Usuário"
    E não existe usuário testautomation
    Então crio usuário testautomation
    Altero a senha do usuário testautomation
    
Dado que quero alterar a senha do testautomation
    [tags]      alterasenha
    Quando eu clico no menu "Administração>Segurança>Usuário"
    Altero a senha do usuário testautomation

***Keywords
E não existe usuário testautomation
    Select Frame                        xpath=//div[@id="W5Window_0"]//iframe[@class='W5Portal_Window_Frame']
    Input Text                          id:vUSUARIO_IDENTIFICADOR               TESTAUTOMATION
    sleep                               2
    Press keys                          id:vUSUARIO_IDENTIFICADOR               TAB
    #${USER}=                            Run Keyword And Return Status           Get Text            id:span_USUARIO_IDENTIFICADOR_0001
    #${USER_EXIST}=                      Run Keyword And Return Status           Should Be Equal     ${USER}     testautomation
    Page should not contain Element     xpath=//span[contains(text(), 'TESTAUTOMATION')]
    
Então crio usuário testautomation
    #Return From Keyword If              ${USER_EXIST}
    Click Element                       identifier:INSERT
    Input Text                          id:USUARIO_IDENTIFICADOR               TESTAUTOMATION
    Input Text                          id:USUARIO_NOME                        TESTAUTOMATION
    Input Text                          id:USUARIO_EMAIL                       testeautomation@dealernet.com.br
    Select From List By Index           xpath=//select[@id="USUARIO_EMPRESACODDEFAULT"]    1
    Click Element                       id:TRN_ENTER
    Wait Until Element is Visible       id:vDUPLICARUSUARIO_CODIGO
    Input Text                          id:vDUPLICARUSUARIO_CODIGO              1
    Click Element                       id:TRN_ENTER    
    Wait Until Element is Visible       id:FECHAR
    Click Element                       id:FECHAR
    Unselect Frame
    
Altero a senha do usuário testautomation
    Select Frame                        xpath=//div[@id="W5Window_0"]//iframe[@class='W5Portal_Window_Frame']
    Input Text                          id:vUSUARIO_IDENTIFICADOR               TESTAUTOMATION
    sleep                               2
    Press keys                          id:vUSUARIO_IDENTIFICADOR               TAB
    #${USER}=                            Run Keyword And Return Status           Get Text            id:span_USUARIO_IDENTIFICADOR_0001
    #${USER_EXIST}=                      Run Keyword And Return Status           Should Be Equal     ${USER}     testautomation
    Page should contain Element         xpath=//span[contains(text(), 'TESTAUTOMATION')]
    Click element                       id:vUPDATE_0001
    Click element                       id:TROCASENHA
    Select Frame                        id:gxp0_ifrm
    Input Text                          id:WNOVASENHAContainerinputPC       Dea2@20.
    Input Text                          id:WCONFIRMACAOSENHAContainerinputPC       Dea2@20.
    Click Element                       id:TRN_ENTER