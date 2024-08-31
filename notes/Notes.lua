GirlyPopDB = GirlyPopDB or {} -- DB INITIALISATION
local index = 1 -- CURRENT PAGE INDEX
GirlyPopDB.pages = GirlyPopDB.pages or {} -- DB PAGE INITIALISATION

local fontPath = "Interface\\AddOns\\GirlyPop\\res\\Fonts\\PixelMplus10.ttf" -- FONT USED FOR TEXT ENTERED

--[[
    FRAME
--]]
local GirlyPopFrame = CreateFrame("Frame", "GirlyPopMainFrame", UIParent)
GirlyPopFrame:SetSize(402, 536)
GirlyPopFrame:SetPoint("CENTER", UIParent, "CENTER")
GirlyPopFrame:EnableMouse(true)
GirlyPopFrame:SetMovable(true)
GirlyPopFrame:RegisterForDrag("LeftButton")
GirlyPopFrame:SetScript("OnDragStart", GirlyPopFrame.StartMoving)
GirlyPopFrame:SetScript("OnDragStop", GirlyPopFrame.StopMovingOrSizing)

--[[
    EDIT BOX
--]]
local GirlyPopEditBox = CreateFrame("EditBox", "GirlyPopEditBox", GirlyPopFrame)
GirlyPopEditBox:SetSize(362, 536)
GirlyPopEditBox:SetPoint("BOTTOM", GirlyPopFrame, 5, 20)
GirlyPopEditBox:SetAutoFocus(false)
GirlyPopEditBox:SetMaxLetters(256)
GirlyPopEditBox:SetMultiLine(true)
GirlyPopEditBox:SetFont(fontPath, 30, "OUTLINE")

--[[
    PAGE NUMBERS (1/5) ECT
--]]
local PageNumberText = GirlyPopFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
PageNumberText:SetPoint("TOPRIGHT", GirlyPopFrame, "TOPRIGHT",  -20, -55)  -- Position the text in the center of the frame
PageNumberText:SetFont(fontPath, 30, "OUTLINE")
PageNumberText:SetTextColor(1, 1, 1, 1)
PageNumberText:SetText("( 1 / 1 )")

--[[
    FRAME TEXTURE
--]]
local uiTexture = GirlyPopFrame:CreateTexture(nil, "ARTWORK")
uiTexture:SetTexture("Interface\\AddOns\\GirlyPop\\res\\Textures\\ui.tga")
uiTexture:SetAllPoints(GirlyPopFrame)
uiTexture:SetTexCoord(0, 1, 0, 1)

--[[
    LEFT PAGE BUTTON
--]]
local pageLeftButton = CreateFrame("Button", "GirlyPopPageLeft", GirlyPopFrame, "UIPanelButtonTemplate")
pageLeftButton:SetSize(100, 30)
pageLeftButton:SetPoint("BOTTOMRIGHT", GirlyPopFrame, "BOTTOMRIGHT", 100, 30)
pageLeftButton:SetText("<--")

--[[
    RIGHT PAGE BUTTON
--]]
local pageRightButton = CreateFrame("Button", "GirlyPopPageRightButton", GirlyPopFrame, "UIPanelButtonTemplate")
pageRightButton:SetSize(100, 30)
pageRightButton:SetPoint("BOTTOMRIGHT", GirlyPopFrame, "BOTTOMRIGHT", 100, 0)
pageRightButton:SetText("-->")

--[[
    EXIT BUTTON
--]]
local EscapeButton = CreateFrame("Button", "GirlyPopPageRightButton", GirlyPopFrame)
EscapeButton:SetSize(30, 30)
EscapeButton:SetPoint("TOPRIGHT", GirlyPopFrame, "TOPRIGHT", -10, -5)

--[[
    EXIT BUTTON ON CLICK EVENT
--]]
function EscapeButton_OnClick()
    GirlyPopFrame:Hide()
end

--[[
    RIGHT BUTTON ON CLICK EVENT
--]]
function RightButton_OnClick()
    index = index + 1
    if GirlyPopDB.pages[index] == nil then
        GirlyPopDB.pages[index] = ""
    end
    GirlyPopEditBox:SetText(GirlyPopDB.pages[index] or "")
    PageNumberText:SetText("( " .. index .. " / " .. #GirlyPopDB.pages .. " )")
end

--[[
    LEFT BUTTON ON CLICK EVENT
--]]
function LeftButton_OnClick()
    index = index - 1
    if index < 1 then
        index = 1
    end
    GirlyPopEditBox:SetText(GirlyPopDB.pages[index] or "")
    PageNumberText:SetText("( " .. index .. " / " .. #GirlyPopDB.pages .. " )")
end

--[[
    SLASH COMMAND, FIRED WHEN "/GirlyNotes" is used
--]]
function GirlyPopFrame_SlashCommand()
    GirlyPopFrame:Show()
    GirlyPopEditBox:SetText(GirlyPopDB.pages[index] or "")
end

--[[
    ON TEXT EDITED EVENT
--]]
local function OnEditBoxTextChanged(self)
    GirlyPopDB.pages[index] = self:GetText()
end


GirlyPopEditBox:SetScript("OnTextChanged", OnEditBoxTextChanged) -- ON TEXT CHANGED Script Assignment
pageLeftButton:SetScript("OnClick", LeftButton_OnClick) -- PAGE LEFT BUTTON Script Assignment
pageRightButton:SetScript("OnClick", RightButton_OnClick) -- PAGE RIGHT BUTTON Script Assignment
EscapeButton:SetScript("OnClick", EscapeButton_OnClick) -- EXIT BUTTON Script Assignment

SLASH_GirlyPopFrame1 = "/GirlyNotes";
SlashCmdList["GirlyPopFrame"] = GirlyPopFrame_SlashCommand; -- SLASH COMMAND Script Assignment

GirlyPopFrame:Hide() -- Hide the frame by default.
