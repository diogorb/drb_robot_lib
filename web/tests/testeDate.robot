***Settings
Library     SeleniumLibrary
Library     DateTime
Library     ../../libs/DateExtraction.py

***Test Cases
Data atual 
    ${date}= 	Get Current Date    result_format=datetime
    ${month}=   Set Variable    ${date.year}
    Set Suite Variable   ${date}
    Log To Console    ${date}

Add data 
    ${date}=	Add Time To Date	${date}	-30 days
    Log To Console      ${date}
    #Log To Console      ${date.month}
    #Log To Console      01/${date.month}/2020

Month and year
   ${currentYear}=    Get Current Date  result_format=%y
   ${currentDate}=    Get Current Date
   ${datetime} =  Convert Date  ${currentDate}    datetime
   ${getMonth}=   evaluate   ${datetime.month} - 1
   log to console   ${getMonth}

Month and year by python lib
   ${current_date} =  DateExtraction.Return Inicio do Mes Anterior
   log to console  ${current_date}