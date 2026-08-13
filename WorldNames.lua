-- Nomes no mundo sem ficar varrendo o WorldFrame o tempo todo.
-- A ideia aqui é aproveitar a ancora 3D das NamePlates do Ascension, traduzir o
-- nome quando a placa nasce e reaplicar quando o cliente reciclar/reexibir o frame.

local AES = AscensionPTBR or {}
AscensionPTBR = AES
AES.WorldNamesV10 = true

local hookedNames = setmetatable({}, { __mode = "k" })
local nameGuards = setmetatable({}, { __mode = "k" })
local friendlyOptionsByFrame = setmetatable({}, { __mode = "k" })
local hookedPlates = setmetatable({}, { __mode = "k" })
local hookedUnitFrames = setmetatable({}, { __mode = "k" })
local knownPlates = setmetatable({}, { __mode = "k" })
local applyingPlates = setmetatable({}, { __mode = "k" })
local roleTextByFrame = setmetatable({}, { __mode = "k" })
local roleCacheByID = {}
local roleCacheByGUID = {}
local roleScanAttempts = {}
local shuttingDown = false

-- Este módulo não altera atalhos nem CVars de nameplate. Ele apenas traduz
-- os frames 3D que o próprio cliente/Ascension decidir exibir.

-- Títulos que aparecem bastante nos NPCs custom do Ascension e nem sempre existem
-- na base 3.3.5. O resto ainda passa pelo UnitSub oficial antes de cair aqui.
local ROLE_EXACT = {
    ["Guns and Ammo Merchant"] = "Mercador de Armas de Fogo e Munição",
    ["Guns & Ammo Merchant"] = "Mercador de Armas de Fogo e Munição",
    ["Gun and Ammo Merchant"] = "Mercador de Armas de Fogo e Munição",
    ["Weapons and Armor Merchant"] = "Mercador de Armas e Armaduras",
    ["Weapons & Armor Merchant"] = "Mercador de Armas e Armaduras",
    ["Weapons Merchant"] = "Mercador de Armas",
    ["Weapon Merchant"] = "Mercador de Armas",
    ["Armor Merchant"] = "Mercador de Armaduras",
    ["General Goods Merchant"] = "Mercador de Mercadorias Gerais",
    ["General Goods Vendor"] = "Vendedor de Mercadorias Gerais",
    ["General Supplies"] = "Suprimentos Gerais",
    ["Trade Supplies"] = "Suprimentos Comerciais",
    ["Food & Drink Merchant"] = "Mercador de Comidas e Bebidas",
    ["Food and Drink Merchant"] = "Mercador de Comidas e Bebidas",
    ["Food & Drink Vendor"] = "Vendedor de Comidas e Bebidas",
    ["Food and Drink Vendor"] = "Vendedor de Comidas e Bebidas",
    ["Reagent Vendor"] = "Vendedor de Reagentes",
    ["Reagents"] = "Reagentes",
    ["Innkeeper"] = "Estalajadeiro",
    ["Banker"] = "Banqueiro",
    ["Guild Banker"] = "Banqueiro da Guilda",
    ["Auctioneer"] = "Leiloeiro",
    ["Flight Master"] = "Mestre de Voo",
    ["Gryphon Master"] = "Mestre de Grifos",
    ["Hippogryph Master"] = "Mestre de Hipogrifos",
    ["Wind Rider Master"] = "Mestre de Mantícoras",
    ["Bat Handler"] = "Tratador de Morcegos",
    ["Stable Master"] = "Mestre de Estábulos",
    ["Riding Trainer"] = "Instrutor de Montaria",
    ["Profession Trainer"] = "Instrutor de Profissão",
    ["Class Trainer"] = "Instrutor de Classe",
    ["Quartermaster"] = "Intendente",
    ["Guild Master"] = "Mestre de Guilda",
    ["Barber"] = "Barbeiro",
    ["Transmogrifier"] = "Transmogrificador",
    ["Blacksmith"] = "Ferreiro",
    ["Gunsmith"] = "Armeiro",
    ["Mythic+ Vendor"] = "Vendedor de Mítica+",
    ["Mythic Plus Vendor"] = "Vendedor de Mítica+",
    ["Mystic Enchant Vendor"] = "Vendedor de Encantamentos Místicos",
    ["Mystic Enchantment Vendor"] = "Vendedor de Encantamentos Místicos",
    ["Mystic Enchantments"] = "Encantamentos Místicos",
    ["Worldforged Enchant Vendor"] = "Vendedor de Encantamentos Forjados pelo Mundo",
    ["Skill Card Vendor"] = "Vendedor de Cartas de Habilidade",
    ["Transmog Vendor"] = "Vendedor de Transmogrificação",
    ["Arena Vendor"] = "Vendedor de Arena",
    ["Arena Quartermaster"] = "Intendente de Arena",
    ["Battlemaster"] = "Mestre de Batalha",
    ["Pet Trainer"] = "Instrutor de Mascotes",
    ["Dungeon Master"] = "Mestre de Masmorras",
    ["High-Risk Vendor"] = "Vendedor de Alto Risco",
    ["High Risk Vendor"] = "Vendedor de Alto Risco",
    ["Seasonal Vendor"] = "Vendedor Sazonal",
    ["Badge of Justice Vendor"] = "Vendedor de Distintivos da Justiça",
    ["Badge of Justice Quartermaster"] = "Intendente de Distintivos da Justiça",
    ["Hybrid Risk System"] = "Sistema de Risco Híbrido",
    ["The Scarlet Crusade"] = "A Cruzada Escarlate",
    ["Scarlet Crusade"] = "Cruzada Escarlate",
}

