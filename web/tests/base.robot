***Settings
Library     SeleniumLibrary
Library     ../../libs/DynamicTestCases.py
Library     ../../libs/DateExtraction.py
Library     String

***Variables
${url}                      http://seusite.com.br
${browser}                  chrome

***Keywords
Nova Sessão
    #Open browser                ${url}              chrome
    Run Keyword if      "${browser}" == "chrome"
    ...     Open browser        ${url}              Chrome

    Run Keyword if      "${browser}" == "headless"
    ...     Open browser        ${url}              Headlesschrome

    #Maximize Browser Window
    Set Window Size     1600        900
    Capture Page Screenshot
    Click element               identifier:vUSUARIO_IDENTIFICADORALTERNATIVO        
    Input Text                  identifier:vUSUARIO_IDENTIFICADORALTERNATIVO        USER
    Click element               identifier:vUSUARIOSENHA_SENHA
    Input Text                  identifier:vUSUARIOSENHA_SENHA                      SENHA
    Press keys                  identifier:vUSUARIOSENHA_SENHA                      ENTER
    Set Selenium Implicit Wait  7
    Set Selenium Timeout        7
    #seleciona frame para verificar que já carregou o ícone do timer
    Sleep                                   10
    Select Frame                            xpath=//iframe[@class='NOME_DO_FRAME']          #exemplo usando frame, caso exista
    Wait Until Page Contains Element        xpath=//span[@id='OBJECTID_TO_CHECK_PAGE_LOADED]    #troque por um ID que verifique que a página carregou corretamente
    Unselect Frame                          #necessário fazer unselect para conseguir acessar o menu
    Register Keyword To Run On Failure	    NONE        #neste caso, precisei mudar a keyword que roda ao falhar para NONE, devido uso da keyword "Run Keyword And Return Status", a cada falha, tirava um screenshot.
    
Encerra Sessão 
    Capture Page Screenshot
    Close Browser   

Setup one test for each item "${caminho}"
    #Go To                                   ${url}/portal/default.html
    sleep                                   2

    #Rotina abre o menu para a seguir pegar os elementos dele
    ${posAtual}=        Set Variable        0
    ${posMenu}=         Set Variable        0
    ${add}=             Set Variable        1

    Log To Console      Caminho do Menu Atual: ${caminho}

    @{pedacos} =  Split String    ${caminho}       >
    FOR    ${pedaco}    IN    @{pedacos}
        ${menu}             Set Variable        ${pedaco}
        Exit For Loop
    END
    @{pedacos} =  Split String    ${caminho}       >
    FOR    ${pedaco}    IN    @{pedacos}
        ${posAtual}=        Evaluate        int(${posAtual}) + int(${add})
        Run Keyword If      ${posAtual} == 1        Click element       xpath=//em[contains(.,'${pedaco}')]
        Run Keyword If      ${posAtual} == 1        Continue For Loop
        ${posMenu}=        Evaluate        int(${posAtual}) - int(${add})
        Mouse Over          xpath=//div[@class="x-menu x-menu-floating x-layer" and @style[contains(.,'visibility: visible;')]][${posMenu}]/ul/li/a[contains(.,'${pedaco}')]
    END

    #Seta o xpath para pegar o submenu correto
    ${xpathMenu}        Set Variable        //div[@class='x-menu x-menu-floating x-layer'][${posAtual}]/ul/li/a

    #Pega os itens do menu que foi aberto 
    ${items}=       Get WebElements     ${xpathMenu} 
    
    #Cria os testes para cada um dos elementos. Percorrer os elementos do nível do menu atual, caso seja arrow, chama o mesmo metodo passando o submenu
    FOR    ${item}    IN    @{items}
        ${itemText}=     Get Text     ${item}
        Run Keyword If      "${itemText}" == ""     Continue For Loop
        ${classe}=       Get Element Attribute       ${item}     class
        ${subMenu}=   Catenate    ${caminho}>${itemText}
        Run Keyword If      "${classe}" == "x-menu-item x-menu-item-arrow x-unselectable"       Click element       xpath=//em[contains(.,'${menu}')]
        #Aqui é onde a mágica acontece!
        Run Keyword If      "${classe}" == "x-menu-item x-menu-item-arrow x-unselectable"       Setup one test for each item "${subMenu}"
        Run Keyword If      "${classe}" == "x-menu-item x-unselectable" and "${itemText}" != "SMD" and "${itemText}" != "KPI" and "${itemText}" != "P4P6" and "${itemText}" != "Análise de Tempo da Oficina" and "${itemText}" != "Estatísticas de Retornos" and "${itemText}" != "Orçamento" and "${itemText}" != "RGO" and "${itemText}" != "Pesquisas SMD2" and "${itemText}" != "Programação da Oficina" and "${itemText}" != "Termo de Abertura e Encerramento" and "${itemText}" != "Comprovante de Retenção PIS/COFINS/CSLL/IRPJ" and "${itemText}" != ""
        ...     Add test case       ${subMenu}    Dado que quero gerar relatorio "${subMenu}"
    END

Dado que quero gerar relatorio "${caminho}"
    Quando eu clico no menu "${caminho}"
    E clico para gerar o relatorio sem alterar nenhum parametro
    Então devo ver o relatório na tela
    Capture Page Screenshot

