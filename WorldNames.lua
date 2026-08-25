-- Nomes no mundo e placas sociais sem varrer o WorldFrame o tempo todo.
-- NPCs usam a ancora 3D das NamePlates do Ascension para nome/função traduzidos.
-- Jogadores aliados ganham uma placa leve com nome, guilda e nível.

local AES = AscensionPTBR or {}
AscensionPTBR = AES
AES.WorldNamesV12 = true
AES.Diagnostics = AES.Diagnostics or {}

local hookedNames = setmetatable({}, { __mode = "k" })
local nameGuards = setmetatable({}, { __mode = "k" })
local hookedPlates = setmetatable({}, { __mode = "k" })
local hookedUnitFrames = setmetatable({}, { __mode = "k" })
local knownPlates = setmetatable({}, { __mode = "k" })
local applyingPlates = setmetatable({}, { __mode = "k" })
local roleTextByFrame = setmetatable({}, { __mode = "k" })
local allyStyleByFrame = setmetatable({}, { __mode = "k" })
local safeOptionsByFrame = setmetatable({}, { __mode = "k" })
local roleCacheByID = {}
local roleCacheByGUID = {}
local roleScanAttempts = {}
local roleCacheByIDCount = 0
local roleCacheByGUIDCount = 0
local roleScanAttemptsCount = 0
local ROLE_ID_CACHE_LIMIT = 4096
local ROLE_GUID_CACHE_LIMIT = 1536
local ROLE_ATTEMPT_CACHE_LIMIT = 3072
local shuttingDown = false

local function ResetTransientRoleCaches()
    roleCacheByGUID = {}
    roleScanAttempts = {}
    roleCacheByGUIDCount = 0
    roleScanAttemptsCount = 0
end

local function CacheRoleByID(id, value)
    if not id or type(value) ~= "string" or value == "" then return end
    if roleCacheByID[id] == nil then
        roleCacheByIDCount = roleCacheByIDCount + 1
        if roleCacheByIDCount > ROLE_ID_CACHE_LIMIT then
            roleCacheByID = {}
            roleCacheByIDCount = 1
        end
    end
    roleCacheByID[id] = value
end

local function CacheRoleByGUID(guid, value)
    if not guid or type(value) ~= "string" or value == "" then return end
    if roleCacheByGUID[guid] == nil then
        roleCacheByGUIDCount = roleCacheByGUIDCount + 1
        if roleCacheByGUIDCount > ROLE_GUID_CACHE_LIMIT then
            roleCacheByGUID = {}
            roleCacheByGUIDCount = 1
        end
    end
    roleCacheByGUID[guid] = value
end

local function RememberRoleScanAttempt(key, tries)
    if not key then return end
    if roleScanAttempts[key] == nil then
        roleScanAttemptsCount = roleScanAttemptsCount + 1
        if roleScanAttemptsCount > ROLE_ATTEMPT_CACHE_LIMIT then
            roleScanAttempts = {}
            roleScanAttemptsCount = 1
        end
    end
    roleScanAttempts[key] = tries
end

