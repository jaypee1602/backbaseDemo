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
${URL}                          http://computer-database.herokuapp.com/computers
${BROWSER}                      IE
${computerName1}                Lenovo p52
${introDate1}                   2019-07-08
${discontinueDate1}             2024-07-15
${company1}                     Samsung Electronics
${computerName2}                HP X1
${introDate2}                   2008-1-1
${discontinueDate2}             2012-1-1
${company2}                     Samsung Electronics
${computerName2Edited}          Testcomputer
${introDate2Edited}             2016-12-01
${discontinueDate2Edited}       2019-1-1
${computerNamex}                XXXX
${computerSpecialCharacter}     Ðíäĸřìéŧên & $p€cial€ t€k€n$ met ÁΠĪ’s

*** Test Cases ***
Test Case 1: Verify elements on landingspage
    [Tags]  Happyflow
    [Documentation]  Verifiying elements on initial landingspage
    ...  Precondition:
    ...  Browser variable and url are set
    ...
    ...  Expected result:
    ...  Homepage of http://computerdatabase.herokuapp.com/computers is visible
    ...  All of the elements on the homepage are visible
    ...
    ...  Test steps:
    Open browser and navigate to provided url
    Verify header
    Verify title
    Verify searchbox
    Verify searchbutton
    Verify add computer button
    Verify pagination

Test Case 2: Create new computers
    [Tags]  Happyflow  Create
    [Documentation]  Testing the happy flow of adding a new computer
    ...  Precondition:
    ...  Navigate to create a computer page
    ...
    ...  Expected result:
    ...  Computer is added to database
    ...
    ...  Test steps:
    Open browser and navigate to provided url
    Click 'Add a new computer' button
    Verify add a computer page
    Verify input fields
    Fill in computer 1 name
    Fill in introduction 1 date
    Fill in discontinue 1 date
    Fill in company 1 name
    Click create computer
    Verify created computer 1 message
    Click 'Add a new computer' button
    Fill in computer 2 name
    Fill in introduction 2 date
    Fill in discontinue 2 date
    Fill in company 2 name
    Click create computer
    Verify created computer 2 message

Test Case 3: Verify created computer 1
    [Tags]   Happyflow  Read
    [Documentation]  Checking the first added computer
    ...  Precondition:
    ...  Searchbox has been filled in
    ...  Filter by name has been clicked
    ...
    ...  Expected result:
    ...  Computer is visible in database after search
    ...
    ...  Test steps:
    Open browser and navigate to provided url
    Type computername 1 into searchfield
    Click "Filter by name"
    Verify result computer 1
    Click computer 1
    Veryfy input fields computer 1

Test Case 4: Delete created computer 1
    [Tags]   Happyflow  Delete
    [Documentation]  Deleting the first added computer
    ...  Precondition:
    ...  Searchbox has been filled in
    ...  Filter by name has been clicked
    ...
    ...  Expected result:
    ...  Computer is visible in database after search
    ...
    ...  Test steps:
    Open browser and navigate to provided url
    Type computername 1 into searchfield
    Click "Filter by name"
    Verify result computer 1
    Click computer 1
    Delete computer 1
    Verify delete message

Test Case 5: Edit computer 2 valid
    [Tags]   Happyflow  Edit
    [Documentation]  Editing the second computer with different values
    ...  Precondition:
    ...  Searchbox has been filled in
    ...  Filter by name has been clicked
    ...
    ...  Expected result:
    ...  Edited values are saved to database
    ...
    ...  Test steps:
    Open browser and navigate to provided url
    Type computername 2 into searchfield
    Click "Filter by name"
    Verify result computer 2
    Click computer 2
    Edit computer 2 fields
    Click save this computer
    Verify edited computer

Test Case 6: Edit computer 2 same values
    [Tags]   Sadflow  Edit
    [Documentation]  Editing the second computer with same values
    ...  Precondition:
    ...  Searchbox has been filled in
    ...  Filter by name has been clicked
    ...
    ...  Expected result:
    ...  Message containing nothing has been changed
    ...
    ...  Test steps:
    Open browser and navigate to provided url
    Type computername 2 edited into searchfield
    Click "Filter by name"
    Verify result computer 2 edited
    Click computer 2 edited
    Edit computer 2 fields
    Click save this computer
    Verify edited computer

