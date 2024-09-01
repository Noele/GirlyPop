local fontPath = "Interface\\AddOns\\GirlyPop\\res\\Fonts\\PixelMplus10.ttf" -- FONT USED FOR TEXT ENTERED

local currentOperation = ""
local firstInput = 0
--[[
    FRAME
--]]
local GirlyPopCalculatorFrame = CreateFrame("Frame", "GirlyPopCalculatorFrame", UIParent)
GirlyPopCalculatorFrame:SetSize(571, 599)
GirlyPopCalculatorFrame:SetPoint("CENTER", UIParent, "CENTER")
GirlyPopCalculatorFrame:EnableMouse(true)
GirlyPopCalculatorFrame:SetMovable(true)
GirlyPopCalculatorFrame:RegisterForDrag("LeftButton")
GirlyPopCalculatorFrame:SetScript("OnDragStart", GirlyPopCalculatorFrame.StartMoving)
GirlyPopCalculatorFrame:SetScript("OnDragStop", GirlyPopCalculatorFrame.StopMovingOrSizing)

--[[
    FRAME TEXTURE
--]]
local uiTexture = GirlyPopCalculatorFrame:CreateTexture(nil, "ARTWORK")
uiTexture:SetTexture("Interface\\AddOns\\GirlyPop\\res\\Textures\\calculator.tga")
uiTexture:SetAllPoints(GirlyPopCalculatorFrame)
uiTexture:SetTexCoord(0, 1, 0, 1)

--[[
    EDIT BOX
--]]
local GirlyPopCalculatorEditBox = CreateFrame("EditBox", "GirlyPopCalculatorEditBox", GirlyPopCalculatorFrame, "InputBoxTemplate")
GirlyPopCalculatorEditBox:SetSize(120, 30)
GirlyPopCalculatorEditBox:SetPoint("BOTTOMLEFT", GirlyPopCalculatorFrame, "BOTTOMLEFT", 30, 130)
GirlyPopCalculatorEditBox:SetAutoFocus(false)
GirlyPopCalculatorEditBox:SetMaxLetters(256)
GirlyPopCalculatorEditBox:SetMultiLine(true)
GirlyPopCalculatorEditBox:SetFont(fontPath, 15, "OUTLINE")
GirlyPopCalculatorEditBox:SetScript("OnMouseDown", function(self)
    self:ClearFocus()
end)

GirlyPopCalculatorEditBox:SetScript("OnKeyDown", function(self, key)
    self:ClearFocus()
end)

--[[
    Input a number to the edit box
--]]
local function InputNumber(number)
    GirlyPopCalculatorEditBox:SetText(GirlyPopCalculatorEditBox:GetText() .. number)
end

--[[
    Clear the edit box
--]]
local function ClearInput()
    GirlyPopCalculatorEditBox:SetText("")
end

--[[
    Clear the edit box
--]]
local function ApplyOperation(operationType)
    if currentOperation == "" then
        currentOperation = operationType
        firstInput = tonumber(GirlyPopCalculatorEditBox:GetText())
        ClearInput()
    end
end

local function Calculate()
    if currentOperation ~= "" then
        if currentOperation == "+" then
            GirlyPopCalculatorEditBox:SetText(firstInput + tonumber(GirlyPopCalculatorEditBox:GetText()))
            currentOperation = ""
        elseif currentOperation == "-" then
            GirlyPopCalculatorEditBox:SetText(firstInput - tonumber(GirlyPopCalculatorEditBox:GetText()))
            currentOperation = ""
        elseif currentOperation == "*" then
            GirlyPopCalculatorEditBox:SetText(firstInput * tonumber(GirlyPopCalculatorEditBox:GetText()))
            currentOperation = ""
        elseif currentOperation == "/" then
            if firstInput == 0 or tonumber(GirlyPopCalculatorEditBox:GetText()) == 0 then
                currentOperation = ""
                firstInput = 0
                GirlyPopCalculatorEditBox:SetText("")
            else
                GirlyPopCalculatorEditBox:SetText(firstInput / tonumber(GirlyPopCalculatorEditBox:GetText()))
                currentOperation = ""
            end
        end
    end

