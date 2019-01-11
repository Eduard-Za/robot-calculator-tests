*** Settings ***
Documentation     Simple calculations tests
Test Setup        Open calulator
Test Teardown     Close browser
Library           Selenium2Library
Library           divide.py

*** Variables ***
${BROWSER}        Chrome
${URL}            https://web2.0calc.com/
&{locators}       0=Btn0    1=Btn1    2=Btn2    3=Btn3    4=Btn4    5=Btn5    6=Btn6  7=Btn7    8=Btn8    9=Btn9
...    plus=BtnPlus    minus=BtnMinus    times=BtnMult    divided_by=BtnDiv    calculate=BtnCalc
${path}           executable_path=chromedriver.exe

*** Test Cases ***
Addition
    Calculate 1 plus 5
    Verify answer 6

Subtraction
    Calculate 20 minus 7
    Verify answer 13

Multiplication
    Calculate 3 times 5
    Verify answer 15

Division
    Calculate 14 divided_by 2
    Verify answer 7

*** Keywords ***
Open calulator
    Create Webdriver    Chrome   ${path}
    go to  ${URL}
    maximize browser window
    Page Should Contain Element    display
    Click Button  yes

Input value
     [Arguments]  ${digits}
     @{VALUES}  divide to digits  ${digits}
    :FOR    ${value}    IN    @{VALUES}
    \    Click Button  &{locators}[${value}]


Calculate ${value1} ${operation} ${value2}
    Input value  ${value1}
    Click Button    &{locators}[${operation}]
    Input value  ${value2}
    Click Button   &{locators}[calculate]

Verify answer ${answer}
    wait for condition  return jQuery.active == 0
    ${value}  Get Element Attribute    input    value
    Should Be Equal As Integers    ${value}    ${answer}