Quando eu clico no menu "${caminho}"
    #Volta para a Home
    Go To                                   ${url}/portal/default.html
    sleep                                   2
    #Rotina abre o menu para a seguir pegar os elementos dele
    ${posAtual}=        Set Variable        0
    ${add}=             Set Variable        1
    #Log To Console      Antes do abrir menu
    @{pedacos} =  Split String    ${caminho}       >
    FOR    ${pedaco}    IN    @{pedacos}
        ${posAtual}=        Evaluate        int(${posAtual}) + int(${add})
        Run Keyword If      ${posAtual} == 1        Click element       xpath=//em[contains(.,'${pedaco}')]
        Run Keyword If      ${posAtual} == 1        Continue For Loop      
        ${posMenu}=         Evaluate        int(${posAtual}) - int(${add})
        Mouse Over          xpath=//div[@class="x-menu x-menu-floating x-layer" and @style[contains(.,'visibility: visible;')]][${posMenu}]/ul/li/a[contains(.,'${pedaco}')]
    END

    #O último 'pedaço' é o nome do report
    ${report_name}      Set Variable     ${pedaco}
    Click element                           xpath=//div[@class="x-menu x-menu-floating x-layer" and @style[contains(.,'visibility: visible;')]][${posMenu}]/ul/li/a[contains(.,'${report_name}')]
    Wait Until Element Contains             class:x-window-header-text        ${report_name}  
    #Log To Console      Abriu o report

E clico para gerar o relatorio sem alterar nenhum parametro
    #sleep                                   2
    Select Frame                            xpath=//div[@id="W5Window_0"]//iframe[@class='W5Portal_Window_Frame']
    #Log To Console      Antes de contar elementos de geração
    Capture Page Screenshot
    
    ${CLICK_GERAR}=      Run Keyword And Return Status              Click element       xpath=//input[contains(@onclick, 'GERAR')]      
    #Log To Console      Return CLICK_GERAR: ${CLICK_GERAR}
    Return From Keyword If    ${CLICK_GERAR}

    ${CLICK_GERARRELATORIO}=      Run Keyword And Return Status     Click element       xpath=//input[contains(@onclick, 'GERARRELATORIO')]      
    #Log To Console      Return CLICK_GERARRELATORIO: ${CLICK_GERARRELATORIO}
    Return From Keyword If    ${CLICK_GERARRELATORIO}

    ${CLICK_CONSULTAR}=      Run Keyword And Return Status          Click element       xpath=//input[contains(@onclick, 'CONSULTAR')]      
    #Log To Console      Return CLICK_CONSULTAR: ${CLICK_CONSULTAR}
    Return From Keyword If    ${CLICK_CONSULTAR}

    ${CLICK_IMPRIMIR}=      Run Keyword And Return Status           Click element       xpath=//input[contains(@onclick, 'IMPRIMIR')]      
    #Log To Console      Return CLICK_IMPRIMIR: ${CLICK_IMPRIMIR}
    Return From Keyword If    ${CLICK_IMPRIMIR}

    ${CLICK_CONFIRMAR}=      Run Keyword And Return Status          Click element       xpath=//input[contains(@onclick, 'CONFIRMAR')]      
    #Log To Console      Return CLICK_CONFIRMAR: ${CLICK_CONSULTAR}
    Return From Keyword If    ${CLICK_CONFIRMAR}

    Log         Não clicou em nenhum botão

Então devo ver o relatório na tela
    ${countError}=      Get Element Count       xpath=//span[@id='ErrorViewer']//div
    Run Keyword If      ${countError} > 0       Loga mensagem de erro    
    Page Should Not Contain Element             xpath=//span[@id='ErrorViewer']//div
    sleep                                   2
    Unselect Frame 
    ${SELECTED_PDF}=                        Run Keyword And Return Status           Select Frame                            xpath=//div[@id="W5Window_1"]//iframe[@class='W5Portal_Window_Frame'and @src[contains(.,'../arel_')]]
    Return From Keyword If                  ${SELECTED_PDF}

    ${SELECTED_FRAME}=                      Run Keyword And Return Status           Select Frame                            xpath=//div[@id="W5Window_1"]//iframe[@class='W5Portal_Window_Frame']
    Run Keyword If  ${SELECTED_FRAME}       Run Keywords
    ...     Wait Until Page Contains Element        xpath=//input[contains(@title, 'Gera o Relatório em Excel')]
    ...     AND     Select Frame                            xpath=//iframe[@name='EMBPAGE']
    ...     AND     Page Should Not Contain Element         xpath=//span[contains(text(), 'Relatório não disponível no momento')]
    ...     AND     Unselect Frame 
    Return From Keyword If                  ${SELECTED_FRAME}

    ${SELECTED_FRAME2}=                         Run Keyword And Return Status           Page Should Contain Element                            xpath=//div[@id='W5Window_1']//div[@class='x-window-bwrap']//div[@class='x-window-body']//title[text()='Redirect Page']
    Run Keyword Unless  ${SELECTED_FRAME2}      Wait Until Page Contains Element        xpath=//div[@id='W5Window_2']//div[@class='x-window-bwrap']//div[@class='x-window-body']//title[text()='Redirect Page']

Loga mensagem de erro
    ${msg_erro}=        Get Text        xpath=//span[@id='ErrorViewer']//div
    Log     Erro ao clicar para gerar: ${msg_erro}
    Capture Page Screenshot

Dado que preciso gerar todos os relatorios da "${report_name}"
    sleep                                   2
    Click element                           xpath=//em[contains(.,'${report_name}')]
    Mouse Over                              xpath=//a[contains(.,'Relatórios')]

Quando eu abro o menu de relatorios
    ${elements}=    Get WebElements         //div[contains(@style,'visibility: visible')][2] | div[@class='x-menu x-menu-floating x-layer x-hide-offsets']
    FOR    ${element}    IN    @{elements}
        Log    ${element.text}
    END                         