local ROLE_SUBJECT = {
    ["Alchemy"] = "Alquimia",
    ["Blacksmithing"] = "Ferraria",
    ["Cooking"] = "Culinária",
    ["Enchanting"] = "Encantamento",
    ["Engineering"] = "Engenharia",
    ["First Aid"] = "Primeiros Socorros",
    ["Fishing"] = "Pesca",
    ["Herbalism"] = "Herborismo",
    ["Inscription"] = "Escrivania",
    ["Jewelcrafting"] = "Joalheria",
    ["Leatherworking"] = "Couraria",
    ["Mining"] = "Mineração",
    ["Skinning"] = "Esfolamento",
    ["Tailoring"] = "Alfaiataria",
    ["Archaeology"] = "Arqueologia",
    ["Warrior"] = "Guerreiros",
    ["Paladin"] = "Paladinos",
    ["Hunter"] = "Caçadores",
    ["Rogue"] = "Ladinos",
    ["Priest"] = "Sacerdotes",
    ["Death Knight"] = "Cavaleiros da Morte",
    ["Shaman"] = "Xamãs",
    ["Mage"] = "Magos",
    ["Warlock"] = "Bruxos",
    ["Druid"] = "Druidas",
    ["Weapons"] = "Armas",
    ["Weapon"] = "Armas",
    ["Armor"] = "Armaduras",
    ["Cloth Armor"] = "Armaduras de Tecido",
    ["Leather Armor"] = "Armaduras de Couro",
    ["Mail Armor"] = "Armaduras de Malha",
    ["Plate Armor"] = "Armaduras de Placas",
    ["Light Armor"] = "Armaduras Leves",
    ["Heavy Armor"] = "Armaduras Pesadas",
    ["Guns and Ammo"] = "Armas de Fogo e Munição",
    ["Guns & Ammo"] = "Armas de Fogo e Munição",
    ["Bows and Guns"] = "Arcos e Armas de Fogo",
    ["Bow & Gun"] = "Arcos e Armas de Fogo",
    ["Bows and Arrows"] = "Arcos e Flechas",
    ["Bow & Arrow"] = "Arcos e Flechas",
    ["Food and Drink"] = "Comidas e Bebidas",
    ["Food & Drink"] = "Comidas e Bebidas",
    ["General Goods"] = "Mercadorias Gerais",
    ["General Supplies"] = "Suprimentos Gerais",
    ["Trade Supplies"] = "Suprimentos Comerciais",
    ["Alchemy Supplies"] = "Suprimentos de Alquimia",
    ["Blacksmithing Supplies"] = "Suprimentos de Ferraria",
    ["Enchanting Supplies"] = "Suprimentos de Encantamento",
    ["Engineering Supplies"] = "Suprimentos de Engenharia",
    ["Fishing Supplies"] = "Suprimentos de Pesca",
    ["Herbalism Supplies"] = "Suprimentos de Herborismo",
    ["Leatherworking Supplies"] = "Suprimentos de Couraria",
    ["Mining Supplies"] = "Suprimentos de Mineração",
    ["Tailoring Supplies"] = "Suprimentos de Alfaiataria",
    ["Poison Supplies"] = "Suprimentos de Venenos",
    ["Reagents"] = "Reagentes",
    ["Bags"] = "Bolsas",
    ["Food"] = "Comidas",
    ["Drink"] = "Bebidas",
    ["Mythic+"] = "Mítica+",
    ["Mystic Enchant"] = "Encantamentos Místicos",
    ["Skill Cards"] = "Cartas de Habilidade",
    ["Transmog"] = "Transmogrificação",
    ["Arena"] = "Arena",
    ["Pets"] = "Mascotes",
    ["Pet"] = "Mascotes",
    ["Dungeon"] = "Masmorras",
    ["Dungeons"] = "Masmorras",
    ["Badges of Justice"] = "Distintivos da Justiça",
}

AES.UnitRoleEN2PT = AES.UnitRoleEN2PT or ROLE_EXACT

local function DB()
    return AscensionPTBRDB
end

local function Enabled()
    local db = DB()
    return db and db.units and db.worldNpcNames ~= false
end

local function Trim(text)
    if type(text) ~= "string" then return nil end
    text = text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
    text = text:gsub("^%s+", ""):gsub("%s+$", "")
    if text == "" then return nil end
    return text
end

local function TranslateRoleSubject(subject)
    if type(subject) ~= "string" or subject == "" then return nil end
    local direct = ROLE_SUBJECT[subject]
    if direct then return direct end

    local left, right = subject:match("^(.-)%s*&%s*(.-)$")
    if not left then left, right = subject:match("^(.-)%s+and%s+(.-)$") end
    if left and right then
        local a = ROLE_SUBJECT[left] or left
        local b = ROLE_SUBJECT[right] or right
        if a ~= left or b ~= right then return a .. " e " .. b end
    end
end

function AES.TranslateNpcRoleText(text)
    if type(text) ~= "string" or text == "" then return nil end

    local cleaned = Trim(text)
    if not cleaned then return nil end

    local wrapped = cleaned:match("^<(.-)>$")
    local core = Trim(wrapped or cleaned)
    if not core then return nil end

    local translated = (AES.UnitSubEN2PT and AES.UnitSubEN2PT[core])
        or ROLE_EXACT[core]
        or (AES.UnitRoleEN2PT and AES.UnitRoleEN2PT[core])

    if not translated and AES.TranslateStaticText then
        local ok, value = pcall(AES.TranslateStaticText, core)
        if ok and type(value) == "string" and value ~= "" and value ~= core then
            translated = value
        end
    end

    if not translated then
        local subject = core:match("^(.+)%s+Merchant$")
        local pt = subject and TranslateRoleSubject(subject)
        if pt then translated = "Mercador de " .. pt end
    end
    if not translated then
        local subject = core:match("^(.+)%s+Vendor$")
        local pt = subject and TranslateRoleSubject(subject)
        if pt then translated = "Vendedor de " .. pt end
    end
    if not translated then
        local subject = core:match("^(.+)%s+Trainer$")
        local pt = subject and TranslateRoleSubject(subject)
        if pt then translated = "Instrutor de " .. pt end
    end
    if not translated then
        local subject = core:match("^(.+)%s+Quartermaster$")
        local pt = subject and TranslateRoleSubject(subject)
        if pt then translated = "Intendente de " .. pt end
    end
    if not translated then
        local subject = core:match("^(.+)%s+Supplies$")
        local pt = subject and TranslateRoleSubject(subject)
        if pt then translated = "Suprimentos de " .. pt end
    end

    if not translated or translated == core then return nil end
    if wrapped then return "<" .. translated .. ">" end
    return translated
