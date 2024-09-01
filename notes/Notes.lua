GirlyPopDB = GirlyPopDB or {} -- DB INITIALISATION
local index = 1 -- CURRENT PAGE INDEX
GirlyPopDB.pages = GirlyPopDB.pages or {} -- DB PAGE INITIALISATION

local fontPath = "Interface\\AddOns\\GirlyPop\\res\\Fonts\\PixelMplus10.ttf" -- FONT USED FOR TEXT ENTERED

--[[
    FRAME
--]]
local GirlyPopNotesFrame = CreateFrame("Frame", "GirlyPopMainFrame", UIParent)
GirlyPopNotesFrame:SetSize(571, 599)
GirlyPopNotesFrame:SetPoint("CENTER", UIParent, "CENTER")
GirlyPopNotesFrame:EnableMouse(true)
GirlyPopNotesFrame:SetMovable(true)
GirlyPopNotesFrame:RegisterForDrag("LeftButton")
GirlyPopNotesFrame:SetScript("OnDragStart", GirlyPopNotesFrame.StartMoving)
GirlyPopNotesFrame:SetScript("OnDragStop", GirlyPopNotesFrame.StopMovingOrSizing)

--[[
    EDIT BOX
--]]
local GirlyPopNotesEditBox = CreateFrame("EditBox", "GirlyPopEditBox", GirlyPopNotesFrame)
GirlyPopNotesEditBox:SetSize(362, 536)
GirlyPopNotesEditBox:SetPoint("BOTTOM", GirlyPopNotesFrame, -40, 50)
GirlyPopNotesEditBox:SetAutoFocus(false)
GirlyPopNotesEditBox:SetMaxLetters(256)
GirlyPopNotesEditBox:SetMultiLine(true)
GirlyPopNotesEditBox:SetFont(fontPath, 30, "OUTLINE")

--[[
    PAGE NUMBERS (1/5) ECT
--]]
local PageNumberText = GirlyPopNotesFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
PageNumberText:SetPoint("TOPRIGHT", GirlyPopNotesFrame, "TOPRIGHT",  -150, -95)  -- Position the text in the center of the frame
PageNumberText:SetFont(fontPath, 15, "OUTLINE")
PageNumberText:SetTextColor(1, 1, 1, 1)
PageNumberText:SetText("( 1 / 1 )")

--[[
    FRAME TEXTURE
--]]
local uiTexture = GirlyPopNotesFrame:CreateTexture(nil, "ARTWORK")
uiTexture:SetTexture("Interface\\AddOns\\GirlyPop\\res\\Textures\\ui.tga")
uiTexture:SetAllPoints(GirlyPopNotesFrame)
uiTexture:SetTexCoord(0, 1, 0, 1)

--[[
    LEFT PAGE BUTTON
--]]
local pageLeftButton = CreateFrame("Button", "GirlyPopPageLeft", GirlyPopNotesFrame)
pageLeftButton:SetSize(100, 50)
pageLeftButton:SetPoint("BOTTOMRIGHT", GirlyPopNotesFrame, "BOTTOMRIGHT", -5, 30)
pageLeftButton:SetText("<--")

--[[
    RIGHT PAGE BUTTON
--]]
local pageRightButton = CreateFrame("Button", "GirlyPopPageRightButton", GirlyPopNotesFrame)
pageRightButton:SetSize(100, 50)
pageRightButton:SetPoint("BOTTOMRIGHT", GirlyPopNotesFrame, "BOTTOMRIGHT", -5, 85)
pageRightButton:SetText("-->")

--[[
    EXIT BUTTON
--]]
local EscapeButton = CreateFrame("Button", "GirlyPopPageRightButton", GirlyPopNotesFrame)
EscapeButton:SetSize(30, 30)
EscapeButton:SetPoint("TOPRIGHT", GirlyPopNotesFrame, "TOPRIGHT", -145, -40)

--[[
    EXIT BUTTON ON CLICK EVENT
--]]
function EscapeButton_OnClick()
    GirlyPopNotesFrame:Hide()
end

--[[
    RIGHT BUTTON ON CLICK EVENT
--]]
function RightButton_OnClick()
    index = index + 1
    if GirlyPopDB.pages[index] == nil then
        GirlyPopDB.pages[index] = ""
    end
    GirlyPopNotesEditBox:SetText(GirlyPopDB.pages[index] or "")
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
    GirlyPopNotesEditBox:SetText(GirlyPopDB.pages[index] or "")
    PageNumberText:SetText("( " .. index .. " / " .. #GirlyPopDB.pages .. " )")
end

--[[
    SLASH COMMAND, FIRED WHEN "/GirlyNotes" is used
--]]
function GirlyPopFrame_SlashCommand()
    GirlyPopNotesFrame:Show()
    GirlyPopNotesEditBox:SetText(GirlyPopDB.pages[index] or "")
end

--[[
    ON TEXT EDITED EVENT
--]]
local function OnEditBoxTextChanged(self)
    GirlyPopDB.pages[index] = self:GetText()
end

GirlyPopNotesEditBox:SetScript("OnTextChanged", OnEditBoxTextChanged) -- ON TEXT CHANGED Script Assignment
pageLeftButton:SetScript("OnClick", LeftButton_OnClick) -- PAGE LEFT BUTTON Script Assignment
pageRightButton:SetScript("OnClick", RightButton_OnClick) -- PAGE RIGHT BUTTON Script Assignment
EscapeButton:SetScript("OnClick", EscapeButton_OnClick) -- EXIT BUTTON Script Assignment

SLASH_GirlyPopFrame1 = "/GirlyNotes";
SlashCmdList["GirlyPopFrame"] = GirlyPopFrame_SlashCommand; -- SLASH COMMAND Script Assignment

GirlyPopNotesFrame:Hide() -- Hide the frame by default.
