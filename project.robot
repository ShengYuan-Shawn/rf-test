*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${AppURL}    https://app.deriv.com
${loginButton}    //button[@id='dt_login_button']
${inputEmail}    //input[@type='email']
${inputPassword}    //input[@type='password']
${submitButton}    //button[@type='submit']
${accountInfo}    //div[@id='dt_core_account-info_acc-info']
${accountLoader}    //*[@aria-label='Loading interface...']
${chartLoader}    //*[@class="chart-container__loader"]
${contractLoader}    //*[@class='sidebar__items']
${realAccountIcon}    //*[@class='dc-icon acc-info__id-icon acc-info__id-icon--usd']   
${demoAccount}    //li[@id='dt_core_account-switcher_demo-tab']
${demoAccountIcon}    //*[@class='dc-icon acc-switcher__id-icon']
${switchAccout}    //span[@class='acc-switcher__id']
${contractsButton}    //div[@class='cq-symbol-select-btn']
${volatility_10_1s_Index}    //div[@class='sc-mcd__item sc-mcd__item--1HZ10V ']
${dropdownContent}    //div[@class='sc-mcd__content']
${checkContractType}    //span[@name='contract_type']
${ticksCount}    //span[@id='dt_range_slider_label']
${stakeInput10}    //input[@class='dc-input-wrapper__input input--has-inline-prefix input trade-container__input']
${riseButton}    //button[@id='dt_purchase_call_button']
${positionResult}    //a[@class='dc-result__caption-wrapper']
${positionToggleButton}    //a[@id='dt_positions_toggle']
${demoAccountBalance}    //p[@class='acc-info__balance']
${forexContractButton}    //span[@class='ic-icon ic-forex']
${audusdPair}    //span[@class='ic-frx ic-frxAUDUSD']
${tradeTypes}    //div[@id='dt_contract_dropdown']
${tradeTypesTab}    //div[@class='dc-vertical-tab__tab']
${purchaseContainer}    //div[@class='purchase-container']
${highLow}    //div[@id='dt_contract_high_low_item']
${inputDuration}    //input[@class='dc-input__field']
${payoutButton}    //button[@id='dc_payout_toggle_item']
${inputPayout}    dt_amount_input
${lowerButton}    dt_purchase_put_button
${barrierError}    //span[@data-tooltip='Contracts more than 24 hours in duration would need an absolute barrier.']
${contractCard}    //div[@class='positions-drawer__bg positions-drawer__bg--open']
${minimizeContractIcon}    dt_positions_drawer_close_icon
${inputBarrier}    dt_barrier_1_input
${volatility_50_Index}    //div[@class='sc-mcd__item sc-mcd__item--R_50 ']
${multipliers}    dt_contract_multiplier_item
${stakeAmount}    dt_amount_input
${minStakeAmount}    //span[@data-tooltip='Please enter a stake amount that's at least 1.00.']
${maxStakeAmount}    //div[@class='dc-popover__bubble dc-popover__bubble--error']
${multipliersVal}    //div[@class='dc-dropdown__container']
${listVal}    //div[@class='dc-list__item']
${tpCheckbox}    dc_take_profit-checkbox_input
${slCheckbox}    dc_stop_loss-checkbox_input
${dcCheckbox}    dt_cancellation-checkbox_input

*** Keywords ***
Clear Input Field
    [Arguments]    @{inputField}
    Press Keys    ${inputField}    CTRL+a+BACKSPACE