end

local function GetCVarValue(name)
    if C_CVar and C_CVar.Get then
        local ok, value = pcall(C_CVar.Get, name)
        if ok and value ~= nil and tostring(value) ~= "" then return tostring(value) end
    end
    if GetCVar then
        local ok, value = pcall(GetCVar, name)
        if ok and value ~= nil and tostring(value) ~= "" then return tostring(value) end
    end
end

local function SetCVarValue(name, value)
    if C_CVar and C_CVar.Set then
        local ok = pcall(C_CVar.Set, name, tostring(value))
        if ok then return true end
    end
    if SetCVar then
        return pcall(SetCVar, name, tostring(value))
    end
    return false
end

local function IsPlayer(unit)
    return UnitIsPlayer and UnitIsPlayer(unit) and true or false
end

local function IsFriendly(unit)
    return UnitIsFriend and UnitIsFriend("player", unit) and true or false
end

local function IsFriendlyNPC(unit)
    if not IsFriendly(unit) or IsPlayer(unit) then return false end
    if UnitPlayerControlled and UnitPlayerControlled(unit) then return false end
    return true
end

local function IsRoleNPC(unit)
    if IsPlayer(unit) then return false end
    if UnitPlayerControlled and UnitPlayerControlled(unit) then return false end
    if UnitReaction then
        local reaction = UnitReaction("player", unit)
        if reaction then return reaction >= 4 end
    end
    return IsFriendly(unit)
end

local function NpcIDFromGUID(guid)
    if type(guid) ~= "string" or guid == "" then return nil end

    if GetCreatureIDFromGUID then
        local ok, id = pcall(GetCreatureIDFromGUID, guid)
        if ok and tonumber(id) and tonumber(id) > 0 then return tonumber(id) end
    end

    if guid:find("-", 1, true) and strsplit then
        local unitType, rest = strsplit("-", guid, 2)
        if unitType == "Creature" or unitType == "Vehicle" or unitType == "Pet" then
            local id = tonumber(select(5, strsplit("-", rest)))
            if id and id > 0 then return id end
        end
    elseif guid:sub(1, 2) == "0x" then
        local hex = guid:sub(3)
        if #hex == 16 and hex:match("^F1[345]") then
            local id = tonumber(hex:sub(5, 10), 16)
            if id and id > 0 then return id end
        end
    end
end

local function ResolveName(unit, shownText)
    if not (unit and UnitExists and UnitExists(unit)) then return nil end
    if IsPlayer(unit) then return nil end

    local enName = UnitName and UnitName(unit)
    if type(enName) ~= "string" or enName == "" then return nil end

    local ptName
    local guid = UnitGUID and UnitGUID(unit)
    local npcID = NpcIDFromGUID(guid)
    if npcID then
        local mapped = AES.UnitName and AES.UnitName[npcID]
        local guard = AES.UnitNameEN and AES.UnitNameEN[npcID]
        if type(mapped) == "string" and mapped ~= "" and mapped ~= enName
            and (not guard or guard == enName) then
            ptName = mapped
        end
    end

    if not ptName and AES.UnitNameEN2ES then
        local mapped = AES.UnitNameEN2ES[enName]
        if type(mapped) == "string" and mapped ~= "" and mapped ~= enName then
            ptName = mapped
        end
    end

    if not ptName and AES.UnitNamePreferredEN2PT then
        local mapped = AES.UnitNamePreferredEN2PT[enName]
        if type(mapped) == "string" and mapped ~= "" and mapped ~= enName then
            ptName = mapped
        end
    end

    if not ptName and type(shownText) == "string" and shownText ~= "" and shownText ~= enName then
        local known = AES.UnitNameEN2ES and AES.UnitNameEN2ES[enName]
        if known == shownText then ptName = shownText end
    end

    if ptName then
        AES.UnitNameEN2ES = AES.UnitNameEN2ES or {}
        AES.UnitNameEN2ES[enName] = ptName
        return ptName, enName
    end
end

local scanner
local function GetScanner()
    if scanner then return scanner end
    if not CreateFrame then return nil end
    local ok, tip = pcall(CreateFrame, "GameTooltip", "AscensionPTBRWorldNameScanner", UIParent, "GameTooltipTemplate")
    if not ok or not tip then return nil end
    scanner = tip
    scanner:SetOwner(UIParent, "ANCHOR_NONE")
    scanner:Hide()
    return scanner
end

local function ScanSubtitle(unit)
    local tip = GetScanner()
    if not tip or not tip.SetUnit then return nil end

    local ok = pcall(function()
        tip:SetOwner(UIParent, "ANCHOR_NONE")
        if tip.ClearLines then tip:ClearLines() end
        tip:SetUnit(unit)
    end)
    if not ok then
        pcall(tip.Hide, tip)
        return nil
    end

    local tipName = tip.GetName and tip:GetName()
    local lines = (tip.NumLines and tip:NumLines()) or 0
    local found
    for i = 2, math.min(lines, 4) do
        local fs = tipName and _G[tipName .. "TextLeft" .. i]
        local text = fs and fs.GetText and Trim(fs:GetText())
        if text then
            local angle = text:match("^<(.-)>$")
            if angle and angle ~= "" then
                found = angle
                break
            end
            if i == 2
                and not text:match("^Level%s")
                and not text:match("^Nível%s")
                and not text:match("^%d+%s") then
                found = text
                break
            end
        end
    end

    pcall(tip.Hide, tip)
    return found
end