end

--[[
    1 BUTTON
--]]
local GirlyPopCalculatorOneButton = CreateFrame("Button", "GirlyPopCalculatorOneButton", GirlyPopCalculatorFrame, "UIPanelButtonTemplate")
GirlyPopCalculatorOneButton:SetSize(30, 30)
GirlyPopCalculatorOneButton:SetPoint("BOTTOMLEFT", GirlyPopCalculatorFrame, "BOTTOMLEFT", 30, 0)
GirlyPopCalculatorOneButton:SetText("1")
GirlyPopCalculatorOneButton:SetScript("Onclick", function()
    InputNumber(1);
end)

--[[
    2 BUTTON
--]]
local GirlyPopCalculatorTwoButton = CreateFrame("Button", "GirlyPopCalculatorTwoButton", GirlyPopCalculatorFrame, "UIPanelButtonTemplate")
GirlyPopCalculatorTwoButton:SetSize(30, 30)
GirlyPopCalculatorTwoButton:SetPoint("BOTTOMLEFT", GirlyPopCalculatorFrame, "BOTTOMLEFT", 60, 0)
GirlyPopCalculatorTwoButton:SetText("2")
GirlyPopCalculatorTwoButton:SetScript("Onclick", function()
    InputNumber(2);
end)

--[[
    3 BUTTON
--]]
local GirlyPopCalculatorThreeButton = CreateFrame("Button", "GirlyPopCalculatorThreeButton", GirlyPopCalculatorFrame, "UIPanelButtonTemplate")
GirlyPopCalculatorThreeButton:SetSize(30, 30)
GirlyPopCalculatorThreeButton:SetPoint("BOTTOMLEFT", GirlyPopCalculatorFrame, "BOTTOMLEFT", 90, 0)
GirlyPopCalculatorThreeButton:SetText("3")
GirlyPopCalculatorThreeButton:SetScript("Onclick", function()
    InputNumber(3);
end)

--[[
    4 BUTTON
--]]
local GirlyPopCalculatorFourButton = CreateFrame("Button", "GirlyPopCalculatorFourButton", GirlyPopCalculatorFrame, "UIPanelButtonTemplate")
GirlyPopCalculatorFourButton:SetSize(30, 30)
GirlyPopCalculatorFourButton:SetPoint("BOTTOMLEFT", GirlyPopCalculatorFrame, "BOTTOMLEFT", 30, 30)
GirlyPopCalculatorFourButton:SetText("4")
GirlyPopCalculatorFourButton:SetScript("Onclick", function()
    InputNumber(4);
end)

--[[
    5 BUTTON
--]]
local GirlyPopCalculatorFiveButton = CreateFrame("Button", "GirlyPopCalculatorFiveButton", GirlyPopCalculatorFrame, "UIPanelButtonTemplate")
GirlyPopCalculatorFiveButton:SetSize(30, 30)
GirlyPopCalculatorFiveButton:SetPoint("BOTTOMLEFT", GirlyPopCalculatorFrame, "BOTTOMLEFT", 60, 30)
GirlyPopCalculatorFiveButton:SetText("5")
GirlyPopCalculatorFiveButton:SetScript("Onclick", function()
    InputNumber(5);
end)

--[[
    6 BUTTON
--]]
local GirlyPopCalculatorSixButton = CreateFrame("Button", "GirlyPopCalculatorSixButton", GirlyPopCalculatorFrame, "UIPanelButtonTemplate")
GirlyPopCalculatorSixButton:SetSize(30, 30)
GirlyPopCalculatorSixButton:SetPoint("BOTTOMLEFT", GirlyPopCalculatorFrame, "BOTTOMLEFT", 90, 30)
GirlyPopCalculatorSixButton:SetText("6")
GirlyPopCalculatorSixButton:SetScript("Onclick", function()
    InputNumber(6);
end)

