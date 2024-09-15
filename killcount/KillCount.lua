GirlyPopDB = GirlyPopDB or {} -- DB INITIALISATION
GirlyPopDB.KillCount = GirlyPopDB.KillCount or {} -- DB PAGE INITIALISATION

lastKillTime = 1
frameOpenTime = 5

local fontPath = "Interface\\AddOns\\GirlyPop\\res\\Fonts\\PixelMplus10.ttf" -- FONT USED FOR TEXT ENTERED

local GirlyPopKillCountFrame = CreateFrame("Frame", "GirlyPopKillCountFrame", UIParent)
GirlyPopKillCountFrame:SetSize(1112 / 16, 566 / 16)
GirlyPopKillCountFrame:SetPoint("CENTER", UIParent, "LEFT", GirlyPopKillCountFrame:GetWidth() * 3, 0)
GirlyPopKillCountFrame:Hide()

--[[
    HISTORY TEXTURE
--]]
local GirlyPopKillCountFrameTexture = GirlyPopKillCountFrame:CreateTexture(nil, "ARTWORK")
GirlyPopKillCountFrameTexture:SetTexture("Interface\\AddOns\\GirlyPop\\res\\Textures\\killcount.tga")
GirlyPopKillCountFrameTexture:SetAllPoints(GirlyPopKillCountFrame)
GirlyPopKillCountFrameTexture:SetTexCoord(0, 1, 0, 1)


local GirlyPopKillCountText = GirlyPopKillCountFrame:CreateFontString("KillCountText", "OVERLAY")
GirlyPopKillCountText:SetPoint("CENTER", GirlyPopKillCountFrame, "CENTER", 0, 0)  -- Center the text in the frame
GirlyPopKillCountText:SetFont(fontPath, 15, "OUTLINE")
GirlyPopKillCountText:SetText(0)

local function containsUnitName(dataset, unitName)
    for _, unit in ipairs(dataset) do
        if unit.UnitName == unitName then
            return true  -- Found the unit
        end
    end
    return false  -- Unit not found
end

local function IncreaseFrameSize(frame, fontString, percentage, duration)
    local initialWidth, initialHeight = frame:GetSize()
    local targetWidth = initialWidth * (1 + percentage / 100)
    local targetHeight = initialHeight * (1 + percentage / 100)
    local interval = 0.05  -- Update interval in seconds
    local steps = duration / interval  -- Number of steps
    local widthStep = (targetWidth - initialWidth) / steps  -- Width increase per step
    local heightStep = (targetHeight - initialHeight) / steps  -- Height increase per step

    -- Extract the initial font size from the fontString
    local fontPath, initialFontSize, fontFlags = fontString:GetFont() -- Get the font path, size, and flags
    local targetFontSize = initialFontSize * (1 + percentage / 100) -- Calculate the target font size
    local fontSizeStep = (targetFontSize - initialFontSize) / steps  -- Font size increase per step

    for i = 1, steps do
        C_Timer.After(i * interval, function()
            -- Update the frame size
            frame:SetSize(initialWidth + widthStep * i, initialHeight + heightStep * i)

            -- Update the font size
            fontString:SetFont(fontPath, initialFontSize + fontSizeStep * i, fontFlags) -- Set the updated font size
        end)
    end
end

local function ChangeCurrentTracker(number)
    GirlyPopKillCountText:SetText(number)
end

local function gpOnCombatLogEvent(_, event, ...)
    local timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
    destGUID, destName, destFlags, destRaidFlags, spellID, spellName = CombatLogGetCurrentEventInfo()

    -- Check for damage events from party members
    if (subEvent == "PARTY_KILL") then
        lastKillTime = 0 + time()
        kkIndex = 0
        if GirlyPopDB.KillCount ~= nil then
            kkIndex = #GirlyPopDB.KillCount + 1
            found = false
            for _, unit in ipairs(GirlyPopDB.KillCount) do
                if unit.UnitName == destName then
                    unit.KillCount = unit.KillCount + 1
                    ChangeCurrentTracker(unit.KillCount)
                    found = true
                end
            end
            if found == false then
                GirlyPopDB.KillCount[kkIndex] = {UnitName = destName, KillCount =  1}
                ChangeCurrentTracker(1)
            end
        else
            GirlyPopDB.KillCount = {}
            kkIndex = 1
            GirlyPopDB.KillCount[kkIndex] = {UnitName = destName, KillCount =  1}
            ChangeCurrentTracker(1)
            end
    end
end

local tickframe = CreateFrame("Frame")
tickframe:SetScript("OnUpdate", function(self, elapsed)
    if time() < lastKillTime + frameOpenTime then
        if not GirlyPopKillCountFrame:IsShown() then
            GirlyPopKillCountFrame:SetSize(1112 / 16, 566 / 16)
            GirlyPopKillCountText:SetFont(fontPath, 15, "OUTLINE")
            IncreaseFrameSize(GirlyPopKillCountFrame, GirlyPopKillCountText, 300, 0.2)
        end
        GirlyPopKillCountFrame:Show()
    else
        GirlyPopKillCountFrame:Hide()

    end
end)

local gpeventFrame = CreateFrame("Frame")
gpeventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
gpeventFrame:SetScript("OnEvent", gpOnCombatLogEvent)

SLASH_GirlyPopKillCount1 = "/GirlyPopKillCount";

function GirlyPopKillCount_SlashCommand()
    for _, unit in ipairs(GirlyPopDB.KillCount) do
        print(unit.UnitName .. " Killed " .. unit.KillCount .. " Times")
    end
end

SlashCmdList["GirlyPopKillCount"] = GirlyPopKillCount_SlashCommand;