local function ResolveSubtitle(unit)
    if not (unit and UnitExists and UnitExists(unit)) or IsPlayer(unit) then return nil end

    local guid = UnitGUID and UnitGUID(unit)
    local npcID = NpcIDFromGUID(guid)
    local enSub = npcID and AES.UnitSubEN and AES.UnitSubEN[npcID]
    local ptSub = npcID and AES.UnitSub and AES.UnitSub[npcID]
    if type(ptSub) == "string" and ptSub ~= "" then
        if type(enSub) == "string" and enSub ~= "" and enSub == ptSub
            and AES.TranslateNpcRoleText then
            local improved = AES.TranslateNpcRoleText(enSub)
            if improved then
                improved = improved:match("^<(.-)>$") or improved
                return improved, enSub
            end
        end
        return ptSub, enSub
    end

    if npcID and roleCacheByID[npcID] then return roleCacheByID[npcID] end
    if guid and roleCacheByGUID[guid] then return roleCacheByGUID[guid] end

    local cacheKey = guid or (npcID and ("id:" .. npcID)) or unit
    local tries = roleScanAttempts[cacheKey] or 0
    if tries >= 4 then return nil end
    roleScanAttempts[cacheKey] = tries + 1

    local raw = ScanSubtitle(unit)
    if not raw then return nil end

    local translated = AES.TranslateNpcRoleText and AES.TranslateNpcRoleText(raw)
    if translated then
        translated = translated:match("^<(.-)>$") or translated
    elseif AES.UnitSubEN2PT then
        translated = AES.UnitSubEN2PT[raw]
    end

    if translated and translated ~= "" and translated ~= raw then
        if npcID then roleCacheByID[npcID] = translated end
        if guid then roleCacheByGUID[guid] = translated end
        return translated, raw
    end
end

function AES.LearnWorldNpcRole(unit, rawText, translatedText)
    if type(unit) ~= "string" or not (UnitExists and UnitExists(unit)) then return false end
    if IsPlayer(unit) then return false end

    local raw = Trim(rawText)
    local translated = Trim(translatedText)
    raw = raw and (raw:match("^<(.-)>$") or raw)
    translated = translated and (translated:match("^<(.-)>$") or translated)
    if not raw or not translated or raw == translated then return false end

    local guid = UnitGUID and UnitGUID(unit)
    local npcID = NpcIDFromGUID(guid)
    if npcID then roleCacheByID[npcID] = translated end
    if guid then roleCacheByGUID[guid] = translated end
    return true
end

local function TranslateNameFontString(fs)
    if nameGuards[fs] or not Enabled() then return end
    local unit = fs and fs.__aptbrUnit
    if not unit or IsPlayer(unit) then return end

    local text = fs.GetText and fs:GetText()
    local ptName = ResolveName(unit, text)
    if ptName and ptName ~= text and fs.SetText then
        nameGuards[fs] = true
        pcall(fs.SetText, fs, ptName)
        nameGuards[fs] = nil
    end
end

local function HookNameFontString(fs, unit)
    if not (fs and fs.GetText and fs.SetText) then return false end
    fs.__aptbrUnit = unit

    if not hookedNames[fs] then
        hookedNames[fs] = true
        if hooksecurefunc then
            pcall(hooksecurefunc, fs, "SetText", TranslateNameFontString)
            if fs.SetFormattedText then
                pcall(hooksecurefunc, fs, "SetFormattedText", TranslateNameFontString)
            end
        end
    end

    TranslateNameFontString(fs)
    return true
end

local function FindExactNameFontString(frame, enName, ptName, depth)
    if not frame or depth > 3 then return nil end

    if frame.GetRegions then
        for _, region in ipairs({ frame:GetRegions() }) do
            if region and region.IsObjectType and region:IsObjectType("FontString") and region.GetText then
                local text = region:GetText()
                if text == enName or (ptName and text == ptName) then
                    return region
                end
            end
        end
    end

    if frame.GetChildren then
        for _, child in ipairs({ frame:GetChildren() }) do
            local found = FindExactNameFontString(child, enName, ptName, depth + 1)
            if found then return found end
        end
    end
end

local function GetNameplate(unit, suppliedPlate)
    if suppliedPlate then return suppliedPlate end

    if C_NamePlate and C_NamePlate.GetNamePlateForUnit then
        local ok, plate = pcall(C_NamePlate.GetNamePlateForUnit, unit)
        if ok and plate then return plate end
    end

    if C_NamePlateManager and C_NamePlateManager.GetNamePlateForUnit then
        local ok, plate = pcall(C_NamePlateManager.GetNamePlateForUnit, unit)
        if ok and plate then return plate end
    end
end

local function ResolvePlateUnit(plate)
    if not plate then return nil end
    local frame = plate.UnitFrame
    local unit = plate._unit
        or (frame and (frame.unit or frame.displayedUnit or frame.unitToken))
        or plate.__aptbrUnit
    if unit and UnitExists and UnitExists(unit) then return unit end
end

local function BuildFriendlyNameOnlyOptions(unitFrame)
    local source = _G.DefaultCompactNamePlateFriendlyFrameOptions
    if type(source) ~= "table" then return nil end

    local options = friendlyOptionsByFrame[unitFrame]
    if not options then
        options = {}
        friendlyOptionsByFrame[unitFrame] = options
    else
        for key in pairs(options) do options[key] = nil end
    end

    for key, value in pairs(source) do options[key] = value end
    options.nameOnly = true
    options.displayName = true
    options.hideCastbar = true
    options.displayPowerBar = false
    options.displayStatusText = false
    options.showNPCLevel = false
    options.showPlayerLevel = false
    options.showClassificationIndicator = false
    options.showQuestIcons = false
    options.showQuestNPCIcons = false
    options.showQuestObjectives = false
    return options
end

local function HideRole(frame)
    local role = frame and roleTextByFrame[frame]
    if role and role.Hide then pcall(role.Hide, role) end
end

