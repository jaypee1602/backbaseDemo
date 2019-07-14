*** Settings ***
Documentation     This suite tests the herokuapp site to check
...               if basic functionality works properly
Library           Dialogs
Library           SeleniumLibrary  run_on_failure=Nothing
Library           OperatingSystem
Library           DateTime
Library           Collections
Library           String
Library           BuiltIn
Library           AppiumLibrary  run_on_failure=Nothing
Test Teardown     Close current browser

*** Variables ***
${URL}                          http://computer-database.herokuapp.com/computers
${BROWSER}                      Chrome
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
${device}                       ${EMPTY}

*** Test Cases ***
Test Case 0: Check device
    [Tags]   Happyflow  Check
    ${output}  Run  adb devices
    Log  ${output}
    set suite variable   ${output}
    ${lines}  Get line count  ${output}
    Run keyword if  '${lines}'=='1'
    ...  run keywords
    ...  log to console  There is no mobile device connected, running the tests on a computer.
    ...  AND  set global variable  ${device}  Laptop

    Run keyword if  '${lines}'>'1'  Check 2



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
    [Tags]  Happyflow
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
    Fill in computer 2
    Create & verify computer 2

Test Case 3: Verify created computer 1
    [Tags]   Happyflow
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
    Verify input fields computer 1

Test Case 4: Delete created computer 1
    [Tags]   Happyflow
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
    [Tags]   Reset
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
Check 2
    ${msg}  Get line  ${output}  1
    ${status}  run keyword and return status   Should contain  ${msg}  device
    Run keyword if  ${status}==False
    ...  run keywords
    ...  log to console  There is no mobile device connected, running the tests on a computer.
    ...  AND  set global variable  ${device}  Laptop
    ...  ELSE
    ...  run keywords
    ...  log to console  Found a connected mobile device, running the tests on this device.
    ...  AND  Set up mobile device

Open browser and navigate to provided url
    Run keyword if  '${device}'=='Laptop'  Open browser  ${URL}   ${BROWSER}  ELSE  go to url  ${URL}
#    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
#    Call Method    ${options}    add_argument    disable-web-security
#    Call Method    ${options}    add_argument    disable-infobars
#    Create WebDriver    Chrome    alias=${alias}    chrome_options=${options}

Close current browser
    Run keyword if  '${device}'=='Laptop'
    ...  Run Keyword If Test Failed  SeleniumLibrary.Capture page screenshot
    ...  ELSE IF  '${device}'=='Phone'  Run Keyword If Test Failed  AppiumLibrary.Capture page screenshot
    Run keyword if  '${device}'=='Laptop'  SeleniumLibrary.Close Browser

Verify header
    Sleep  1s
    Run keyword if  '${device}'=='Laptop'      SeleniumLibrary.Page should contain element   //*[@class="topbar"]//*[contains(text(),"Play sample application — Computer database")]
    ...  ELSE     AppiumLibrary.Page Should Contain Text   Play sample application — Computer database

Verify title
    Run keyword if  '${device}'=='Laptop'   Verify title laptop

Verify title laptop
      ${message}  SeleniumLibrary.Get Text  //*[@id="pagination"]/ul/li[2]/a
      ${aantal}  Get substring  ${message}  -3
      SeleniumLibrary.Page should contain   ${aantal} computers found
      Set suite variable   ${aantal}

Verify searchbox
    Sleep  1s
    Run keyword if  '${device}'=='Laptop'   Verify searchbox laptop  ELSE  Verify searchbox phone

Verify searchbox laptop
    SeleniumLibrary.Page should contain element  id=searchbox
    ${placeholder}	SeleniumLibrary.Get Element Attribute  id=searchbox  placeholder
    Should be equal as strings   ${placeholder}   Filter by computer name...

Verify searchbox phone
    Sleep  1s
    AppiumLibrary.Page Should Contain element  	//hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.webkit.WebView/android.view.View[2]/android.view.View[2]/android.view.View[1]/android.widget.EditText


Verify searchbutton
    Run keyword if  '${device}'=='Laptop'   Verify searchbutton laptop

Verify searchbutton laptop
    SeleniumLibrary.Page should contain element    id=searchsubmit
    ${value}	SeleniumLibrary.Get Element Attribute    id=searchsubmit  value
    Should be equal as strings   ${value}   Filter by name