-- No cliente padrão do Ascension este módulo mantém apenas as placas amigáveis
-- necessárias para NPCs e aliados. Addons externos de nameplate assumem prioridade.

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
    ["Supply Officer"] = "Oficial de Suprimentos",
    ["Warsong Veteran"] = "Veterano do Brado Guerreiro",
    ["Warsong Supply Officer"] = "Oficial de Suprimentos do Brado Guerreiro",
    ["Warsong Supply Officer (Honored)"] = "Oficial de Suprimentos do Brado Guerreiro (Honrado)",
    ["Silverwing Supply Officer"] = "Oficial de Suprimentos da Asa de Prata",
    -- Project Ascension / Conquest of Azeroth (AscensionDB)
    ["Subject Zero"] = "Sujeito Zero",
    ["Reaper of Souls"] = "Ceifador de Almas",
    ["Cult of the Damned"] = "Culto dos Malditos",
    ["Boss"] = "Chefe",
    ["Runemaster"] = "Mestre das Runas",
    ["Glyphic Runemaster"] = "Mestre das Runas Glífico",
    ["Runemaster Mystic Scrolls"] = "Pergaminhos Místicos de Mestre das Runas",
    ["Runemaster Adept"] = "Adepto das Runas",
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
    -- Classes custom do Conquest of Azeroth. Usadas em títulos como
    -- <Necromancer Trainer>, <Tinker Trainer>, <Sun Cleric Trainer>, etc.
    ["Barbarian"] = "Bárbaros",
    ["Bloodmage"] = "Magos Sangrentos",
    ["Blood Mage"] = "Magos Sangrentos",
    ["Chronomancer"] = "Cronomantes",
    ["Cultist"] = "Cultistas",
    ["Felsworn"] = "Juramentados Vis",
    ["Guardian"] = "Guardiões",
    ["Knight of Xoroth"] = "Cavaleiros de Xoroth",
    ["Necromancer"] = "Necromantes",
    ["Primalist"] = "Primalistas",
    ["Pyromancer"] = "Piromantes",
    ["Ranger"] = "Patrulheiros",
    ["Reaper"] = "Ceifadores",
    ["Runemaster"] = "Mestres das Runas",
    ["Starcaller"] = "Invocadores Estelares",
    ["Stormbringer"] = "Portadores da Tempestade",
    ["Sun Cleric"] = "Clérigos Solares",
    ["SunCleric"] = "Clérigos Solares",
    ["Templar"] = "Templários",
    ["Tinker"] = "Inventores",
    ["Venomancer"] = "Venomantes",
    ["Witch Doctor"] = "Médicos Bruxos",
    ["Witch Hunter"] = "Caçadores de Bruxas",
    ["WitchHunter"] = "Caçadores de Bruxas",
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
            local id = tonumber(hex:sub(5, 8), 16)
            if id and id > 0 then return id end
        end
    end
end

local NPC_NAME_PREFIX = {
    ["Auctioneer "] = "Leiloeiro ",
    ["Innkeeper "] = "Estalajadeiro ",
    ["Banker "] = "Banqueiro ",
    ["Quartermaster "] = "Intendente ",
    ["Flight Master "] = "Mestre de Voo ",
    ["Stable Master "] = "Mestre de Estábulos ",
}

-- Nomes custom confirmados no AscensionDB que não fazem parte da base 3.3.5.
-- Nomes próprios permanecem intactos; apenas nomes genéricos/descritores são localizados.
local ASCENSION_NPC_NAME_EXACT = {
    ["Fashionable Necromancer"] = "Necromante Elegante",
    ["Necromancer Adept"] = "Adepto Necromante",
    ["Frostmane Reaper"] = "Ceifador Jubafria",
    ["Blighthollow Necromancer"] = "Necromante de Blighthollow",
    ["Scourge Necromancer"] = "Necromante da Praga",
    ["Thuzadin Necromancer"] = "Necromante Thuzadin",
}

local ASCENSION_DIFFICULTY_SUFFIX = {
    ["Mythic"] = "Mítico",
    ["Ascended"] = "Ascendido",
    ["Heroic"] = "Heroico",
}

local function TranslateAscensionNpcName(name)
    if type(name) ~= "string" or name == "" then return nil end

    local exact = ASCENSION_NPC_NAME_EXACT[name]
    if exact and exact ~= name then return exact end

    -- O AscensionDB possui milhares de cópias de criaturas com sufixos de modo,
    -- por exemplo "Nefarian - Mythic" e "Vem - Ascended". Traduzimos o sufixo
    -- sem exigir um cadastro manual de cada ID e reaproveitamos o nome ptBR base.
    local base, mode = name:match("^(.-)%s*%-%s*([%a%+]+)%s*$")
    local modePT = mode and ASCENSION_DIFFICULTY_SUFFIX[mode]
    if base and modePT then
        base = Trim(base) or base
        local basePT = ASCENSION_NPC_NAME_EXACT[base]
            or (AES.UnitNameEN2ES and AES.UnitNameEN2ES[base])
            or (AES.UnitNamePreferredEN2PT and AES.UnitNamePreferredEN2PT[base])
            or base
        return basePT .. " - " .. modePT
    end