local function ApplyAscensionFriendlyNameOnly(unitFrame, unit)
    -- Só estiliza o frame quando o próprio cliente já criou uma placa para o NPC.
    -- Não escondemos jogadores aliados e não ligamos placas amigáveis por conta própria.
    if not IsFriendlyNPC(unit) then return false end

    local options = BuildFriendlyNameOnlyOptions(unitFrame)
    if options then
        local ok = false

        if DefaultCompactNamePlateFrameSetup then
            ok = pcall(DefaultCompactNamePlateFrameSetup, unitFrame, options)
        elseif _G.DefaultCompactNamePlateFriendlyFrameSetup and unitFrame.SetUpFrame then
            local globalOptions = _G.DefaultCompactNamePlateFriendlyFrameOptions
            local oldNameOnly = globalOptions and globalOptions.nameOnly
            local oldDisplayName = globalOptions and globalOptions.displayName
            if globalOptions then
                globalOptions.nameOnly = true
                globalOptions.displayName = true
            end
            ok = pcall(unitFrame.SetUpFrame, unitFrame, _G.DefaultCompactNamePlateFriendlyFrameSetup)
            if globalOptions then
                globalOptions.nameOnly = oldNameOnly
                globalOptions.displayName = oldDisplayName
            end
            if ok and unitFrame.SetOptionTable then
                pcall(unitFrame.SetOptionTable, unitFrame, options)
            end
        end

        if ok then
            if unitFrame.BuffFrame then
                if unitFrame.BuffFrame.SetActive then pcall(unitFrame.BuffFrame.SetActive, unitFrame.BuffFrame, false) end
                if unitFrame.BuffFrame.Hide then pcall(unitFrame.BuffFrame.Hide, unitFrame.BuffFrame) end
            end
            if unitFrame.castBar and unitFrame.castBar.Hide then pcall(unitFrame.castBar.Hide, unitFrame.castBar) end
            if unitFrame.questIcon and unitFrame.questIcon.Hide then pcall(unitFrame.questIcon.Hide, unitFrame.questIcon) end
            if unitFrame.Show then pcall(unitFrame.Show, unitFrame) end
            local fs = unitFrame.name or unitFrame.Name or unitFrame.nameText
            if fs and fs.Show then pcall(fs.Show, fs) end
            return true
        end
    end

    for _, key in ipairs({
        "healthBar", "powerBar", "castBar", "BuffFrame", "ClassificationFrame",
        "LevelFrame", "RaidTargetFrame", "aggroHighlight", "selectionHighlight",
    }) do
        local object = unitFrame[key]
        if object and object.Hide then pcall(object.Hide, object) end
    end
    local fs = unitFrame.name or unitFrame.Name or unitFrame.nameText
    if unitFrame.Show then pcall(unitFrame.Show, unitFrame) end
    if fs and fs.Show then pcall(fs.Show, fs) end
    return true
end

local function ApplyRoleText(container, nameFS, roleText)
    if not container then return false end
    roleText = Trim(roleText)
    roleText = roleText and (roleText:match("^<(.-)>$") or roleText)
    if not roleText or roleText == "" or not nameFS then
        HideRole(container)
        return false
    end

    local role = roleTextByFrame[container]
    if not role and container.CreateFontString then
        local ok, created = pcall(container.CreateFontString, container, nil, "OVERLAY", "GameFontNormalSmall")
        if ok then role = created end
        if role then roleTextByFrame[container] = role end
    end
    if not role then return false end

    if role.ClearAllPoints then pcall(role.ClearAllPoints, role) end
    if role.SetPoint then pcall(role.SetPoint, role, "TOP", nameFS, "BOTTOM", 0, -1) end
    if role.SetWidth then pcall(role.SetWidth, role, 320) end
    if role.SetJustifyH then pcall(role.SetJustifyH, role, "CENTER") end
    if role.SetWordWrap then pcall(role.SetWordWrap, role, false) end

    if nameFS.GetTextColor and role.SetTextColor then
        local ok, r, g, b, a = pcall(nameFS.GetTextColor, nameFS)
        if ok and type(r) == "number" then pcall(role.SetTextColor, role, r, g, b, a or 1) end
    end

    pcall(role.SetText, role, "<" .. roleText .. ">")
    pcall(role.Show, role)
    return true
end

local ApplyToUnit

local function HookUnitFrameLifecycle(unitFrame, plate)
    if not unitFrame then return end
    unitFrame.__aptbrPlate = plate
    if hookedUnitFrames[unitFrame] or not unitFrame.HookScript then return end
    hookedUnitFrames[unitFrame] = true

    pcall(unitFrame.HookScript, unitFrame, "OnShow", function(frame)
        if not Enabled() then return end
        local p = frame.__aptbrPlate
        if not p or applyingPlates[p] then return end
        local unit = frame.unit or frame.displayedUnit or frame.unitToken or p.__aptbrUnit
        if not (unit and UnitExists and UnitExists(unit)) then return end
        ApplyToUnit(unit, p)
        if AES.Runtime then
            AES.Runtime.After("world-unitframe-show:" .. tostring(frame), 0.04, function()
                local currentPlate = frame.__aptbrPlate
                local current = frame.unit or frame.displayedUnit or frame.unitToken
                    or (currentPlate and currentPlate.__aptbrUnit)
                if currentPlate and current and UnitExists and UnitExists(current) then
                    ApplyToUnit(current, currentPlate)
                end
            end)
        end
    end)
end

local function HookPlateLifecycle(plate)
    if not plate then return end
    knownPlates[plate] = true
    if hookedPlates[plate] or not plate.HookScript then return end
    hookedPlates[plate] = true

    pcall(plate.HookScript, plate, "OnShow", function(p)
        if not Enabled() or applyingPlates[p] then return end
        local unit = ResolvePlateUnit(p)
        if not unit then return end
        ApplyToUnit(unit, p)
        if AES.Runtime then
            AES.Runtime.After("world-plate-show:" .. tostring(p), 0.04, function()
                local current = ResolvePlateUnit(p)
                if current then ApplyToUnit(current, p) end
            end)
        end
    end)
end