Verify add computer button
    Run keyword if  '${device}'=='Laptop'   Verify searchbutton laptop  ELSE  Verify add computer button phone

Verify add computer button laptop
    SeleniumLibrary.Page should contain element   id=add
    Element should contain   id=add  Add a new computer

Verify add computer button phone
    Sleep  1s
    AppiumLibrary.Page Should Contain Text  Add a new computer
Verify pagination
    Run keyword if  '${device}'=='Laptop'   Verify pagination laptop  ELSE  Verify pagination phone

Verify pagination laptop
    SeleniumLibrary.Page should contain element    id=pagination
    SeleniumLibrary.Page should contain element    //*[@class="prev disabled"]
    SeleniumLibrary.Page should contain element    //*[@class="next"]
    SeleniumLibrary.Page should contain element    //*[@class="current"]//a[contains(text(),"Displaying 1 to 10 of ${aantal}")]

Verify pagination phone
    AppiumLibrary.Page Should Contain Text  Displaying 1 to 10

Click 'Add a new computer' button
    Run keyword if  '${device}'=='Laptop'   Click 'Add a new computer' button laptop   ELSE  Click 'Add a new computer' button phone

Click 'Add a new computer' button laptop
    SeleniumLibrary.Click element   id=add

Click 'Add a new computer' button phone
     Sleep  1s
     AppiumLibrary.Click text  Add a new computer
Verify add a computer page
    Run keyword if  '${device}'=='Laptop'   Verify add a computer page laptop  ELSE  Verify add a computer page phone

Verify add a computer page laptop
    SeleniumLibrary.Page should contain element    //*[@id="main"]//*[contains(text(),"Add a computer")]
    SeleniumLibrary.Page should contain element    //*[@class="actions"]//*[@value="Create this computer"]
    SeleniumLibrary.Page should contain element    //*[@class="actions"]//*[contains(text(),"Cancel")]
    Sleep  1s

Verify add a computer page phone
    Sleep  1s
    AppiumLibrary.Page should contain text  Add a computer
    AppiumLibrary.Page should contain text  Create this computer
    AppiumLibrary.Page should contain text  Cancel

Verify input fields
    Run keyword if  '${device}'=='Laptop'   Verify input fields laptop  ELSE  Verify input fields phone

Verify input fields laptop
    SeleniumLibrary.Page should contain element    id=name
    SeleniumLibrary.Page should contain element    id=introduced
    SeleniumLibrary.Page should contain element    id=discontinued
    SeleniumLibrary.Page should contain element    id=company
    Sleep  1s

Verify input fields phone
    AppiumLibrary.Page should contain element    //*[@resource-id="name"]
    AppiumLibrary.Page should contain element    //*[@resource-id="introduced"]
    AppiumLibrary.Page should contain element    //*[@resource-id="discontinued"]
    AppiumLibrary.Page should contain element    //*[@resource-id="company"]

Fill in computer 1 name
    Run keyword if  '${device}'=='Laptop'   Fill in computer 1 name laptop  ELSE  Fill in computer 1 name phone

Fill in computer 1 name laptop
    SeleniumLibrary.Input text   id=name  ${computerName1}
    Sleep  1s

Fill in computer 1 name phone
    AppiumLibrary.Input text   //*[@resource-id="name"]  ${computerName1}

Fill in introduction 1 date
    Run keyword if  '${device}'=='Laptop'  Fill in introduction 1 date laptop  ELSE  Fill in introduction 1 date phone

Fill in introduction 1 date laptop
    SeleniumLibrary.Input text   id=introduced  ${introDate1}
    Sleep  1s

Fill in introduction 1 date phone
    AppiumLibrary.Input text   //*[@resource-id="introduced"]  ${introDate1}

Fill in discontinue 1 date
    Run keyword if  '${device}'=='Laptop'   Fill in discontinue 1 date laptop  ELSE  Fill in discontinue 1 date phone

Fill in discontinue 1 date laptop
    SeleniumLibrary.Input text   id=discontinued  ${discontinueDate1}
    Sleep  1s

Fill in discontinue 1 date phone
    AppiumLibrary.Input text   //*[@resource-id="discontinued"]  ${discontinueDate1}

