*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Registration Page
Suite Teardown    Close Browser
Test Teardown     Go To Registration Page

*** Variables ***
${BROWSER}        firefox
${URL}            http://127.0.0.1:7272/TestAutomationLab/StarterFiles/Registration.html

${FIRST_NAME}     Somyod
${LAST_NAME}      Sodsai
${ORG}            CS KKU
${EMAIL}          somyod@kkumail.com
${PHONE_GOOD}     091-001-1234
${PHONE_BAD}      1234

*** Test Cases ***
Open Workshop Registration Page
    Open Browser   ${URL}   ${BROWSER}
    Welcome Page Should Be Open
    


Register Success
    Fill Form    ${FIRST_NAME}    ${LAST_NAME}    ${ORG}    ${EMAIL}    ${PHONE_GOOD}
    Submit
    Verify Success

Register Success No Organization Info
    Fill Form    ${FIRST_NAME}    ${LAST_NAME}    ${EMPTY}    ${EMAIL}    ${PHONE_GOOD}
    Submit
    Verify Success

Empty First Name
    Fill Form    ${EMPTY}    ${LAST_NAME}    ${ORG}    ${EMAIL}    ${PHONE_GOOD}
    Submit
    Verify Error    Please enter your first name!!

Empty Last Name
    Fill Form    ${FIRST_NAME}    ${EMPTY}    ${ORG}    ${EMAIL}    ${PHONE_GOOD}
    Submit
    Verify Error    Please enter your last name!!

Empty First Name and Last Name
    Fill Form    ${EMPTY}    ${EMPTY}    ${ORG}    ${EMAIL}    ${PHONE_GOOD}
    Submit
    Verify Error    Please enter your name!!

Empty Email
    Fill Form    ${FIRST_NAME}    ${LAST_NAME}    ${ORG}    ${EMPTY}    ${PHONE_GOOD}
    Submit
    Verify Error    Please enter your email!!

Empty Phone Number
    Fill Form    ${FIRST_NAME}    ${LAST_NAME}    ${ORG}    ${EMAIL}    ${EMPTY}
    Submit
    Verify Error    Please enter your phone number!!

Invalid Phone Number
    Fill Form    ${FIRST_NAME}    ${LAST_NAME}    ${ORG}    ${EMAIL}    ${PHONE_BAD}
    Submit
     Verify Error    Please enter a valid phone number, e.g., 081-234-5678, 081 234 5678, or 081.234.5678)

*** Keywords ***
Welcome Page Should Be Open
    Location Should Be    ${URL}
    Title Should Be    Registration 
Open Registration Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Go To Registration Page
    Go To    ${URL}

Fill Form
    [Arguments]    ${fname}    ${lname}    ${org}    ${email}    ${phone}
    Input Text    id=firstname       ${fname}
    Input Text    id=lastname        ${lname}
    Input Text    id=organization    ${org}
    Input Text    id=email           ${email}
    Input Text    id=phone           ${phone}

Submit
    Click Button    Register

Verify Success
    Title Should Be    Success
    Page Should Contain    Thank you for registering with us.
    Page Should Contain    We will send a confirmation to your email soon.

Verify Error
    [Arguments]    ${msg}
    Title Should Be    Registration
    Page Should Contain    ${msg}