ApplyToUnit = function(unit, suppliedPlate)
    if not Enabled() or type(unit) ~= "string" then return false end
    if not (UnitExists and UnitExists(unit)) then return false end

    local plate = GetNameplate(unit, suppliedPlate)
    if not plate then return false end
    if applyingPlates[plate] then return false end
    applyingPlates[plate] = true

    plate.__aptbrUnit = unit
    HookPlateLifecycle(plate)

    local unitFrame = plate.UnitFrame
    local applied = false
    if unitFrame then
        unitFrame.__aptbrUnit = unit
        HookUnitFrameLifecycle(unitFrame, plate)

        ApplyAscensionFriendlyNameOnly(unitFrame, unit)

        if IsPlayer(unit) or (UnitPlayerControlled and UnitPlayerControlled(unit)) then
            HideRole(unitFrame)
            applyingPlates[plate] = nil
            return true
        end

        local nameFS = unitFrame.name or unitFrame.Name or unitFrame.nameText
        if nameFS then applied = HookNameFontString(nameFS, unit) or applied end

        if IsRoleNPC(unit) then
            local roleText = ResolveSubtitle(unit)
            ApplyRoleText(unitFrame, nameFS, roleText)
        else
            HideRole(unitFrame)
        end
    elseif not IsPlayer(unit) then
        local enName = UnitName and UnitName(unit)
        if type(enName) == "string" and enName ~= "" then
            local ptName = ResolveName(unit)
            local fs = FindExactNameFontString(plate, enName, ptName, 0)
            if fs then
                applied = HookNameFontString(fs, unit) or applied
                if IsRoleNPC(unit) then
                    local roleText = ResolveSubtitle(unit)
                    ApplyRoleText(plate, fs, roleText)
                else
                    HideRole(plate)
                end
            end
        end
    end

    applyingPlates[plate] = nil
    return applied
end
AES.ApplyWorldNameToUnit = ApplyToUnit
AES.TranslateNativeNameplate = ApplyToUnit

local function ApplyPlateObject(plate)
    if not plate then return false end
    HookPlateLifecycle(plate)
    local unit = ResolvePlateUnit(plate)
    if unit then return ApplyToUnit(unit, plate) end
    return false
end

local function ApplyToActivePlates()
    if not Enabled() then return end
    local touched = false

    if C_NamePlateManager and C_NamePlateManager.EnumerateActiveNamePlates then
        local ok, result = pcall(C_NamePlateManager.EnumerateActiveNamePlates)
        if ok and type(result) == "function" then
            for plate in result do
                ApplyPlateObject(plate)
                touched = true
            end
        elseif ok and type(result) == "table" then
            for _, plate in pairs(result) do
                ApplyPlateObject(plate)
                touched = true
            end
        elseif ok and result then
            ApplyPlateObject(result)
            touched = true
        end
    end

    if C_NamePlate and C_NamePlate.GetNamePlates then
        local ok, plates = pcall(C_NamePlate.GetNamePlates)
        if ok and type(plates) == "table" then
            for _, plate in pairs(plates) do
                ApplyPlateObject(plate)
                touched = true
            end
        end
    end

    if not touched then
        for plate in pairs(knownPlates) do
            ApplyPlateObject(plate)
        end
    end
end

-- Para traduzir o texto 3D do NPC precisamos de uma placa amigável real como
-- âncora. O nome verde nativo do mundo é desenhado pelo cliente e não é um
-- FontString acessível ao Lua. Então mantemos somente a categoria de NPC amigável
-- ligada e deixamos jogadores/pets fora das placas.
--
-- O detalhe importante está no V: no cliente do Ascension os bindings NAMEPLATES e
-- ALLNAMEPLATES também mexem em nameplateShowFriends. Por isso, se deixarmos o
-- binding original agir, ele derruba a âncora dos NPCs. Em vez de brigar com CVars
-- depois de cada tecla, fazemos um override temporário do V para um botão invisível
-- que alterna APENAS nameplateShowEnemies. O binding salvo do jogador não é alterado.

local NPC_ANCHOR_CVARS = {
    { "nameplateShowFriends", "1", "_aptbrNpcAnchorFriendsBeforeV10" },
    { "nameplateShowFriendlyNPCs", "1", "_aptbrNpcAnchorNpcsBeforeV10" },
    { "nameplateShowFriendlyPlayers", "0", "_aptbrNpcAnchorPlayersBeforeV10" },
    { "nameplateShowFriendlyPets", "0", "_aptbrNpcAnchorPetsBeforeV10" },
    { "nameplateShowFriendlyMinions", "0", "_aptbrNpcAnchorMinionsBeforeV10" },
    { "nameplateShowFriendlyGuardians", "0", "_aptbrNpcAnchorGuardiansBeforeV10" },
    { "nameplateShowFriendlyTotems", "0", "_aptbrNpcAnchorTotemsBeforeV10" },
    -- Garante que os nicknames normais dos jogadores aliados continuem aparecendo.
    { "UnitNameFriendlyPlayerName", "1", "_aptbrFriendlyPlayerWorldNameBeforeV10" },
}

local NPC_ANCHOR_CVAR_SET = {}
for _, info in ipairs(NPC_ANCHOR_CVARS) do
    NPC_ANCHOR_CVAR_SET[string.lower(info[1])] = true
end

local anchorMutation = false
local anchorRefreshPending = false
local bindingRefreshPending = false
local bindingMutation = false
local bindingOwner = CreateFrame("Frame")
local enemyToggleButton = CreateFrame("Button", "AscensionPTBREnemyNameplateToggleButton", UIParent)
local vOverrideActive = false
local vBaseAction

if enemyToggleButton then
    if enemyToggleButton.SetSize then pcall(enemyToggleButton.SetSize, enemyToggleButton, 1, 1) end
    if enemyToggleButton.SetPoint then pcall(enemyToggleButton.SetPoint, enemyToggleButton, "TOPLEFT", UIParent, "BOTTOMLEFT", -100, -100) end
    if enemyToggleButton.SetAlpha then pcall(enemyToggleButton.SetAlpha, enemyToggleButton, 0) end
    if enemyToggleButton.EnableMouse then pcall(enemyToggleButton.EnableMouse, enemyToggleButton, false) end
    if enemyToggleButton.RegisterForClicks then pcall(enemyToggleButton.RegisterForClicks, enemyToggleButton, "AnyUp") end
    if enemyToggleButton.Show then pcall(enemyToggleButton.Show, enemyToggleButton) end
end

local function BoolCVar(value)
    value = tostring(value or "")
    return value == "1" or value == "true" or value == "TRUE"