Fill in company 1 name
    Run keyword if  '${device}'=='Laptop'   Fill in company 1 name laptop  ELSE  Fill in company 1 name phone

Fill in company 1 name laptop
    SeleniumLibrary.Click element    id=company
    SeleniumLibrary.Click element    //*[contains(text(),"Samsung Electronics")]
    Sleep  1s

Fill in company 1 name phone
    AppiumLibrary.Click element    //*[@resource-id="company"]
    Sleep  1s
    Swipe By Percent	80  80  80  20  duration=1000
    Swipe By Percent	80  80  80  20  duration=1000
    Swipe By Percent	80  80  80  20  duration=1000
    Swipe By Percent	80  80  80  20  duration=1000
    AppiumLibrary.Click text  Samsung Electronics
    Sleep  1s

Click create computer
    Run keyword if  '${device}'=='Laptop'  SeleniumLibrary.Click element    //*[@class="btn primary"]  ELSE  AppiumLibrary.Click text  Create this computer
    Sleep  1s

Verify created computer 1 message
    #Page should contain element  //*[@id="main"]//*[contains(text()," Computer ${computerName1} has been created")]
     Run keyword if  '${device}'=='Laptop'  Element should contain   //*[@id="main"]/div[1]   Computer ${computerName1} has been created
     ...  ELSE IF  '${device}'=='Phone'  AppiumLibrary.Page Should Contain Text  Done! Computer ${computerName1} has been created

Fill in computer 2
    Run keyword if  '${device}'=='Laptop'  Fill in computer 2 laptop  ELSE  Fill in computer 2 phone

Fill in computer 2 laptop
    Sleep  1s
    SeleniumLibrary.Input text   id=name  ${computerName2}
    Sleep  1s
    SeleniumLibrary.Input text   id=introduced  ${introDate2}
    Sleep  1s
    SeleniumLibrary.Input text   id=discontinued  ${discontinueDate2}
    Sleep  1s
    SeleniumLibrary.Click element    id=company
    Sleep  1s
    SeleniumLibrary.Click element   //*[contains(text(),"HTC Corporation")]
    Click create computer


Fill in computer 2 phone
    Sleep  1s
    AppiumLibrary.Input text   //*[@resource-id="name"]  ${computerName2}
    AppiumLibrary.Input text   //*[@resource-id="introduced"]  ${introDate1}
    AppiumLibrary.Input text   //*[@resource-id="discontinued"]  ${discontinueDate1}
    AppiumLibrary.Click element    //*[@resource-id="company"]
    Sleep  1s
    Swipe By Percent	80  80  80  20  duration=1000
    Swipe By Percent	80  80  80  20  duration=1000
    Swipe By Percent	80  80  80  20  duration=1000
    Swipe By Percent	80  80  80  20  duration=1000
    AppiumLibrary.Click text  HTC Corporation
    Sleep  1s
    Click create computer

Create & verify computer 2
    Sleep  1s
    #Page should contain element  //*[@class="alert-message warning"]//strong[contains(text()," Computer ${computerName2} has been created")]
    Run keyword if  '${device}'=='Laptop'  Element should contain   //*[@id="main"]/div[1]   Computer ${computerName2} has been created  ELSE   AppiumLibrary.Page Should Contain Text  Done! Computer ${computerName2} has been created

Type computername 1 into searchfield
    Run keyword if  '${device}'=='Laptop'  SeleniumLibrary.Input text   id=searchbox   ${computerName1}
    ...  ELSE  Run keywords  AppiumLibrary.Wait Until Page Contains Element  //*[@resource-id="searchbox"]
    ...  AND   AppiumLibrary.Input text   //*[@resource-id="searchbox"]  ${computerName1}
    Sleep  1s

Type computername 2 into searchfield
    Run keyword if  '${device}'=='Laptop'  SeleniumLibrary.Input text   id=searchbox   ${computerName2}
    ...  ELSE   Run keywords  AppiumLibrary.Wait Until Page Contains Element  //*[@resource-id="searchbox"]
    ...  AND   AppiumLibrary.Input text   //*[@resource-id="searchbox"]  ${computerName2}
    Sleep  1s

