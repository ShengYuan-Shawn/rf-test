*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Declaring App URL
${AppURL}    https://app.deriv.com

# Declaring Login Variables
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

# Declaring Buy Rise Contract Variables
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

# Declaring Buy Lower Contract Variables
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

# Declaring Check Relative Barriers Errors Variables
${barrierError}    //span[@data-tooltip='Contracts more than 24 hours in duration would need an absolute barrier.']
${contractCard}    //div[@class='positions-drawer__bg positions-drawer__bg--open']
${minimizeContractIcon}    dt_positions_drawer_close_icon
${inputBarrier}    dt_barrier_1_input

# Declaring Check Multiplier Contract Parameter Variables
@{multipliersValArray}    20    40    60    100    200
@{cancellationValArray}    5    10    15    30    60

${volatility_50_Index}    //div[@class='sc-mcd__item sc-mcd__item--R_50 ']
${multipliers}    dt_contract_multiplier_item
${takeProfitCheckbox}    //input[@id='dc_take_profit-checkbox_input']/../span
${stopLossCheckbox}   //input[@id='dc_stop_loss-checkbox_input']/../span    
${dealCancellationCheckbox}    //input[@id='dt_cancellation-checkbox_input']/../span
${takeProfitSelection}     //input[@id='dc_take_profit-checkbox_input']
${stopLossSelection}    //input[@id='dc_stop_loss-checkbox_input']
${dealCancellationSelection}    //input[@id='dt_cancellation-checkbox_input']
${multipliersVal}    //div[@id='dropdown-display']//parent::div

${stakeAmount}    dt_amount_input
${notificationPrompt}    //div[@class='notification-promo--container']
${closeNotification}    //*[@class='dc-icon notification-promo__close-icon']
${closeAnnouncementNoti}    //button[@class='notification__close-button']
${minStakeAmountNoti}    //span[@class='trade-container__tooltip dc-tooltip dc-tooltip--error']
${maxStakeAmountNoti}    //div[@class='dc-popover__bubble dc-popover__bubble--error']
${addAmountButton}    dt_amount_input_add
${subAmountButton}    dt_amount_input_sub

${dealCancellationVal}    //input[@id='dt_cancellation-checkbox_input']/../../..//div[contains(@class,'trade-container__multiplier-dropdown')]

${purchaseContainer}    //div[@class='purchase-container']
${cancellationFeeContainer}    //div[@class='trade-container__price-info-value']
${cancellationFee}    //span[@class='trade-container__price-info-currency']


*** Keywords ***
Clear Input Field
    [Arguments]    @{inputField}
    Press Keys    ${inputField}    CTRL+a+BACKSPACE