end

local function ToggleEnemyNameplatesOnly()
    if not Enabled() then return end
    local current = GetCVarValue("nameplateShowEnemies")
    if current == nil then return end
    SetCVarValue("nameplateShowEnemies", BoolCVar(current) and "0" or "1")
end

if enemyToggleButton and enemyToggleButton.SetScript then
    enemyToggleButton:SetScript("OnClick", ToggleEnemyNameplatesOnly)
end

local function CleanupLegacyNameplateState(db)
    if not db or db._aptbrNpcAnchorLegacyCleanV10 then return end

    -- Estados deixados pelos experimentos anteriores. Primeiro devolvemos o valor
    -- original quando ele ainda existir; depois limpamos as chaves antigas para que
    -- elas nunca mais sejam reaplicadas por engano.
    local legacy = {
        { "nameplateShowFriends", "_aptbrFriendlyMasterBefore" },
        { "nameplateShowFriends", "_aptbrFriendlyMasterBeforeV2" },
        { "nameplateShowFriendlyNPCs", "_aptbrFriendlyNpcCVarBefore" },
        { "nameplateShowFriendlyNPCs", "_aptbrFriendlyNpcCVarBeforeV2" },
        { "nameplateShowFriendlyPlayers", "_aptbrFriendlyPlayersCVarBefore" },
        { "nameplateShowFriendlyPets", "_aptbrFriendlyPetsCVarBefore" },
        { "nameplateShowFriendlyMinions", "_aptbrFriendlyMinionsCVarBefore" },
        { "nameplateShowFriendlyGuardians", "_aptbrFriendlyGuardiansCVarBefore" },
        { "nameplateShowFriendlyTotems", "_aptbrFriendlyTotemsCVarBefore" },
    }

    if db._aptbrFriendlyNpcCVarBefore == nil and db._friendlyNpcNamesBeforePTBR ~= nil then
        db._aptbrFriendlyNpcCVarBefore = db._friendlyNpcNamesBeforePTBR
        db._friendlyNpcNamesBeforePTBR = nil
    end

    anchorMutation = true
    for _, info in ipairs(legacy) do
        local value = db[info[2]]
        if value ~= nil then
            SetCVarValue(info[1], value)
            db[info[2]] = nil
        end
    end
    anchorMutation = false

    db._aptbrForcedFriendlyMaster = nil
    db._aptbrNameplateStateRestoredV8 = nil
    db._aptbrLegacyFriendlyCVarsCleaned = nil
    db._aptbrLegacyFriendlyCVarsCleanedV2 = nil
    db._aptbrNpcAnchorLegacyCleanV10 = true
end

local function SaveAndSetAnchor(db, cvar, wanted, key)
    local current = GetCVarValue(cvar)
    if current == nil then return false end
    if db[key] == nil then db[key] = current end
    if tostring(current) ~= tostring(wanted) then
        SetCVarValue(cvar, wanted)
    end
    return true
end

local function RestoreNpcAnchorState(clearSaved)
    local db = DB()
    if not db then return end

    anchorMutation = true
    for _, info in ipairs(NPC_ANCHOR_CVARS) do
        local saved = db[info[3]]
        if saved ~= nil then
            SetCVarValue(info[1], saved)
            if clearSaved then db[info[3]] = nil end
        end
    end
    anchorMutation = false
end

local function EnsureNpcAnchorMode()
    local db = DB()
    if not db then return false end
    CleanupLegacyNameplateState(db)

    if not Enabled() then
        RestoreNpcAnchorState(true)
        return false
    end

    anchorMutation = true
    local supported = false
    for _, info in ipairs(NPC_ANCHOR_CVARS) do
        if SaveAndSetAnchor(db, info[1], info[2], info[3]) then
            supported = true
        end
    end
    anchorMutation = false
    return supported
end

local function IsNameplateBindingAction(action)
    if type(action) ~= "string" or action == "" then return false end
    action = string.upper(action)
    return string.find(action, "NAMEPLATE", 1, true) ~= nil
end

local function ClearVEnemyOverride()
    if ClearOverrideBindings and bindingOwner then
        bindingMutation = true
        pcall(ClearOverrideBindings, bindingOwner)
        bindingMutation = false
    end
    vOverrideActive = false
end

local function ApplyVEnemyOnlyOverride()
    if InCombatLockdown and InCombatLockdown() then
        bindingRefreshPending = true
        return false
    end

    ClearVEnemyOverride()
    if not Enabled() then
        bindingRefreshPending = false
        return false
    end

    local action
    if GetBindingAction then
        local ok, value = pcall(GetBindingAction, "V")
        if ok then action = value end
    end
    vBaseAction = action

    -- Não roubamos V se o usuário usa a tecla para outra coisa.
    if not IsNameplateBindingAction(action) then
        bindingRefreshPending = false
        return false
    end

    local ok = false
    if SetOverrideBindingClick and enemyToggleButton and enemyToggleButton.GetName then
        local name = enemyToggleButton:GetName()
        if name then
            bindingMutation = true
            ok = pcall(SetOverrideBindingClick, bindingOwner, false, "V", name, "LeftButton")
            bindingMutation = false
        end
    end

    if not ok and SetOverrideBinding and enemyToggleButton and enemyToggleButton.GetName then
        local name = enemyToggleButton:GetName()
        if name then
            bindingMutation = true
            ok = pcall(SetOverrideBinding, bindingOwner, false, "V", "CLICK " .. name .. ":LeftButton")
            bindingMutation = false
        end
    end

    vOverrideActive = ok and true or false
    bindingRefreshPending = false
    return vOverrideActive
end

local function QueueAnchorRepair()
    if shuttingDown or anchorMutation or anchorRefreshPending then return end
    anchorRefreshPending = true

    local function run()
        anchorRefreshPending = false
        if shuttingDown or not Enabled() then return end
        EnsureNpcAnchorMode()
        ApplyToActivePlates()
    end

    if AES.Runtime then
        AES.Runtime.After("world-npc-anchor-repair", 0.03, run)
    else
        run()
    end
end