Test Case 7: Search non-existing computer
    [Tags]   Sadflow  Edit
    [Documentation]  Filter a computer that does not exist
    ...  Precondition:
    ...  Searchbox has been filled in
    ...  Filter by name has been clicked
    ...
    ...  Expected result:
    ...  Error message with no computers found
    ...
    ...  Test steps:
    Open browser and navigate to provided url
    Type computername x into searchfield
    Click "Filter by name"
    Verify error message

Test Case 8: Testing input fields exeptions
     [Tags]   Sadflow  exeptions
    [Documentation]  Testing input fields
    ...  Precondition:
    ...  Add a computer screen is visible
    ...
    ...  Expected result:
    ...  Error message when the requirements of fields have been met
    ...
    ...  Test steps:
    Open browser and navigate to provided url
    Click 'Add a new computer' button
    Verify required fields
    Verify invalid date introduced date
    Verify invalid date discontinue date
    Verify valid indtroduced and invalid discontinue date

Test Case 9: Verify special characters
    [Tags]   Sadflow  exeptions
    [Documentation]  Testing input fields for special characters
    ...  Precondition:
    ...  Add a computer screen is visible
    ...
    ...  Expected result:
    ...  New computer is added with special characters
    ...
    ...  Test steps:
    Open browser and navigate to provided url
    Click 'Add a new computer' button
    Fill in computername special charaters
    Click create computer
    Verify creater computer special message

Test Case 10: Delete all added computers
    [Tags]   Reset  test1
    [Documentation]  Resets database to previous state
    ...  Precondition:
    ...  The computers in this tests have been added
    ...
    ...  Expected result:
    ...  The computers in this tests will be removed
    ...
    ...  Test steps:
    Open browser and navigate to provided url
    Delete all added computers


*** Keywords ***
Open browser and navigate to provided url
    Open browser  ${URL}   ${BROWSER}
#    [Documentation]   This keyword creates a webdriver with provided webbrowser
#    [Arguments]    ${alias}=${EMPTY}
#    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
#    Call Method    ${options}    add_argument    disable-web-security
#    Call Method    ${options}    add_argument    disable-infobars
#    Create WebDriver    Chrome    alias=${alias}    chrome_options=${options}

Close current browser
    SeleniumLibrary.Close Browser

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
    Sleep  1s

Verify input fields
    SeleniumLibrary.Page should contain element    id=name
    SeleniumLibrary.Page should contain element    id=introduced
    SeleniumLibrary.Page should contain element    id=discontinued
    SeleniumLibrary.Page should contain element    id=company
    Sleep  1s

Fill in computer 1 name
    Input text   id=name  ${computerName1}
    Sleep  1s

Fill in introduction 1 date
    Input text   id=introduced  ${introDate1}
    Sleep  1s

Fill in discontinue 1 date
    Input text   id=discontinued  ${discontinueDate1}
    Sleep  1s

Fill in company 1 name
    Click element    id=company
    Click element    //*[contains(text(),"Samsung Electronics")]
    Sleep  1s

Click create computer
    Click element    //*[@class="btn primary"]
    Sleep  1s

Verify created computer 1 message
    #Page should contain element  //*[@id="main"]//*[contains(text()," Computer ${computerName1} has been created")]
    Element should contain   //*[@id="main"]/div[1]   Computer ${computerName1} has been created

Fill in computer 2 name
    Input text   id=name  ${computerName2}
    Sleep  1s

Fill in introduction 2 date
    Input text   id=introduced  ${introDate2}
    Sleep  1s

Fill in discontinue 2 date
    Input text   id=discontinued  ${discontinueDate2}
    Sleep  1s

Fill in company 2 name
    Click element    id=company
    Click element    //*[contains(text(),"Samsung Electronics")]
    Sleep  1s

Verify created computer 2 message
    #Page should contain element  //*[@class="alert-message warning"]//strong[contains(text()," Computer ${computerName2} has been created")]
    Element should contain   //*[@id="main"]/div[1]   Computer ${computerName2} has been created