end

AES.TranslateAscensionNpcName = TranslateAscensionNpcName

local function TranslateNpcNamePattern(name)
    if type(name) ~= "string" or name == "" then return nil end
    for prefix, ptPrefix in pairs(NPC_NAME_PREFIX) do
        if name:sub(1, #prefix) == prefix and #name > #prefix then
            return ptPrefix .. name:sub(#prefix + 1)
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

    if not ptName then
        ptName = TranslateAscensionNpcName(enName)
    end

    if not ptName then
        ptName = TranslateNpcNamePattern(enName)
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
    -- O Core ignora tooltips internos. Sem esta marca, o scanner de função de
    -- NPC pode receber os hooks pesados de tooltip e travar a câmera em cidades.
    scanner.__aptbrPrivateScanner = true
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
    RememberRoleScanAttempt(cacheKey, tries + 1)

    local raw = ScanSubtitle(unit)
    if not raw then return nil end

    local translated = AES.TranslateNpcRoleText and AES.TranslateNpcRoleText(raw)
    if translated then
        translated = translated:match("^<(.-)>$") or translated
    elseif AES.UnitSubEN2PT then
        translated = AES.UnitSubEN2PT[raw]
    end

    if translated and translated ~= "" and translated ~= raw then
        if npcID then CacheRoleByID(npcID, translated) end
        if guid then CacheRoleByGUID(guid, translated) end
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
    if npcID then CacheRoleByID(npcID, translated) end
    if guid then CacheRoleByGUID(guid, translated) end
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
    -- Core.lua possui um tradutor genérico de FontStrings. Marcar a nameplate aqui
    -- impede que os dois módulos processem o mesmo SetText quando a câmera gira
    -- ou quando uma placa é reciclada para outro jogador/NPC.
    fs.__aptbrWorldName = true
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

local function BuildSafeFriendlyOptions(unitFrame, isPlayerUnit)
    local source = unitFrame and unitFrame.optionTable
        or _G.DefaultCompactNamePlateFriendlyFrameOptions
        or {}
    local options = safeOptionsByFrame[unitFrame]
    if not options then
        options = {}
        safeOptionsByFrame[unitFrame] = options
    else
        for key in pairs(options) do options[key] = nil end
    end
    for key, value in pairs(source) do options[key] = value end

    -- O CompactUnitFrame do Ascension tenta calcular ameaça até em placa amigável.
    -- Para os frames sociais que forçamos como âncora isso não faz sentido e pode
    -- gerar UnitDetailedThreatSituation("player", "nameplateXX").
    options.displayAggroHighlight = false
    options.playLoseAggroHighlight = false
    options.considerSelectionInCombatAsHostile = false
    options.tankNoThreatBorderColor = nil
    options.tankNoThreatTargetBorderColor = nil
    options.tankThreatBorderColor = nil
    options.tankThreatTargetBorderColor = nil
    options.hoverBorderColor = nil
    options.selectedBorderColor = nil
    options.defaultBorderColor = nil
    options.displayHealPrediction = false
    options.displayPowerBar = false
    options.displayStatusText = false
    options.hideCastbar = true
    options.showClassificationIndicator = false
    options.showPlayerLevel = false
    options.showNPCLevel = false
    options.showQuestObjectives = not isPlayerUnit
    -- O marcador de missao 3D do proprio cliente ja existe sobre o NPC.
    -- Deixar o CompactUnitFrame exibir outro icone gera dois "!" sobrepostos.
    options.showQuestNPCIcons = false
    options.showQuestIcons = false
    return options
end

local function HideObject(object)
    if object and object.Hide then pcall(object.Hide, object) end
end

local function ApplySafeFriendlyFrame(unitFrame, unit)
    if not unitFrame or not IsFriendly(unit) then return end
    local options = BuildSafeFriendlyOptions(unitFrame, IsPlayer(unit))
    -- Não chamamos SetUpFrame aqui. O Ascension já montou o frame; só trocamos
    -- a tabela usada pelos eventos seguintes para uma versão sem lógica de ameaça.
    unitFrame.optionTable = options

    HideObject(unitFrame.healthBar)
    HideObject(unitFrame.powerBar)
    HideObject(unitFrame.castBar)
    HideObject(unitFrame.BuffFrame)
    HideObject(unitFrame.ClassificationFrame)
    HideObject(unitFrame.LevelFrame)
    HideObject(unitFrame.aggroHighlight)
    HideObject(unitFrame.selectionHighlight)
    -- Nunca usamos o icone de quest da nameplate amigavel. O jogo ja desenha
    -- o marcador 3D nativo dos NPCs, e manter os dois causa duplicacao.
    HideObject(unitFrame.questIcon)
end

local function GetPlayerClassColor(unit)
    local _, class = UnitClass and UnitClass(unit)
    local color = class and RAID_CLASS_COLORS and RAID_CLASS_COLORS[class]
    if color then return color.r or 0.67, color.g or 0.67, color.b or 1 end
    return 0.67, 0.67, 1
end

local function EnsureAllyStyle(unitFrame)
    local style = allyStyleByFrame[unitFrame]
    if style then return style end
    if not (unitFrame and unitFrame.CreateFontString) then return nil end

    style = {}
    allyStyleByFrame[unitFrame] = style

    style.name = unitFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    style.guild = unitFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    style.name.__aptbrWorldName = true
    style.guild.__aptbrWorldName = true

    if style.name.SetFont then pcall(style.name.SetFont, style.name, "Fonts\\FRIZQT__.TTF", 12, "OUTLINE") end
    if style.guild.SetFont then pcall(style.guild.SetFont, style.guild, "Fonts\\FRIZQT__.TTF", 10, "OUTLINE") end

    style.name:SetPoint("BOTTOM", unitFrame, "CENTER", 0, 9)
    style.guild:SetPoint("TOP", style.name, "BOTTOM", 0, -1)
    style.name:SetJustifyH("CENTER")
    style.guild:SetJustifyH("CENTER")
    style.name:SetWidth(220)
    style.guild:SetWidth(220)
    style.guild:SetTextColor(0.72, 0.82, 0.92, 1)
    return style
end

local function HideAllyStyle(unitFrame)
    local style = unitFrame and allyStyleByFrame[unitFrame]
    if not style then return end
    HideObject(style.name)
    HideObject(style.guild)
end

local function UpdateAllyStyle(unitFrame, unit)
    if not (unitFrame and unit and IsPlayer(unit) and IsFriendly(unit)) then
        HideAllyStyle(unitFrame)
        return false
    end
    local style = EnsureAllyStyle(unitFrame)
    if not style then return false end

    local name = UnitName and UnitName(unit) or ""
    local guild = GetGuildInfo and GetGuildInfo(unit)
    local r, g, b = GetPlayerClassColor(unit)

    style.name:SetText(name)
    style.name:SetTextColor(r, g, b, 1)
    style.name:Show()

    if type(guild) == "string" and guild ~= "" then
        style.guild:SetText("<" .. guild .. ">")
        style.guild:Show()
    else
        style.guild:SetText("")
        style.guild:Hide()
    end


    local defaultName = unitFrame.name or unitFrame.Name or unitFrame.nameText
    if defaultName then defaultName.__aptbrWorldName = true end
    HideObject(defaultName)
    return true
end

local function HideRole(frame)
    local role = frame and roleTextByFrame[frame]
    if role and role.Hide then pcall(role.Hide, role) end
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
        if role then
            role.__aptbrWorldName = true
            roleTextByFrame[container] = role
        end
    end
    if not role then return false end
    role.__aptbrWorldName = true

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
    plate.__aptbrNameplateRoot = true
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

    plate.__aptbrNameplateRoot = true
    plate.__aptbrUnit = unit
    HookPlateLifecycle(plate)

    local unitFrame = plate.UnitFrame
    local applied = false
    if unitFrame then
        unitFrame.__aptbrNameplateRoot = true
        unitFrame.__aptbrUnit = unit
        HookUnitFrameLifecycle(unitFrame, plate)

        if IsFriendly(unit) then
            ApplySafeFriendlyFrame(unitFrame, unit)
        end

        if IsPlayer(unit) or (UnitPlayerControlled and UnitPlayerControlled(unit)) then
            HideRole(unitFrame)
            applied = UpdateAllyStyle(unitFrame, unit) or applied
            applyingPlates[plate] = nil
            return applied
        end

        HideAllyStyle(unitFrame)

        local enName = UnitName and UnitName(unit)
        local ptName = ResolveName(unit)
        local nameFS = unitFrame.name or unitFrame.Name or unitFrame.nameText
        if not nameFS and type(enName) == "string" and enName ~= "" then
            nameFS = FindExactNameFontString(unitFrame, enName, ptName, 0)
                or FindExactNameFontString(plate, enName, ptName, 0)
        end

        if nameFS then
            if nameFS.Show then pcall(nameFS.Show, nameFS) end
            applied = HookNameFontString(nameFS, unit) or applied
        end

        if IsRoleNPC(unit) and nameFS then
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

-- NPC traduzido e placa social dos aliados usam as placas amigáveis nativas como
-- âncora 3D. Em vez de esconder jogadores, damos a eles um visual próprio, simples,
-- com nome e guilda. Inimigos continuam separados.
--
-- No Ascension, NAMEPLATES também escreve nameplateShowFriends=0. Quando usamos o
-- modo social nativo, interceptamos SOMENTE a ação NAMEPLATES (V) e fazemos ela
-- alternar apenas nameplateShowEnemies. O binding
-- salvo do jogador não é alterado e o override some quando um addon externo de
-- nameplates é detectado ou quando a tradução é desativada.

local EXTERNAL_NAMEPLATE_ADDONS = {
    "ElvUI", "Kui_Nameplates", "Kui_Nameplates_Core", "KuiNameplates",
    "Plater", "Plater_Nameplates", "TidyPlates", "NeatPlates",
    "ThreatPlates", "TidyPlates_ThreatPlates",
}

local function IsAddonLoadedSafe(name)
    if not IsAddOnLoaded then return false end
    local ok, loaded = pcall(IsAddOnLoaded, name)
    return ok and loaded and true or false
end

local function ExternalNameplateAddon()
    for _, name in ipairs(EXTERNAL_NAMEPLATE_ADDONS) do
        if IsAddonLoadedSafe(name) then return name end
    end
end

local savedFriendlyOptionValues
local NIL_OPTION = {}
local function PatchGlobalFriendlyOptions()
    local options = _G.DefaultCompactNamePlateFriendlyFrameOptions
    if type(options) ~= "table" then return false end
    if not savedFriendlyOptionValues then
        savedFriendlyOptionValues = {}
        for _, key in ipairs({
            "displayAggroHighlight", "playLoseAggroHighlight",
            "considerSelectionInCombatAsHostile", "tankNoThreatBorderColor",
            "tankNoThreatTargetBorderColor", "tankThreatBorderColor",
            "tankThreatTargetBorderColor",
        }) do
            local value = options[key]
            savedFriendlyOptionValues[key] = value == nil and NIL_OPTION or value
        end
    end
    options.displayAggroHighlight = false
    options.playLoseAggroHighlight = false
    options.considerSelectionInCombatAsHostile = false
    options.tankNoThreatBorderColor = nil
    options.tankNoThreatTargetBorderColor = nil
    options.tankThreatBorderColor = nil
    options.tankThreatTargetBorderColor = nil
    return true
end

local function RestoreGlobalFriendlyOptions()
    local options = _G.DefaultCompactNamePlateFriendlyFrameOptions
    if type(options) ~= "table" or not savedFriendlyOptionValues then return end
    for key, value in pairs(savedFriendlyOptionValues) do
        options[key] = value == NIL_OPTION and nil or value
    end
end

-- Sanitiza antes do PLAYER_ENTERING_WORLD. Assim, se o usuário já deixou placas
-- amigáveis ligadas na sessão anterior, o CompactUnitFrame não entra na rotina de
-- ameaça inválida antes de o nosso primeiro evento rodar.
if Enabled() and not ExternalNameplateAddon() then PatchGlobalFriendlyOptions() end

local SOCIAL_CVARS = {
    { "nameplateShowFriends", "1", "_aptbrSocialFriendsBeforeV12" },
    { "nameplateShowFriendlyNPCs", "1", "_aptbrSocialNpcsBeforeV12" },
    { "nameplateShowFriendlyPlayers", "1", "_aptbrSocialPlayersBeforeV12" },
    { "nameplateShowFriendlyPets", "0", "_aptbrSocialPetsBeforeV12" },
    { "nameplateShowFriendlyMinions", "0", "_aptbrSocialMinionsBeforeV12" },
    { "nameplateShowFriendlyGuardians", "0", "_aptbrSocialGuardiansBeforeV12" },
    { "nameplateShowFriendlyTotems", "0", "_aptbrSocialTotemsBeforeV12" },
}

local bindingOwner = CreateFrame("Frame")
local toggleButton = CreateFrame("Button", "AscensionPTBRToggleCombatNameplates", UIParent)
local bindingKeys = {}
local plateBindingsPending = false

if toggleButton then
    if toggleButton.SetSize then pcall(toggleButton.SetSize, toggleButton, 1, 1) end
    if toggleButton.SetPoint then pcall(toggleButton.SetPoint, toggleButton, "TOPLEFT", UIParent, "BOTTOMLEFT", -100, -100) end
    if toggleButton.SetAlpha then pcall(toggleButton.SetAlpha, toggleButton, 0) end
    if toggleButton.EnableMouse then pcall(toggleButton.EnableMouse, toggleButton, false) end
    if toggleButton.RegisterForClicks then pcall(toggleButton.RegisterForClicks, toggleButton, "AnyUp") end
end

local function BoolCVar(value)
    value = tostring(value or "")
    return value == "1" or value == "true" or value == "TRUE"
end

local function ToggleCombatNameplates()
    local current = GetCVarValue("nameplateShowEnemies")
    if current == nil then return end
    SetCVarValue("nameplateShowEnemies", BoolCVar(current) and "0" or "1")
end

if toggleButton and toggleButton.SetScript then
    toggleButton:SetScript("OnClick", ToggleCombatNameplates)
end

local function ClearPlateBindingOverrides()
    if InCombatLockdown and InCombatLockdown() then
        plateBindingsPending = true
        AES.Diagnostics.protectedDeferrals = (AES.Diagnostics.protectedDeferrals or 0) + 1
        AES.Diagnostics.lastProtectedDeferral = "ClearOverrideBindings/nameplates"
        return false
    end
    AES.Diagnostics.lastProtectedAction = "ClearOverrideBindings/nameplates"
    if bindingOwner and ClearOverrideBindings then pcall(ClearOverrideBindings, bindingOwner) end
    for k in pairs(bindingKeys) do bindingKeys[k] = nil end
    plateBindingsPending = false
    return true
end

local function AddBindingKeysForAction(action)
    if not GetBindingKey then return end
    local ok, k1, k2 = pcall(GetBindingKey, action)
    if not ok then return end
    if k1 and k1 ~= "" then bindingKeys[k1] = true end
    if k2 and k2 ~= "" then bindingKeys[k2] = true end
end

local function ApplyPlateBindingOverrides()
    if InCombatLockdown and InCombatLockdown() then
        plateBindingsPending = true
        AES.Diagnostics.protectedDeferrals = (AES.Diagnostics.protectedDeferrals or 0) + 1
        AES.Diagnostics.lastProtectedDeferral = "SetOverrideBindingClick/nameplates"
        return false
    end
    ClearPlateBindingOverrides()
    if not (Enabled() and not ExternalNameplateAddon()) then return false end
    if not (SetOverrideBindingClick and toggleButton) then return false end

    AddBindingKeysForAction("NAMEPLATES")
    for key in pairs(bindingKeys) do
        AES.Diagnostics.lastProtectedAction = "SetOverrideBindingClick/nameplates:" .. tostring(key)
        pcall(SetOverrideBindingClick, bindingOwner, false, key, "AscensionPTBRToggleCombatNameplates")
    end
    plateBindingsPending = false
    return next(bindingKeys) ~= nil
end

function AES.GetWorldNameDiagnostics()
    local plateCount = 0
    for _ in pairs(knownPlates) do plateCount = plateCount + 1 end
    return {
        plates = plateCount,
        roleIDs = roleCacheByIDCount,
        roleGUIDs = roleCacheByGUIDCount,
        pendingBinding = plateBindingsPending and true or false,
    }
end

local function RestoreSocialCVars()
    local db = DB()
    if not db then return end
    for _, info in ipairs(SOCIAL_CVARS) do
        if db[info[3]] ~= nil then
            SetCVarValue(info[1], db[info[3]])
            db[info[3]] = nil
        end
    end
end

local function CleanupOldNameplateOverrides()
    local db = DB()
    if not db or db._aptbrSocialMigrationV12 then return end

    local old = {
        { "nameplateShowFriends", "_aptbrNpcAnchorFriendsBeforeV10" },
        { "nameplateShowFriends", "_aptbrFriendlyMasterBeforeV2" },
        { "nameplateShowFriends", "_aptbrFriendlyMasterBefore" },
        { "nameplateShowFriendlyNPCs", "_aptbrNpcAnchorNpcsBeforeV10" },
        { "nameplateShowFriendlyNPCs", "_aptbrFriendlyNpcCVarBeforeV2" },
        { "nameplateShowFriendlyNPCs", "_aptbrFriendlyNpcCVarBefore" },
        { "nameplateShowFriendlyNPCs", "_friendlyNpcNamesBeforePTBR" },
        { "nameplateShowFriendlyPlayers", "_aptbrNpcAnchorPlayersBeforeV10" },
        { "nameplateShowFriendlyPets", "_aptbrNpcAnchorPetsBeforeV10" },
        { "nameplateShowFriendlyMinions", "_aptbrNpcAnchorMinionsBeforeV10" },
        { "nameplateShowFriendlyGuardians", "_aptbrNpcAnchorGuardiansBeforeV10" },
        { "nameplateShowFriendlyTotems", "_aptbrNpcAnchorTotemsBeforeV10" },
        { "UnitNameFriendlyPlayerName", "_aptbrFriendlyPlayerWorldNameBeforeV10" },
        { "nameplateShowFriendlyNPCs", "_aptbrFriendlyNpcOnlyBeforeV11" },
    }

    for _, info in ipairs(old) do
        if db[info[2]] ~= nil then
            SetCVarValue(info[1], db[info[2]])
            db[info[2]] = nil
        end
    end
    db._aptbrForcedFriendlyMaster = nil
    db._aptbrSocialMigrationV12 = true
end

local function EnsureSocialPlates()
    local db = DB()
    if not db then return false end
    CleanupOldNameplateOverrides()

    if not Enabled() or ExternalNameplateAddon() then
        RestoreSocialCVars()
        RestoreGlobalFriendlyOptions()
        ClearPlateBindingOverrides()
        return false
    end

    PatchGlobalFriendlyOptions()
    for _, info in ipairs(SOCIAL_CVARS) do
        local current = GetCVarValue(info[1])
        if current ~= nil then
            if db[info[3]] == nil then db[info[3]] = current end
            if tostring(current) ~= tostring(info[2]) then SetCVarValue(info[1], info[2]) end
        end
    end
    ApplyPlateBindingOverrides()
    return true
end

local function QueueRefresh()
    if shuttingDown or not Enabled() then return end
    if AES.Runtime then
        AES.Runtime.Repeat("world-names-rebuild", 0.03, 0.12, 5, function()
            EnsureSocialPlates()
            ApplyToActivePlates()
        end)
    else
        EnsureSocialPlates()
        ApplyToActivePlates()
    end
end

AES.ApplyWorldNpcNameplates = function()
    CleanupOldNameplateOverrides()
    EnsureSocialPlates()
    if Enabled() then
        ApplyToActivePlates()
        QueueRefresh()
    end
    return (C_NamePlateManager ~= nil or C_NamePlate ~= nil)
end

local events = CreateFrame("Frame")
pcall(events.RegisterEvent, events, "NAME_PLATE_UNIT_ADDED")
pcall(events.RegisterEvent, events, "NAME_PLATE_UNIT_REMOVED")
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:RegisterEvent("PLAYER_TARGET_CHANGED")
events:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
events:RegisterEvent("PLAYER_LOGOUT")
pcall(events.RegisterEvent, events, "UPDATE_BINDINGS")
pcall(events.RegisterEvent, events, "PLAYER_REGEN_ENABLED")

-- Se outro addon de nameplates entrar depois, devolvemos CVars/opções e passamos
-- para modo passivo para não disputar layout nem atalhos com ElvUI/Kui/Plater/etc.
pcall(events.RegisterEvent, events, "ADDON_LOADED")

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
    elseif event == "UPDATE_BINDINGS" then
        ApplyPlateBindingOverrides()
    elseif event == "PLAYER_REGEN_ENABLED" then
        if plateBindingsPending then ApplyPlateBindingOverrides() end
    elseif event == "ADDON_LOADED" then
        if ExternalNameplateAddon() then
            RestoreSocialCVars()
            RestoreGlobalFriendlyOptions()
            ClearPlateBindingOverrides()
        else
            EnsureSocialPlates()
        end
    elseif event == "PLAYER_LOGOUT" then
        shuttingDown = true
        RestoreSocialCVars()
        RestoreGlobalFriendlyOptions()
        ClearPlateBindingOverrides()
    elseif event == "PLAYER_ENTERING_WORLD" then
        -- GUIDs mudam entre zonas/instâncias e não precisam sobreviver à transição.
        -- Limpar aqui impede crescimento contínuo em sessões longas sem perder o cache por NPC ID.
        ResetTransientRoleCaches()
        CleanupOldNameplateOverrides()
        EnsureSocialPlates()
        if AES.Runtime then
            AES.Runtime.After("world-names-enter", 0.12, function()
                if Enabled() then ApplyToActivePlates() end
            end)
        else
            ApplyToActivePlates()
        end
    end
end)

-- O Ascension cria a UnitFrame quando a placa entra no gerenciador. Não chamamos
-- SetUpFrame: apenas neutralizamos lógica de ameaça em placas amigáveis, traduzimos
-- NPCs e desenhamos o overlay social dos jogadores aliados.
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

SLASH_APTBRPLATES1 = "/aptbrplates"
SlashCmdList["APTBRPLATES"] = function()
    local friends = GetCVarValue("nameplateShowFriends") or "<n/a>"
    local npcs = GetCVarValue("nameplateShowFriendlyNPCs") or "<n/a>"
    local enemies = GetCVarValue("nameplateShowEnemies") or "<n/a>"
    local players = GetCVarValue("nameplateShowFriendlyPlayers") or "<n/a>"
    local guild = GetCVarValue("UnitNamePlayerGuild") or "<n/a>"
    local external = ExternalNameplateAddon() or "nenhum"
    local override = next(bindingKeys) and "sim" or "não"
    DEFAULT_CHAT_FRAME:AddMessage(string.format(
        "|cff33ff99AscensionPTBR|r: friends=%s NPC=%s aliados=%s enemies=%s guild=%s override=%s addonPlacas=%s",
        tostring(friends), tostring(npcs), tostring(players), tostring(enemies), tostring(guild), tostring(override), tostring(external)))
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
