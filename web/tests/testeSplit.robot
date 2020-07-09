***Settings
Library     SeleniumLibrary
Library     String

***Variables
${caminho}      Oficina>Relatórios

***Test Cases
Testar Split 
    Split "Produtos>Relatórios>Nota Fiscal>Notas Fiscais Emitidas"

Concatenar Caminho "${caminho}"
    Concat Caminho "${caminho}"

***Keywords
Split "${caminho}"
    @{words} =  Split String    ${caminho}       >
    FOR    ${word}    IN    @{words}
       Log              ${word}
    END

Concat Caminho "${caminho}"
    ${posAtual}=        Set Variable        2
    ${str1}=            Catenate    ${caminho}>Item 
    Run Keyword If      ${posAtual} > 1         Log To Console  ${str1}
    Run Keyword If      ${posAtual} > 1         Set Test Variable       ${str1}     ${str1}>teste
     
    Log To Console  ${str1}