Type computername 1 into searchfield
    Input text   id=searchbox   ${computerName1}
    Sleep  1s

Type computername 2 into searchfield
    Input text   id=searchbox   ${computerName2}
    Sleep  1s

Type computername 2 edited into searchfield
    Input text   id=searchbox   ${computerName2Edited}
    Sleep  1s

Click "Filter by name"
    Click element   id=searchsubmit
    Sleep  1s

Verify result computer 1
    Page should contain       ${computerName1}
    Sleep  1s

Verify result computer 2
    Page should contain       ${computerName2}
    Sleep  1s

Verify result computer 2 edited
    Page should contain       ${computerName2Edited}
    Sleep  1s

Click computer 1
    Click element   //*[contains(text(),"${computerName1}")]
    Sleep  1s

Click computer 2
    Click element   //*[contains(text(),"${computerName2}")]
    Sleep  1s

Click computer 2 edited
    Click element   //*[contains(text(),"${computerName2Edited}")]
    Sleep  1s

Veryfy input fields computer 1
    ${name}  Get element attribute   id=name   value
    should be equal as strings    ${name}   ${computerName1}
    ${intro}  Get element attribute  id=introduced  value
    should be equal as strings    ${intro}   ${introDate1}
    ${discontinue}  Get element attribute  id=discontinued  value
    should be equal as strings    ${discontinue}   ${discontinueDate1}
    ${company}  Get element attribute  id=company  value
    should be equal    ${company}   43

Delete computer 1
    Click element   //*[@class="btn danger"]

Verify delete message
    Element should contain   //*[@id="main"]/div[1]  Done! Computer has been deleted

Edit computer 2 fields
    Input text   id=name  ${computerName2Edited}
    Sleep  1s
    Input text   id=introduced  ${introDate2Edited}
    Sleep  1s
    Input text   id=discontinued  ${discontinueDate2Edited}
    Sleep  1s
    Click element    id=company
    Click element    //*[contains(text(),"Canon")]
    Sleep  1s

Click save this computer
    Click element    //*[@class="btn primary"]
    Sleep  1s

Verify edited computer
     Element should contain   //*[@id="main"]/div[1]   Computer ${computerName2Edited} has been updated

Type computername x into searchfield
    Input text   id=searchbox   ${computerNamex}
    Sleep  1s

Verify error message
     Element should contain   //*[@id="main"]/h1   No computers found
     Element should contain   //*[@id="main"]/div[2]   Nothing to display

Verify required fields
    Click create computer
    Page should contain element   //*[@class="clearfix error"]//*[contains(text(),"Required")]


Verify invalid date introduced date
    Input text   id=introduced   000000
    Click create computer
    Page should contain element   //*[@class="clearfix error"]//*[@id="introduced"]

Verify invalid date discontinue date
    Input text   id=discontinued   xxxxxxx
    Click create computer
    Page should contain element   //*[@class="clearfix error"]//*[@id="discontinued"]

Verify valid indtroduced and invalid discontinue date
    Clear Element Text   id=introduced
    Input text   id=introduced   2019-12-12
    Click create computer
    Page should not contain element   //*[@class="clearfix error"]//*[@id="introduced"]
    Page should contain element   //*[@class="clearfix error"]//*[@id="discontinued"]

Fill in computername special charaters
    Input text   id=name  ${computerSpecialCharacter}

Search computername special charaters
    Input text   id=searchbox  ${computerSpecialCharacter}

Verify creater computer special message
    Element should contain   //*[@id="main"]/div[1]  Done! Computer ${computerSpecialCharacter} has been created

Click delete and verify message
    Click element  //*[@class="btn danger"]
    Sleep  1s
    Element should contain   //*[@id="main"]/div[1]  Done! Computer has been deleted
    Sleep  1s

Click computer with special characters
    Click element   //*[contains(text(),"${computerSpecialCharacter}")]
    Sleep  1s

Delete all added computers
    Type computername 2 edited into searchfield
    Click "Filter by name"
    Click computer 2 edited
    Click delete and verify message
    Search computername special charaters
    Click "Filter by name"
    Click computer with special characters
    Click delete and verify message