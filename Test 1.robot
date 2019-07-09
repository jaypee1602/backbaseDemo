*** Settings ***
Documentation     This suite tests the herokuapp site to check
...               if basic functionality works properly
Library           Dialogs
Library           SeleniumLibrary
Library           OperatingSystem
Library           DateTime
Library           Collections
Library           String
Library           BuiltIn
#Library           AppiumLibrary
Test Teardown     Close current browser

*** Variables ***
${URL}                  http://computer-database.herokuapp.com/computers
${BROWSER}              Chrome
${computerName1}        Lenovo p52
${introDate1}           08-07-2019
${discontinueDate1}     15-07-2024
${company1}             Samsung Electronics
${computerName2}        HP X1
${introDate1}           1-1-2008
${discontinueDate1}     1-1-2012
${company1}             Hewlett-Packard

*** Test Cases ***
Test Case 1: Navigate to Landingpage
    [Documentation]  Navigate and validate computer database gui
    [Tags]  Happyflow
    Open browser
    Navigate to provided url

Test Case 2: Verify elements on landingspage
    [Documentation]  Verifiying elements on initial landingspage
    [Tags]  Happyflow
    Open browser
    Navigate to provided url
    Verify header
    Verify title
    Verify searchbox
    Verify searchbutton
    Verify add computer button
    Verify pagination

Test Case 3: Create new computer
    [Documentation]  Testing the happy flow of adding a new computer
    [Tags]  Happyflow  Create
    Open browser
    Navigate to provided url
    Sleep  1s
    Click 'Add a new computer' button
    Sleep  1s
    Verify add a computer page
    Sleep  1s
    Verify input fields
    Sleep  1s
    Fill in computer name
    Sleep  1s
    Fill in introduction date
    Sleep  1s
    Fill in discontinue date
    Sleep  1s
    Fill in company name
    Sleep  1s
    Click create computer

#Test Case 4: Verify created computer
#    [Documentation]  Cheking the newly added computer
#    [Tags]   Happyflow  Delete
#
#Test Case 4: Testing input fields
#    [Documentation]  Testing the happy flow of adding a new computer
#    [Tags]  Fields
#    Open browser
#    Navigate to provided url
#    Click 'Add a new computer' button
#    Verify required fields
#    Verify special characters
#    Verify min length
#    Verify max length
#    Verify copy/paste
#    Verify resizing
#
#Test Case 5: Validate added computer
#    [Documentation]  Testing the happy flow of adding a new computer
#    [Tags]  Happyflow  Delete
#    Open browser
#    Navigate to provided url
#    Click on filter field
#    Input created computer name
#    Click 'filter by name'

# In the manual tests:
# Resizing

*** Keywords ***
Open browser
    [Documentation]   This keyword creates a webdriver with provided webbrowser
    [Arguments]    ${alias}=${EMPTY}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    disable-web-security
    Call Method    ${options}    add_argument    disable-infobars
    Create WebDriver    Chrome    alias=${alias}    chrome_options=${options}

Close current browser
    SeleniumLibrary.Close Browser

Navigate to provided url
    Go To    ${URL}

Verify header
    SeleniumLibrary.Page should contain element   //*[@class="topbar"]//*[contains(text(),"Play sample application — Computer database")]

Verify title
    ${message}  Get Text  //*[@id="pagination"]/ul/li[2]/a
    ${aantal}  Get substring  ${message}  -3
    SeleniumLibrary.Page should contain   ${aantal} computers found
    Set suite variable   ${aantal}

Verify searchbox
    SeleniumLibrary.Page should contain element  id=searchbox
    ${placeholder}	Get Element Attribute  id=searchbox  placeholder
    Should be equal as strings   ${placeholder}   Filter by computer name...

Verify searchbutton
    SeleniumLibrary.Page should contain element    id=searchsubmit
    ${value}	Get Element Attribute    id=searchsubmit  value
    Should be equal as strings   ${value}   Filter by name

Verify add computer button
    SeleniumLibrary.Page should contain element   id=add
    Element should contain   id=add  Add a new computer

Verify pagination
    SeleniumLibrary.Page should contain element    id=pagination
    SeleniumLibrary.Page should contain element    //*[@class="prev disabled"]
    SeleniumLibrary.Page should contain element    //*[@class="next"]
    SeleniumLibrary.Page should contain element    //*[@class="current"]//a[contains(text(),"Displaying 1 to 10 of ${aantal}")]

Click 'Add a new computer' button
    SeleniumLibrary.Click element   id=add

Verify add a computer page
    SeleniumLibrary.Page should contain element    //*[@id="main"]//*[contains(text(),"Add a computer")]
    SeleniumLibrary.Page should contain element    //*[@class="actions"]//*[@value="Create this computer"]
    SeleniumLibrary.Page should contain element    //*[@class="actions"]//*[contains(text(),"Cancel")]

Verify input fields
    SeleniumLibrary.Page should contain element    id=name
    SeleniumLibrary.Page should contain element    id=introduced
    SeleniumLibrary.Page should contain element    id=discontinued
    SeleniumLibrary.Page should contain element    id=company

Fill in computer name
    Input text   id=name  ${computerName1}

Fill in introduction date
    Input text   id=introduced  ${introDate1}

Fill in discontinue date
    Input text   id=discontinued  ${discontinueDate1}

Fill in company name
    Click element    id=company
    Scroll Element into view   //*[@id="company"]/option[43]
    Click element    //*[contains(text(),"Samsung Electronics")]

Click create computer
    Click element    //*[@class="btn primary"]