Type computername 2 edited into searchfield
    Run keyword if  '${device}'=='Laptop'  SeleniumLibrary.Input text   id=searchbox   ${computerName2Edited}
    ...  ELSE   Run keywords  AppiumLibrary.Wait Until Page Contains Element  //*[@resource-id="searchbox"]
    ...  AND   AppiumLibrary.Input text   //*[@resource-id="searchbox"]  ${computerName2Edited}
    Sleep  1s

Click "Filter by name"
    Run keyword if  '${device}'=='Laptop'  SeleniumLibrary.Click element   id=searchsubmit
    ...  ELSE   AppiumLibrary.Click element   //*[@resource-id="searchsubmit"]
    Sleep  1s

Verify result computer 1
    Run keyword if  '${device}'=='Laptop'  SeleniumLibrary.Page should contain       ${computerName1}
    ...  ELSE   AppiumLibrary.Page should contain text      ${computerName1}
    Sleep  1s

Verify result computer 2
    Run keyword if  '${device}'=='Laptop'  SeleniumLibrary.Page should contain       ${computerName2}
    ...  ELSE   AppiumLibrary.Page Should Contain Text       ${computerName2}
    Sleep  1s

Verify result computer 2 edited
    Run keyword if  '${device}'=='Laptop'  SeleniumLibrary.Page should contain       ${computerName2Edited}
    ...  ELSE   AppiumLibrary.Page Should Contain Text       ${computerName2Edited}
    Sleep  1s

Click computer 1
    Run keyword if  '${device}'=='Laptop'  SeleniumLibrary.Click element   //*[contains(text(),"${computerName1}")]
    ...  ELSE   Run keywords   Clear text   //*[@resource-id="searchbox"]
    ...  AND  Sleep  1s
    ...  AND  AppiumLibrary.Click element at coordinates   60  480
    Sleep  1s

Click computer 2
    Run keyword if  '${device}'=='Laptop'  SeleniumLibrary.Click element   //*[contains(text(),"${computerName2}")]
    ...  ELSE   Run keywords   Clear text   //*[@resource-id="searchbox"]
    ...  AND  Sleep  1s
    ...  AND  AppiumLibrary.Click element at coordinates   60  480
    Sleep  1s

Click computer 2 edited
    Run keyword if  '${device}'=='Laptop'  SeleniumLibrary.Click element   //*[contains(text(),"${computerName2Edited}")]
    ...  ELSE  Run keywords   Clear text   //*[@resource-id="searchbox"]
    ...  AND  Sleep  1s
    ...  AND  AppiumLibrary.Click element at coordinates   60  480
    Sleep  1s

Verify input fields computer 1
    Run keyword if  '${device}'=='Laptop'  Verify input fields computer 1 laptop
    ...  ELSE  Verify input fields computer phone

Verify input fields computer 1 laptop
    ${name}  SeleniumLibrary.Get element attribute  id=name   value
    should be equal as strings    ${name}   ${computerName1}
    ${intro}  SeleniumLibrary.Get element attribute  id=introduced  value
    should be equal as strings    ${intro}   ${introDate1}
    ${discontinue}  SeleniumLibrary.Get element attribute id=discontinued  value
    should be equal as strings    ${discontinue}   ${discontinueDate1}
    ${company}  SeleniumLibrary.Get element attribute  id=company  value
    should be equal    ${company}   43

Verify input fields computer phone
    AppiumLibrary.Page should contain element   //*[@resource-id="name"]
    AppiumLibrary.Page should contain element   //*[@resource-id="introduced"]
    AppiumLibrary.Page should contain element   //*[@resource-id="discontinued"]

Delete computer 1
    Run keyword if  '${device}'=='Laptop'  SeleniumLibrary.Click element   //*[@class="btn danger"]
    ...  ELSE   AppiumLibrary.Click text  	Delete this computer

Verify delete message
    Run keyword if  '${device}'=='Laptop'  SeleniumLibrary.Element should contain   //*[@id="main"]/div[1]  Done! Computer has been deleted
    ...  ELSE   run keywords
    ...  Sleep  2s
    ...  AND  AppiumLibrary.Page Should Contain Text  Done! Computer has been deleted

Edit computer 2 fields
    Run keyword if  '${device}'=='Laptop'  Edit computer 2 fields laptop
    ...  ELSE   Edit computer 2 fields phone