*** Test Cases ***
Login To Deriv App
    Open Browser    ${AppURL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible  ${loginButton}    90
    Click Element    ${loginButton}
    Wait Until Page Contains Element    ${inputEmail}    30
    Input Text    ${inputEmail}    email
    Input Text    ${inputPassword}    password
    Click Element    ${submitButton}

# Task 1
Switch To Virtual Account
    Wait Until Page Does Not Contain Element    ${accountLoader}    40
    Wait Until Page Does Not Contain Element    ${chartLoader}    40
    Wait Until Page Contains Element    ${contractLoader}    60
    Wait Until Page Contains Element    ${accountInfo}    60
    Wait Until Element Is Visible    ${accountInfo}   60
    Click Element    ${accountInfo}
    Wait Until Element Is Visible    ${realAccountIcon}    40
    Page Should Contain Element    ${realAccountIcon}    40
    Click Element    ${demoAccount}
    Wait Until Element Is Visible    ${demoAccountIcon}    40
    Page Should Contain Element   ${demoAccountIcon}    40
    Click Element    ${switchAccout}

# Task 2
Buy Rise Contract
    Wait Until Page Does Not Contain Element    ${accountLoader}    40
    Wait Until Page Contains Element    ${contractLoader}    60
    Click Element    ${contractsButton}
    Wait Until Page Contains Element    ${dropdownContent}    40
    Wait Until Element Is Visible    ${dropdownContent}    40
    Click Element    ${volatility_10_1s_Index}
    Wait Until Page Does Not Contain Element    ${chartLoader}    40
    Wait Until Page Contains Element    ${contractLoader}    80
    Element Text Should Be    ${checkContractType}    Rise/Fall
    Element Text Should Be    ${ticksCount}    5 Ticks
    Element Attribute Value Should Be    ${stakeInput10}    value    10
    # ${before}=    Get Text   ${demoAccountBalance}
    # Click Element    ${riseButton}
    # Wait Until Page Contains Element    ${positionResult}    30
    # ${after}=    Get Text    ${demoAccountBalance}
    # Should Not Be Equal    ${before}   ${after}
    # Click Element    ${positionToggleButton}

# Task 3
# Buy Lower Contract
#     Click Element    ${contractsButton}
#     Wait Until Page Contains Element    ${dropdownContent}    40
#     Wait Until Element Is Visible    ${dropdownContent}    60
#     Click Element    ${forexContractButton}
#     Wait Until Page Contains Element    ${dropdownContent}    40
#     Wait Until Element Is Visible    ${dropdownContent}    60
#     Click Element    ${audusdPair}
#     Wait Until Page Does Not Contain Element    ${chartLoader}    200
#     Wait Until Page Contains Element    ${contractLoader}    60
#     Wait Until Element Is Visible    ${tradeTypes}    60
#     Click Element    ${tradeTypes}
#     Wait Until Element Is Visible    ${tradeTypesTab}    40
#     Click Element    ${highLow}
#     Clear Input Field    ${inputDuration}  
#     Input Text    ${inputDuration}    4
#     Element Attribute Value Should Be    ${inputDuration}    value    4
#     Click Element    ${payoutButton}
#     Click Element    ${inputPayout}
#     Clear Input Field    ${inputPayout} 
#     Input Text    ${inputPayout}    15.50
#     Wait Until Element Is Visible    ${purchaseContainer}     120
#     Wait Until Element Is Enabled    ${lowerButton}    40
#     Click Element    ${lowerButton}
#     Sleep    10
    
# Task 4
# Check Relative Barrier Error
#     Wait Until Page Contains Element    ${contractCard}    180
#     Wait Until Element Is Visible    ${contractCard}    180
#     Click Element    ${minimizeContractIcon}
#     Wait Until Element Is Not Visible    ${minimizeContractIcon} 60
#     Clear Input Field    ${inputDuration}  
#     Input Text    ${inputDuration}    4
#     Element Attribute Value Should Be    ${inputDuration}    value    4
#     Clear Input Field    ${inputBarrier}
#     Input Text    ${inputBarrier}    -0.1
#     Click Element    ${payoutButton}
#     Click Element    ${inputPayout}
#     Clear Input Field    ${inputPayout} 
#     Input Text    ${inputPayout}    10
#     Wait Until Element Is Visible    ${purchaseContainer}     120
#     Element Should Be Disabled    ${lowerButton}
#     Wait Until Element Is Visible    ${barrierError}    180
#     Sleep    10

# Task 5
Check Multiplier Contract Parameter
    Click Element    ${contractsButton}
    Wait Until Page Contains Element    ${dropdownContent}    40
    Wait Until Element Is Visible    ${dropdownContent}    60
    Click Element    ${volatility_50_Index}
    Wait Until Page Does Not Contain Element    ${chartLoader}    200
    Wait Until Page Contains Element    ${contractLoader}    60
    Wait Until Element Is Visible    ${tradeTypes}    60
    Click Element    ${tradeTypes}
    Wait Until Element Is Visible    ${tradeTypesTab}    30    
    Click Element    ${multipliers}  
    Page Should Contain    Stake
    Page Should Not Contain    Payout
    Clear Input Field    ${stakeAmount}
    Input Text    ${stakeAmount}    0
    Wait Until Element Is Visible   ${minStakeAmount}    40 
    Clear Input Field    ${stakeAmount}
    Input Text    ${stakeAmount}    2001
    Wait Until Element Is Visible    ${maxStakeAmount}    40
    Click Element    ${multipliersVal}
    FOR  ${value}  IN    20    40    60    100    200
    Page Should Contain Element  ${listVal}  
    END
    # Click Element    ${dcCheckbox}
    # Click Element    ${tpCheckbox}
    # Checkbox Should Be Selected    ${tpCheckbox}
    # Checkbox Should Not Be Selected    ${dcCheckbox}
    # Click Element    ${tpCheckbox}
    # Click Element    ${slCheckbox}


    


    
    