--[[
    7 BUTTON
--]]
local GirlyPopCalculatorSevenButton = CreateFrame("Button", "GirlyPopCalculatorSevenButton", GirlyPopCalculatorFrame, "UIPanelButtonTemplate")
GirlyPopCalculatorSevenButton:SetSize(30, 30)
GirlyPopCalculatorSevenButton:SetPoint("BOTTOMLEFT", GirlyPopCalculatorFrame, "BOTTOMLEFT", 30, 60)
GirlyPopCalculatorSevenButton:SetText("7")
GirlyPopCalculatorSevenButton:SetScript("Onclick", function()
    InputNumber(7);
end)

--[[
    8 BUTTON
--]]
local GirlyPopCalculatorEightButton = CreateFrame("Button", "GirlyPopCalculatorEightButton", GirlyPopCalculatorFrame, "UIPanelButtonTemplate")
GirlyPopCalculatorEightButton:SetSize(30, 30)
GirlyPopCalculatorEightButton:SetPoint("BOTTOMLEFT", GirlyPopCalculatorFrame, "BOTTOMLEFT", 60, 60)
GirlyPopCalculatorEightButton:SetText("8")
GirlyPopCalculatorEightButton:SetScript("Onclick", function()
    InputNumber(8);
end)

--[[
    9 BUTTON
--]]
local GirlyPopCalculatorNineButton = CreateFrame("Button", "GirlyPopCalculatorNineButton", GirlyPopCalculatorFrame, "UIPanelButtonTemplate")
GirlyPopCalculatorNineButton:SetSize(30, 30)
GirlyPopCalculatorNineButton:SetPoint("BOTTOMLEFT", GirlyPopCalculatorFrame, "BOTTOMLEFT", 90, 60)
GirlyPopCalculatorNineButton:SetText("9")
GirlyPopCalculatorNineButton:SetScript("Onclick", function()
    InputNumber(9);
end)

--[[
    0 BUTTON
--]]
local GirlyPopCalculatorZeroButton = CreateFrame("Button", "GirlyPopCalculatorZeroButton", GirlyPopCalculatorFrame, "UIPanelButtonTemplate")
GirlyPopCalculatorZeroButton:SetSize(30, 30)
GirlyPopCalculatorZeroButton:SetPoint("BOTTOMLEFT", GirlyPopCalculatorFrame, "BOTTOMLEFT", 30, -30)
GirlyPopCalculatorZeroButton:SetText("0")
GirlyPopCalculatorZeroButton:SetScript("Onclick", function()
    InputNumber(0);
end)

--[[
    . BUTTON
--]]
local GirlyPopCalculatorDecimalButton = CreateFrame("Button", "GirlyPopCalculatorDecimalButton", GirlyPopCalculatorFrame, "UIPanelButtonTemplate")
GirlyPopCalculatorDecimalButton:SetSize(30, 30)
GirlyPopCalculatorDecimalButton:SetPoint("BOTTOMLEFT", GirlyPopCalculatorFrame, "BOTTOMLEFT", 60, -30)
GirlyPopCalculatorDecimalButton:SetText(".")
GirlyPopCalculatorDecimalButton:SetScript("Onclick", function()
    InputNumber(".");
end)

--[[
    = BUTTON
--]]
local GirlyPopCalculatorEqualsButton = CreateFrame("Button", "GirlyPopCalculatorEqualsButton", GirlyPopCalculatorFrame, "UIPanelButtonTemplate")
GirlyPopCalculatorEqualsButton:SetSize(60, 30)
GirlyPopCalculatorEqualsButton:SetPoint("BOTTOMLEFT", GirlyPopCalculatorFrame, "BOTTOMLEFT", 90, -30)
GirlyPopCalculatorEqualsButton:SetText("=")
GirlyPopCalculatorEqualsButton:SetScript("OnClick", function()
    Calculate()
end)