*** Test Cases ***
Login To Deriv App
    Open Browser    ${AppURL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible  ${loginButton}    60
    Click Element    ${loginButton}
    Wait Until Page Contains Element    ${inputEmail}    30
    Input Text    ${inputEmail}    email
    Input Text    ${inputPassword}    password
    Click Element    ${submitButton}

# Task 1
Switch To Virtual Account
    Wait Until Page Does Not Contain Element    ${accountLoader}    60
    Wait Until Page Does Not Contain Element    ${chartLoader}    60
    Wait Until Page Contains Element    ${contractLoader}    60
    Wait Until Page Contains Element    ${accountInfo}    60
    Wait Until Element Is Visible    ${accountInfo}   60
    Click Element    ${accountInfo}
    Wait Until Element Is Visible    ${realAccountIcon}    60
    Page Should Contain Element    ${realAccountIcon}    60
    Click Element    ${demoAccount}
    Wait Until Element Is Visible    ${demoAccountIcon}    60
    Page Should Contain Element   ${demoAccountIcon}    60
    Click Element    ${switchAccout}

# Task 2
Buy Rise Contract
    Wait Until Page Does Not Contain Element    ${accountLoader}    60
    Wait Until Page Contains Element    ${contractLoader}    60
    Click Element    ${contractsButton}
    Wait Until Page Contains Element    ${dropdownContent}    60
    Wait Until Element Is Visible    ${dropdownContent}    60
    Click Element    ${volatility_10_1s_Index}
    Wait Until Page Does Not Contain Element    ${chartLoader}    60
    Wait Until Page Contains Element    ${contractLoader}    60
    Element Text Should Be    ${checkContractType}    Rise/Fall
    Element Text Should Be    ${ticksCount}    5 Ticks
    Element Attribute Value Should Be    ${stakeInput10}    value    10
    ${before}=    Get Text   ${demoAccountBalance}
    Click Element    ${riseButton}
    Wait Until Page Contains Element    ${positionResult}    30
    ${after}=    Get Text    ${demoAccountBalance}
    Should Not Be Equal    ${before}   ${after}
    Click Element    ${positionToggleButton}

# Task 3
Buy Lower Contract
    Click Element    ${contractsButton}
    Wait Until Page Contains Element    ${dropdownContent}    30
    Wait Until Element Is Visible    ${dropdownContent}    60
    Click Element    ${forexContractButton}
    Wait Until Page Contains Element    ${dropdownContent}    30
    Wait Until Element Is Visible    ${dropdownContent}    60
    Click Element    ${audusdPair}
    Wait Until Page Does Not Contain Element    ${chartLoader}    60
    Wait Until Page Contains Element    ${contractLoader}    60
    Wait Until Element Is Visible    ${tradeTypes}    60
    Click Element    ${tradeTypes}
    Wait Until Element Is Visible    ${tradeTypesTab}    30
    Click Element    ${highLow}
    Clear Input Field    ${inputDuration}  
    Input Text    ${inputDuration}    4
    Element Attribute Value Should Be    ${inputDuration}    value    4
    Click Element    ${payoutButton}
    Click Element    ${inputPayout}
    Clear Input Field    ${inputPayout} 
    Input Text    ${inputPayout}    15.50
    Wait Until Element Is Visible    ${purchaseContainer}     60
    Wait Until Element Is Enabled    ${lowerButton}    40
    Click Element    ${lowerButton}
    Sleep    10
    
# Task 4
Check Relative Barrier Error
    Wait Until Page Contains Element    ${contractCard}    60
    Wait Until Element Is Visible    ${contractCard}    60
    Click Element    ${minimizeContractIcon}
    Wait Until Element Is Not Visible    ${minimizeContractIcon} 60
    Clear Input Field    ${inputDuration}  
    Input Text    ${inputDuration}    4
    Element Attribute Value Should Be    ${inputDuration}    value    4
    Clear Input Field    ${inputBarrier}
    Input Text    ${inputBarrier}    -0.1
    Click Element    ${payoutButton}
    Click Element    ${inputPayout}
    Clear Input Field    ${inputPayout} 
    Input Text    ${inputPayout}    10
    Wait Until Element Is Visible    ${purchaseContainer}     60
    Element Should Be Disabled    ${lowerButton}
    Wait Until Element Is Visible    ${barrierError}    60
    Sleep    10

# Task 5
Check Multiplier Contract Parameter
    Wait Until Page Contains Element    ${contractsButton}    60
    Wait Until Element Is Visible    ${contractsButton}    60
    Click Element    ${contractsButton}
    Wait Until Page Contains Element    ${dropdownContent}    60
    Wait Until Element Is Visible    ${dropdownContent}    60
    Click Element    ${volatility_50_Index}
    Wait Until Page Does Not Contain Element    ${chartLoader}    60
    Wait Until Page Contains Element    ${contractLoader}    60
    Wait Until Element Is Visible    ${tradeTypes}    60
    Click Element    ${tradeTypes}
    Wait Until Element Is Visible    ${tradeTypesTab}    30    
    Click Element    ${multipliers}  
    Page Should Contain    Stake
    Page Should Not Contain    Payout
    
Verify Only Deal Cancellation Or TP/SL Is Allowed
    Wait Until Page Contains Element    ${contractLoader}    60
    Wait Until Element Is Visible    ${contractLoader}    60
    Click Element    ${dealCancellationCheckbox}
    Click Element    ${takeProfitCheckbox}
    Click Element    ${stopLossCheckbox}
    Checkbox Should Be Selected    ${takeProfitSelection}
    Checkbox Should Be Selected    ${stopLossSelection}
    Checkbox Should Not Be Selected    ${dealCancellationSelection}

    Click Element    ${takeProfitCheckbox}
    Click Element    ${stopLossCheckbox}
    Click Element    ${dealCancellationCheckbox}
    Checkbox Should Not Be Selected    ${takeProfitSelection}
    Checkbox Should Not Be Selected    ${stopLossSelection}
    Checkbox Should Be Selected    ${dealCancellationSelection}

Verify Multiplier Value
    Click Element    ${multipliersVal}
    FOR  ${value}  IN  @{multipliersValArray}
        Page Should Contain Element    //div[@class='dc-list dc-list--left']//div[@id= '${value}']
    END
    Click Element    ${multipliersVal}

Verify Min And Max Stake
    Wait Until Element Is Visible    ${notificationPrompt}    60
    Wait Until Element Is Visible    ${closeNotification}    60
    Wait Until Element Is Enabled    ${closeNotification}    60
    Click Element    ${closeNotification}
    Wait Until Page Does Not Contain Element    ${notificationPrompt}    60
    Click Element    ${stakeAmount}
    Clear Input Field    ${stakeAmount}
    Input Text    ${stakeAmount}    0.99
    Wait Until Element Is Visible    ${minStakeAmountNoti}    120
    Element Should Be Visible    ${minStakeAmountNoti}
    
    Click Element    ${stakeAmount}
    Clear Input Field    ${stakeAmount}
    Input Text    ${stakeAmount}    1
    Page Should Not Contain Element    ${minStakeAmountNoti}
    Element Should Not Be Visible    ${minStakeAmountNoti}
    
    Click Element    ${stakeAmount}
    Clear Input Field    ${stakeAmount}
    Input Text    ${stakeAmount}    2000
    Page Should Not Contain Element    ${maxStakeAmountNoti}
    Element Should Not Be Visible    ${maxStakeAmountNoti}

    Click Element    ${stakeAmount}
    Clear Input Field    ${stakeAmount}
    Input Text    ${stakeAmount}    2001
    Wait Until Element Is Visible    ${maxStakeAmountNoti}    120
    Element Should Be Visible    ${maxStakeAmountNoti}
    
    Click Element    ${stakeAmount}
    Clear Input Field    ${stakeAmount}
    Input Text    ${stakeAmount}    10

Click On Plus And Minus Button
    ${beforeSub}=    Get Value    ${stakeAmount}
    Click Element    ${subAmountButton}
    ${afterSub}=    Get Value    ${stakeAmount}
    Should Not Be Equal    ${beforeSub}    ${afterSub}    

    ${beforeAdd}=    Get Value    ${stakeAmount}
    Click Element    ${addAmountButton}
    ${afterAdd}=    Get Value    ${stakeAmount}
    Should Not Be Equal    ${beforeAdd}    ${afterAdd}    

Verify Deal Cancellation Duration Options
    Checkbox Should Be Selected    ${dealCancellationSelection}
    Click Element    ${dealCancellationVal}
    FOR  ${duration}  IN  @{cancellationValArray}
        Page Should Contain Element    //div[@class='dc-list dc-list--left']//descendant::div//descendant::div[@id='${duration}m']
    END
    Click Element    ${dealCancellationVal}

Deal Cancellation Fee Should Correlate With Stake Value
    Wait Until Page Contains Element    ${purchaseContainer}    60
    Wait Until Element Is Visible    ${purchaseContainer}    60
    Wait Until Page Contains Element    ${cancellationFeeContainer}    60
    Wait Until Element Is Visible    ${cancellationFeeContainer}    60
    Wait Until Page Contains Element    ${cancellationFee}    60
    Wait Until Element Is Visible    ${cancellationFee}    60
    
    # Stake Amount Is 10 USD
    ${firsCancellationAmount}=    Get Text    ${cancellationFee}

    Click Element    ${stakeAmount}
    Clear Input Field    ${stakeAmount}
    Input Text    ${stakeAmount}    15
    Wait Until Page Contains Element    ${cancellationFee}    60
    Wait Until Element Is Visible    ${cancellationFee}    60

    # Stake Amount Is 15 USD
    ${secondCancellationAmount}=    Get Text    ${cancellationFee}

    Should Not Be Equal    ${secondCancellationAmount}    ${firsCancellationAmount}

Close Chrome Brower
    Close Browser