Edit computer 2 fields laptop
    SeleniumLibrary.Input text   id=name  ${computerName2Edited}
    Sleep  1s
    SeleniumLibrary.Input text   id=introduced  ${introDate2Edited}
    Sleep  1s
    SeleniumLibrary.Input text   id=discontinued  ${discontinueDate2Edited}
    Sleep  1s
    SeleniumLibrary.Click element    id=company
    SeleniumLibrary.Click element    //*[contains(text(),"Canon")]
    Sleep  1s

Edit computer 2 fields phone
    AppiumLibrary.Input text   //*[@resource-id="name"]  ${computerName2Edited}
    AppiumLibrary.Input text   //*[@resource-id="introduced"]  ${introDate2Edited}
    AppiumLibrary.Input text   //*[@resource-id="discontinued"]  ${discontinueDate2Edited}
    AppiumLibrary.Click element    //*[@resource-id="company"]
    Sleep  1s
    Swipe By Percent	80  80  80  20  duration=1000
    AppiumLibrary.Click text  ASUS

Click save this computer
    Run keyword if  '${device}'=='Laptop'  SeleniumLibrary.Click element    //*[@class="btn primary"]
    ...  ELSE   AppiumLibrary.Click text  Save this computer
    Sleep  1s

Verify edited computer
    Run keyword if  '${device}'=='Laptop'  SeleniumLibrary.Element should contain   //*[@id="main"]/div[1]   Computer ${computerName2Edited} has been updated
    ...  ELSE   AppiumLibrary.Page Should Contain Text   Computer ${computerName2Edited} has been updated
    Sleep  1s

Type computername x into searchfield
    Run keyword if  '${device}'=='Laptop'  SeleniumLibrary.Input text   id=searchbox   ${computerNamex}
    ...  ELSE   AppiumLibrary.Input text   //*[@resource-id="searchbox"]  ${computerNamex}
    Sleep  1s

Verify error message
    Run keyword if  '${device}'=='Laptop'  Run keywords  Element should contain   //*[@id="main"]/h1   No computers found  AND  Element should contain   //*[@id="main"]/div[2]   Nothing to display
    ...  ELSE   AppiumLibrary.Page Should Contain Text  No computers found

Verify required fields
    Click create computer
    Page should contain element   //*[@class="clearfix error"]//*[contains(text(),"Required")]


Verify invalid date introduced date
    SeleniumLibrary.Input text   id=introduced   000000
    Click create computer
    Page should contain element   //*[@class="clearfix error"]//*[@id="introduced"]

Verify invalid date discontinue date
    SeleniumLibrary.Input text   id=discontinued   xxxxxxx
    Click create computer
    Page should contain element   //*[@class="clearfix error"]//*[@id="discontinued"]

Verify valid indtroduced and invalid discontinue date
    Clear Element Text   id=introduced
    SeleniumLibrary.Input text   id=introduced   2019-12-12
    Click create computer
    Page should not contain element   //*[@class="clearfix error"]//*[@id="introduced"]
    Page should contain element   //*[@class="clearfix error"]//*[@id="discontinued"]

Fill in computername special charaters
     SeleniumLibrary.Input text   id=name  ${computerSpecialCharacter}

Search computername special charaters
     SeleniumLibrary.Input text   id=searchbox  ${computerSpecialCharacter}

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

Check start screen
    ${status}  Run keyword and return status  AppiumLibrary.Page should contain element  id=com.android.chrome:id/title
    Run keyword if  ${status}  AppiumLibrary.Click Element  id=com.android.chrome:id/terms_accept
    Sleep  1s
    ${status}  Run keyword and return status  AppiumLibrary.Page should contain element  id=com.android.chrome:id/chooser_title
    Run keyword if  ${status}  AppiumLibrary.Click Element  id=com.android.chrome:id/negative_button

Set up mobile device
    Set suite variable  ${Library}  AppiumLibrary
    Set suite variable  ${device}  Phone
    Open Application  http://localhost:4723/wd/hub  platformName=Android  platformVersion=9  deviceName=GalaxyS8  automationName=appium  appPackage=com.android.chrome  appActivity=org.chromium.chrome.browser.ChromeTabbedActivity
    Sleep  2s
    Check start screen
    Sleep  2s