--[[
    + BUTTON
--]]
local GirlyPopCalculatorPlusButton = CreateFrame("Button", "GirlyPopCalculatorPlusButton", GirlyPopCalculatorFrame, "UIPanelButtonTemplate")
GirlyPopCalculatorPlusButton:SetSize(30, 30)
GirlyPopCalculatorPlusButton:SetPoint("BOTTOMLEFT", GirlyPopCalculatorFrame, "BOTTOMLEFT", 120, 0)
GirlyPopCalculatorPlusButton:SetText("+")
GirlyPopCalculatorPlusButton:SetScript("OnClick", function ()
    ApplyOperation("+")
end)

--[[
    - BUTTON
--]]
local GirlyPopCalculatorMinusButton = CreateFrame("Button", "GirlyPopCalculatorMinusButton", GirlyPopCalculatorFrame, "UIPanelButtonTemplate")
GirlyPopCalculatorMinusButton:SetSize(30, 30)
GirlyPopCalculatorMinusButton:SetPoint("BOTTOMLEFT", GirlyPopCalculatorFrame, "BOTTOMLEFT", 120, 30)
GirlyPopCalculatorMinusButton:SetText("-")
GirlyPopCalculatorMinusButton:SetScript("OnClick", function ()
    ApplyOperation("-")
end)

--[[
    * BUTTON
--]]
local GirlyPopCalculatorMultiplyButton = CreateFrame("Button", "GirlyPopCalculatorMultiplyButton", GirlyPopCalculatorFrame, "UIPanelButtonTemplate")
GirlyPopCalculatorMultiplyButton:SetSize(30, 30)
GirlyPopCalculatorMultiplyButton:SetPoint("BOTTOMLEFT", GirlyPopCalculatorFrame, "BOTTOMLEFT", 120, 60)
GirlyPopCalculatorMultiplyButton:SetText("x")
GirlyPopCalculatorMultiplyButton:SetScript("OnClick", function ()
    ApplyOperation("*")
end)

--[[
    ÷ BUTTON
--]]
local GirlyPopCalculatorDivideButton = CreateFrame("Button", "GirlyPopCalculatorDivideButton", GirlyPopCalculatorFrame, "UIPanelButtonTemplate")
GirlyPopCalculatorDivideButton:SetSize(30, 30)
GirlyPopCalculatorDivideButton:SetPoint("BOTTOMLEFT", GirlyPopCalculatorFrame, "BOTTOMLEFT", 120, 90)
GirlyPopCalculatorDivideButton:SetText("÷")
GirlyPopCalculatorDivideButton:SetScript("OnClick", function ()
    ApplyOperation("/")
end)

--[[
    CLEAR BUTTON
--]]
local GirlyPopCalculatorClearButton = CreateFrame("Button", "GirlyPopCalculatorDivideButton", GirlyPopCalculatorFrame, "UIPanelButtonTemplate")
GirlyPopCalculatorClearButton:SetSize(90, 30)
GirlyPopCalculatorClearButton:SetPoint("BOTTOMLEFT", GirlyPopCalculatorFrame, "BOTTOMLEFT", 30, 90)
GirlyPopCalculatorClearButton:SetText("CLS")
GirlyPopCalculatorClearButton:SetScript("Onclick", function()
    ClearInput()
end)

--[[
    SLASH COMMAND, FIRED WHEN "/GirlyCalculator" is used
--]]
function GirlyPopCalculator_SlashCommand()
    GirlyPopCalculatorFrame:Show()
end

SLASH_GirlyPopCalculator1 = "/GirlyCalculator";
SlashCmdList["GirlyPopCalculator"] = GirlyPopCalculator_SlashCommand; -- SLASH COMMAND Script Assignment

GirlyPopCalculatorFrame:Hide() -- Hide the frame by default.