local function QueueRefresh()
    if shuttingDown or not Enabled() then return end
    EnsureNpcAnchorMode()

    if AES.Runtime then
        AES.Runtime.Repeat("world-names-rebuild", 0.03, 0.12, 6, function()
            ApplyToActivePlates()
        end)
    else
        ApplyToActivePlates()
    end
end

AES.ApplyWorldNpcNameplates = function()
    local supported = EnsureNpcAnchorMode()
    if Enabled() then
        ApplyVEnemyOnlyOverride()
        ApplyToActivePlates()
        QueueRefresh()
    else
        ClearVEnemyOverride()
    end
    return supported
end

local events = CreateFrame("Frame")
pcall(events.RegisterEvent, events, "NAME_PLATE_UNIT_ADDED")
pcall(events.RegisterEvent, events, "NAME_PLATE_UNIT_REMOVED")
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:RegisterEvent("PLAYER_TARGET_CHANGED")
events:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
events:RegisterEvent("PLAYER_LOGOUT")
pcall(events.RegisterEvent, events, "PLAYER_REGEN_ENABLED")
pcall(events.RegisterEvent, events, "UPDATE_BINDINGS")
pcall(events.RegisterEvent, events, "CVAR_UPDATE")

events:SetScript("OnEvent", function(_, event, arg1)
    if event == "NAME_PLATE_UNIT_ADDED" then
        ApplyToUnit(arg1)
        if AES.Runtime then
            AES.Runtime.Repeat("world-name:" .. tostring(arg1), 0.03, 0.10, 3, function()
                return ApplyToUnit(arg1) ~= false
            end)
        end
    elseif event == "NAME_PLATE_UNIT_REMOVED" then
        return
    elseif event == "PLAYER_TARGET_CHANGED" then
        ApplyToUnit("target")
    elseif event == "UPDATE_MOUSEOVER_UNIT" then
        ApplyToUnit("mouseover")
    elseif event == "PLAYER_REGEN_ENABLED" then
        if bindingRefreshPending then ApplyVEnemyOnlyOverride() end
        if anchorRefreshPending then QueueAnchorRepair() end
    elseif event == "UPDATE_BINDINGS" then
        if not bindingMutation then ApplyVEnemyOnlyOverride() end
    elseif event == "CVAR_UPDATE" then
        if type(arg1) == "string" and NPC_ANCHOR_CVAR_SET[string.lower(arg1)] and not anchorMutation then
            QueueAnchorRepair()
        end
    elseif event == "PLAYER_LOGOUT" then
        shuttingDown = true
        ClearVEnemyOverride()
        RestoreNpcAnchorState(false)
    elseif event == "PLAYER_ENTERING_WORLD" then
        EnsureNpcAnchorMode()
        ApplyVEnemyOnlyOverride()
        if AES.Runtime then
            AES.Runtime.After("world-names-enter", 0.12, function()
                if Enabled() then
                    EnsureNpcAnchorMode()
                    ApplyToActivePlates()
                end
            end)
        else
            ApplyToActivePlates()
        end
    end
end)

-- O Ascension cria a UnitFrame quando a placa entra no gerenciador. Traduzimos
-- nesse ponto e também no OnShow para cobrir reciclagem do pool.
if EventRegistry and EventRegistry.RegisterCallback then
    pcall(EventRegistry.RegisterCallback, EventRegistry, "NamePlateManager.UnitAdded", function(_, unit, plate)
        ApplyToUnit(unit, plate)
        if AES.Runtime then
            AES.Runtime.After("world-name-registry:" .. tostring(unit), 0.03, function()
                ApplyToUnit(unit, plate)
            end)
        end
    end, events)

    pcall(EventRegistry.RegisterCallback, EventRegistry, "NamePlateDriver.UnitFrameCreated", function(_, plate)
        ApplyPlateObject(plate)
    end, events)
end

-- Diagnóstico curto. Não altera configuração; só mostra o estado real da build.
SLASH_APTBRPLATES1 = "/aptbrplates"
SlashCmdList["APTBRPLATES"] = function()
    local action = vBaseAction or "<n/a>"
    local friends = GetCVarValue("nameplateShowFriends") or "<n/a>"
    local npcs = GetCVarValue("nameplateShowFriendlyNPCs") or "<n/a>"
    local players = GetCVarValue("nameplateShowFriendlyPlayers") or "<n/a>"
    local nativePlayers = GetCVarValue("UnitNameFriendlyPlayerName") or "<n/a>"
    local enemies = GetCVarValue("nameplateShowEnemies") or "<n/a>"
    DEFAULT_CHAT_FRAME:AddMessage(string.format(
        "|cff33ff99AscensionPTBR|r: Vbase=%s override=%s | friends=%s NPC=%s playersPlate=%s playerName=%s enemies=%s",
        tostring(action), vOverrideActive and "SIM" or "NÃO", tostring(friends), tostring(npcs),
        tostring(players), tostring(nativePlayers), tostring(enemies)))
end

SLASH_APTBRNPC1 = "/aptbrnpc"
SlashCmdList["APTBRNPC"] = function()
    local unit = UnitExists and UnitExists("target") and "target"
        or (UnitExists and UnitExists("mouseover") and "mouseover")
    if not unit then
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r: selecione um NPC e use /aptbrnpc.")
        return
    end

    local enName = UnitName and UnitName(unit) or "<sem nome>"
    local guid = UnitGUID and UnitGUID(unit)
    local npcID = NpcIDFromGUID(guid)
    local ptName = ResolveName(unit) or "<sem tradução>"
    local ptRole, enRole = ResolveSubtitle(unit)
    local plate = GetNameplate(unit)

    DEFAULT_CHAT_FRAME:AddMessage(string.format(
        "|cff33ff99AscensionPTBR|r: id=%s EN=%s PT=%s funçãoEN=%s funçãoPT=%s placa=%s",
        tostring(npcID or "?"), tostring(enName), tostring(ptName), tostring(enRole or "?"),
        tostring(ptRole or "?"), plate and "SIM" or "NÃO"))

    ApplyToUnit(unit, plate)
end
