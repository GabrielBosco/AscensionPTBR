-- Perfil do personagem e abas do C.
-- Este modulo trabalha apenas com raizes conhecidas da interface e nunca entra
-- em WorldFrame/nameplates nem enumera todos os frames do cliente.

local A = AscensionPTBR or {}
AscensionPTBR = A

local hookedFS = setmetatable({}, { __mode = "k" })
local textGuard = setmetatable({}, { __mode = "k" })
local lastTarget = setmetatable({}, { __mode = "k" })
local hookedRoots = setmetatable({}, { __mode = "k" })
local installed = {}
local knownRoots = setmetatable({}, { __mode = "k" })
local lastStats = { roots = 0, nodes = 0, texts = 0 }

local ROOT_NAMES = {
    "CharacterFrame", "PaperDollFrame", "PetPaperDollFrame", "ReputationFrame",
    "SkillFrame", "TokenFrame", "CurrencyFrame", "TradeSkillFrame", "CraftFrame",
    "AscensionCharacterFrame", "AscensionCharacterStatsPanel", "AscensionPaperDollPanel",
    "AllStatsFrame", "CompanionFrame", "MountJournal", "MountCollectionFrame",
    "CollectionsFrame", "VanityCollectionFrame", "WardrobeFrame", "BookOfAscensionFrame",
    "BookOfArtisansFrame", "ItemTextFrame", "CharacterAdvancementFrame",
}

local ROOT_SET = {}
for i = 1, #ROOT_NAMES do ROOT_SET[ROOT_NAMES[i]] = true end

local CHARACTER_GLOBALS = {
    CHARACTER = "Personagem",
    CHARACTER_INFO = "Informações do Personagem",
    PETS = "Mascotes",
    PET = "Mascote",
    COMPANIONS = "Companheiros",
    MOUNTS = "Montarias",
    REPUTATION = "Reputação",
    SKILLS = "Perícias",
    SKILL = "Perícia",
    PROFESSIONS = "Profissões",
    PROFESSION = "Profissão",
    CURRENCY = "Moedas",
    CURRENCIES = "Moedas",
    FACTION = "Facção",
    STANDING = "Nível de reputação",
    AT_WAR = "Em guerra",
    INACTIVE = "Inativo",
    CLASS_SKILLS = "Perícias de Classe",
    WEAPON_SKILLS = "Perícias com Armas",
    SECONDARY_SKILLS = "Perícias Secundarias",
    SEARCH = "Pesquisar",
    FILTER = "Filtrar",
    SUMMON = "Invocar",
    DISMISS = "Dispensar",
    CLOSE = "Fechar",
    LEARN = "Aprender",
    UNLEARN = "Desaprender",
    CREATE = "Criar",
    CREATE_ALL = "Criar todos",
    REAGENTS = "Reagentes",
}

local function Enabled()
    if A.IsFeatureEnabled then return A.IsFeatureEnabled("characterUI", true) end
    local db = AscensionPTBRDB
    return not (db and db.characterUI == false)
end

local function GetName(frame)
    if not (frame and frame.GetName) then return nil end
    local ok, name = pcall(frame.GetName, frame)
    return ok and name or nil
end

local function ParentOf(frame)
    if not (frame and frame.GetParent) then return nil end
    local ok, parent = pcall(frame.GetParent, frame)
    return ok and parent or nil
end

local function IsWorldContent(frame)
    if not frame then return false end
    if A.IsNameplateObject then
        local ok, result = pcall(A.IsNameplateObject, frame)
        if ok and result then return true end
    end

    local current = frame
    for _ = 1, 18 do
        if not current then break end
        if current == WorldFrame or current.__aptbrWorldName or current.__aptbrNameplateRoot then
            return true
        end
        local name = GetName(current)
        if type(name) == "string" then
            local lower = name:lower()
            if lower:find("nameplate", 1, true) or lower:find("compactunitframe", 1, true) then
                return true
            end
        end
        current = ParentOf(current)
    end
    return false
end

-- Os botões de equipamento do PaperDoll possuem FontStrings internos com o
-- nome completo do item. Eles não fazem parte da lista de status e, quando
-- traduzidos, podem ultrapassar o tamanho do slot e aparecer sobre os atributos.
-- Conferimos toda a cadeia de pais para cobrir texturas/regiões sem nome.
local function IsEquipmentSlotObject(frame)
    local current = frame
    for _ = 1, 14 do
        if not current then break end
        local name = GetName(current)
        if type(name) == "string" and (name:match("^Character.+Slot$")
            or name:match("^Inspect.+Slot$")
            or name:match("^PaperDoll.+Slot$")
            or name:match("^AscensionCharacter.+Slot$")
            or name:find("EquipmentSlot", 1, true)) then
            return true
        end
        current = ParentOf(current)
    end
    return false
end

local function FrameSafe(frame)
    if not frame or IsWorldContent(frame) or IsEquipmentSlotObject(frame) then return false end
    if frame.IsForbidden then
        local ok, forbidden = pcall(frame.IsForbidden, frame)
        if ok and forbidden then return false end
    end
    return true
end

local function IsVisible(frame)
    if not frame then return false end
    if frame.IsVisible then
        local ok, visible = pcall(frame.IsVisible, frame)
        if ok then return visible and true or false end
    end
    if frame.IsShown then
        local ok, shown = pcall(frame.IsShown, frame)
        if ok then return shown and true or false end
    end
    return false
end

local function ApplyCharacterGlobals()
    if not Enabled() then return end
    for key, pt in pairs(CHARACTER_GLOBALS) do
        if type(_G[key]) == "string" then
            if A.SafeSetGlobalString then A.SafeSetGlobalString(key, pt) end
        end
    end
end

local function TranslateDirectCore(text)
    if type(text) ~= "string" or text == "" then return nil end

    if A.TranslateCharacterPanelLine then
        local ok, value = pcall(A.TranslateCharacterPanelLine, text)
        if ok and type(value) == "string" and value ~= "" and value ~= text then return value end
    end

    if A.TranslateCharacterStatLine then
        local ok, value = pcall(A.TranslateCharacterStatLine, text)
        if ok and type(value) == "string" and value ~= "" and value ~= text then return value end
    end
end

local function TranslateDirect(text)
    if type(text) ~= "string" or text == "" then return nil end
    local direct = TranslateDirectCore(text)
    if direct then return direct end

    local lead, core, trail = text:match("^(%s*)(.-)(%s*)$")
    core = core or text
    local color, inner, reset = core:match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)$")
    local raw = inner or core
    if raw ~= text then
        local pt = TranslateDirectCore(raw)
        if pt then
            return (lead or "") .. (color or "") .. pt .. (reset or "") .. (trail or "")
        end
    end
end

local function TranslateText(text)
    if type(text) ~= "string" or text == "" then return nil end

    local pt = TranslateDirect(text)
    if pt then return pt end

    -- Não há fallback genérico aqui: o C aceita somente CharacterPanel e
    -- CharacterStats. Itens, feitiços, missões, NPCs e chat ficam nos módulos
    -- próprios e nunca conseguem contaminar uma linha de atributo.

    if text:find("\n", 1, true) or text:find("|n", 1, true) then
        local out, pos, changed = {}, 1, false
        while pos <= #text do
            local a1, b1 = text:find("\n", pos, true)
            local a2, b2 = text:find("|n", pos, true)
            local a, b, sep
            if a1 and (not a2 or a1 < a2) then
                a, b, sep = a1, b1, "\n"
            elseif a2 then
                a, b, sep = a2, b2, "|n"
            end
            local line = a and text:sub(pos, a - 1) or text:sub(pos)
            local linePT = TranslateDirect(line)
            if linePT and linePT ~= line then
                line = linePT
                changed = true
            end
            out[#out + 1] = line
            if not a then break end
            out[#out + 1] = sep
            pos = b + 1
        end
        if changed then return table.concat(out) end
    end
end
A.TranslateCharacterUIText = TranslateText

local function ApplyFontString(fs)
    if not Enabled() or not FrameSafe(fs) or textGuard[fs]
        or not (fs.GetText and fs.SetText) then return false end

    local ok, text = pcall(fs.GetText, fs)
    if not ok or type(text) ~= "string" or text == "" then return false end

    if lastTarget[fs] == text then return false end
    lastTarget[fs] = nil

    local pt = TranslateText(text)
    if not pt or pt == text then return false end

    textGuard[fs] = true
    lastTarget[fs] = pt
    local written = pcall(fs.SetText, fs, pt)
    if not written then lastTarget[fs] = nil end
    textGuard[fs] = nil
    return written
end

local function HookFontString(fs)
    if not (fs and fs.GetText and fs.SetText) or not FrameSafe(fs) then return false end

    -- Nao instale hook em todo FontString do C. Primeiro tenta traduzir;
    -- so textos que realmente precisaram de traducao ganham hook persistente.
    -- Isso corta centenas de hooksecurefunc na primeira abertura do painel.
    local changed = ApplyFontString(fs)
    if not changed or hookedFS[fs] or not hooksecurefunc then return changed end

    hookedFS[fs] = true
    pcall(hooksecurefunc, fs, "SetText", function(self)
        ApplyFontString(self)
    end)
    if fs.SetFormattedText then
        pcall(hooksecurefunc, fs, "SetFormattedText", function(self)
            ApplyFontString(self)
        end)
    end
    return changed
end

local After

-- O C do Ascension pode ter milhares de objetos. Fazer a arvore inteira dentro
-- do OnShow causa hitch mesmo sem EnumerateFrames. Processamos em fatias curtas
-- nos ticks seguintes: o custo total e parecido, mas nao bloqueia um frame inteiro.
local walkJobs = setmetatable({}, { __mode = "k" })
local WALK_NODE_LIMIT = 5200
local WALK_SLICE_NODES = 72
local WALK_SLICE_MS = 1.20

local ProcessWalkJob

local function ScheduleWalkJob(job, delay)
    if not job or not job.root then return end
    local key = "aptbr-character-walk:" .. tostring(job.root)
    After(key, delay or 0.01, function()
        if walkJobs[job.root] == job then ProcessWalkJob(job) end
    end)
end

ProcessWalkJob = function(job)
    local root = job and job.root
    if not root or walkJobs[root] ~= job then return end
    if not Enabled() or not IsVisible(root) or not FrameSafe(root) then
        walkJobs[root] = nil
        return
    end

    local processed = 0
    local started = debugprofilestop and debugprofilestop() or nil

    while job.queue[job.head] and job.nodes < job.limit and processed < WALK_SLICE_NODES do
        local frame = job.queue[job.head]
        job.head = job.head + 1
        processed = processed + 1

        if frame and not job.seen[frame] and FrameSafe(frame) then
            job.seen[frame] = true
            job.nodes = job.nodes + 1

            if frame.GetRegions then
                local ok, regions = pcall(function() return { frame:GetRegions() } end)
                if ok and regions then
                    for i = 1, #regions do
                        local region = regions[i]
                        if region and region.IsObjectType then
                            local okFS, isFS = pcall(region.IsObjectType, region, "FontString")
                            if okFS and isFS and FrameSafe(region) then
                                HookFontString(region)
                                job.texts = job.texts + 1
                            end
                        end
                    end
                end
            end

            if frame.GetChildren then
                local ok, children = pcall(function() return { frame:GetChildren() } end)
                if ok and children then
                    for i = 1, #children do
                        local child = children[i]
                        if child and not job.seen[child] and FrameSafe(child) then
                            job.queue[#job.queue + 1] = child
                        end
                    end
                end
            end
        end

        if started and debugprofilestop and (debugprofilestop() - started) >= WALK_SLICE_MS then
            break
        end
    end

    if job.queue[job.head] and job.nodes < job.limit then
        ScheduleWalkJob(job, 0.01)
        return
    end

    lastStats.nodes = (lastStats.nodes or 0) + job.nodes
    lastStats.texts = (lastStats.texts or 0) + job.texts
    lastStats.pending = math.max(0, (lastStats.pending or 1) - 1)
    walkJobs[root] = nil
end

local function QueueWalk(root, maxNodes)
    if not Enabled() or not IsVisible(root) or not FrameSafe(root) then return false end
    if walkJobs[root] then return true end

    local job = {
        root = root,
        queue = { root },
        head = 1,
        nodes = 0,
        texts = 0,
        seen = setmetatable({}, { __mode = "k" }),
        limit = tonumber(maxNodes) or WALK_NODE_LIMIT,
    }
    walkJobs[root] = job
    lastStats.pending = (lastStats.pending or 0) + 1
    ScheduleWalkJob(job, 0)
    return true
end

local function HasVisibleKnownAncestor(root)
    local current = ParentOf(root)
    for _ = 1, 16 do
        if not current or current == UIParent or current == WorldFrame then break end
        if knownRoots[current] and IsVisible(current) and FrameSafe(current) then
            return true
        end
        current = ParentOf(current)
    end
    return false
end

local function RefreshVisibleRoots()
    if not Enabled() then return 0 end
    ApplyCharacterGlobals()

    local roots = 0
    lastStats.nodes = 0
    lastStats.texts = 0
    lastStats.pending = 0
    for root in pairs(knownRoots) do
        if root and IsVisible(root) and FrameSafe(root) and not HasVisibleKnownAncestor(root) then
            roots = roots + 1
            -- A raiz superior ja contem suas abas/paineis filhos. O passeio agora
            -- e cooperativo e dividido em varios ticks para nao congelar ao abrir C.
            QueueWalk(root, WALK_NODE_LIMIT)
        end
    end

    lastStats.roots = roots
    return roots
end

local function CharacterVisible()
    for root in pairs(knownRoots) do
        if root and IsVisible(root) and FrameSafe(root) then return true end
    end
    return false
end

After = function(key, delay, fn)
    if A.Runtime and A.Runtime.After then
        A.Runtime.After(key, delay, fn)
    elseif C_Timer and C_Timer.After then
        C_Timer.After(delay, fn)
    else
        pcall(fn)
    end
end

local refreshFastQueued = false
local refreshLateQueued = false
local refreshForcePending = false

local function QueueRefresh(force)
    if not Enabled() then return end
    local characterVisible = CharacterVisible()
    if not force and not characterVisible then return end
    if force then
        refreshForcePending = true
    end

    -- Varios callbacks do CharacterFrame disparam na mesma abertura. Mesmo se o
    -- Runtime do cliente nao agrupar timers por chave, garantimos apenas 1 fast.
    if not refreshFastQueued then
        refreshFastQueued = true
        After("aptbr-character-ui-fast", 0, function()
            refreshFastQueued = false
            local forced = refreshForcePending
            refreshForcePending = false
            if forced or CharacterVisible() then RefreshVisibleRoots() end
        end)
    end

    -- E apenas 1 passe tardio por rajada de atualizacoes. Ele tambem e fatiado.
    if not refreshLateQueued then
        refreshLateQueued = true
        After("aptbr-character-ui-late", 0.28, function()
            refreshLateQueued = false
            if CharacterVisible() then RefreshVisibleRoots() end
        end)
    end
end
A.RefreshCharacterUI = QueueRefresh

local function HookRoot(root)
    if not root or not FrameSafe(root) then return end
    knownRoots[root] = true
    if hookedRoots[root] or not root.HookScript then return end
    hookedRoots[root] = true
    pcall(root.HookScript, root, "OnShow", function()
        QueueRefresh(true)
    end)
end

local function DiscoverKnownRoots()
    for i = 1, #ROOT_NAMES do
        local root = _G[ROOT_NAMES[i]]
        if root then HookRoot(root) end
    end
end

local function IsKnownRoot(frame)
    if not frame then return false end
    if knownRoots[frame] then return true end
    local current = frame
    for _ = 1, 12 do
        if not current or current == UIParent or current == WorldFrame then break end
        if knownRoots[current] then return true end
        local name = GetName(current)
        if name and ROOT_SET[name] then return true end
        current = ParentOf(current)
    end
    return false
end

local function HookGlobal(name, callback)
    if installed[name] or not hooksecurefunc or type(_G[name]) ~= "function" then return end
    installed[name] = true
    pcall(hooksecurefunc, name, callback)
end

local function InstallHooks()
    ApplyCharacterGlobals()
    DiscoverKnownRoots()

    -- Os toggles atualizam somente as raizes conhecidas e mantidas em cache.
    for _, name in ipairs({ "ToggleCharacter", "ToggleCharacterFrame", "CharacterFrame_Toggle" }) do
        HookGlobal(name, function()
            QueueRefresh(true)
        end)
    end

    for _, name in ipairs({
        "CharacterFrame_OnShow", "CharacterFrame_ShowSubFrame", "CharacterFrameTab_OnClick",
        "PanelTemplates_SetTab", "PanelTemplates_SelectTab", "PetPaperDollFrame_SetTab",
    }) do
        HookGlobal(name, function() QueueRefresh(true) end)
    end

    HookGlobal("ShowUIPanel", function(frame)
        DiscoverKnownRoots()
        if IsKnownRoot(frame) then QueueRefresh(true) end
    end)

    for _, name in ipairs({
        "CharacterFrame_Update", "PaperDollFrame_UpdateStats", "PaperDollFrame_SetLevel",
        "PaperDollFrame_SetStat", "PaperDollFrame_SetDamage", "PaperDollFrame_SetAttackSpeed",
        "PaperDollFrame_SetAttackPower", "PaperDollFrame_SetRating", "PaperDollFrame_SetMeleeCritChance",
        "PaperDollFrame_SetExpertise", "PaperDollFrame_SetRangedDamage", "PaperDollFrame_SetRangedAttackSpeed",
        "PaperDollFrame_SetRangedAttackPower", "PaperDollFrame_SetRangedCritChance",
        "PaperDollFrame_SetSpellBonusDamage", "PaperDollFrame_SetSpellBonusHealing",
        "PaperDollFrame_SetSpellCritChance", "PaperDollFrame_SetSpellHaste", "PaperDollFrame_SetManaRegen",
        "PaperDollFrame_SetArmor", "PaperDollFrame_SetDefense", "PaperDollFrame_SetDodge",
        "PaperDollFrame_SetParry", "PaperDollFrame_SetBlock", "PaperDollFrame_SetResilience", "PrintStats",
        "ReputationFrame_Update", "SkillFrame_UpdateSkills", "TokenFrame_Update", "CurrencyFrame_Update",
        "TradeSkillFrame_Update", "TradeSkillFrame_SetSelection", "CraftFrame_Update", "CraftFrame_SetSelection",
        "ProfessionsFrame_Update", "ProfessionFrame_Update", "AscensionProfessionFrame_Update", "BookOfArtisans_Update",
        "PetPaperDollFrame_UpdateCompanions", "PetPaperDollFrame_UpdateCompanionPreview",
        "CompanionFrame_Update", "CompanionFrame_UpdateCompanionButton", "MountJournal_Update",
        "MountCollectionFrame_Update", "Collections_Update", "VanityCollectionFrame_Update", "WardrobeFrame_Update",
        "SpellBookFrame_Update", "AscensionSpellbookFrame_Update", "CharacterAdvancement_Update",
        "BookOfAscension_Update", "ItemTextFrame_OnEvent",
    }) do
        HookGlobal(name, function()
            if CharacterVisible() then QueueRefresh(false) end
        end)
    end
end

local function RelevantAddon(name)
    if type(name) ~= "string" then return false end
    if name == "AscensionPTBR" or name:find("Ascension", 1, true) then return true end
    return name == "Blizzard_CharacterUI"
        or name == "Blizzard_TrainerUI"
        or name == "Blizzard_TradeSkillUI"
        or name == "Blizzard_TalentUI"
end

local events = CreateFrame("Frame")
events:RegisterEvent("PLAYER_LOGIN")
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:RegisterEvent("ADDON_LOADED")
for _, eventName in ipairs({
    "PLAYER_EQUIPMENT_CHANGED", "UNIT_STATS", "COMBAT_RATING_UPDATE", "SKILL_LINES_CHANGED",
    "UPDATE_FACTION", "SPELLS_CHANGED", "TRADE_SKILL_SHOW", "TRADE_SKILL_UPDATE",
    "CRAFT_SHOW", "CRAFT_UPDATE", "COMPANION_UPDATE", "PET_UI_UPDATE", "UNIT_PET",
}) do
    pcall(events.RegisterEvent, events, eventName)
end

events:SetScript("OnEvent", function(_, event, arg1)
    if event == "PLAYER_LOGIN" or event == "PLAYER_ENTERING_WORLD" then
        InstallHooks()
        After("aptbr-character-ui-install", 0.20, function()
            InstallHooks()
            if CharacterVisible() then QueueRefresh(true) end
        end)
        return
    end

    if event == "ADDON_LOADED" then
        if not RelevantAddon(arg1) then return end
        After("aptbr-character-ui-addon", 0.10, function()
            InstallHooks()
            if CharacterVisible() then QueueRefresh(true) end
        end)
        return
    end

    if CharacterVisible() then QueueRefresh(false) end
end)

InstallHooks()

SLASH_APTBRC1 = "/aptbrc"
SlashCmdList["APTBRC"] = function()
    InstallHooks()
    local roots = RefreshVisibleRoots()
    if DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage(string.format(
            "|cff33ff99AscensionPTBR|r: C roots=%d nodes=%d textos=%d pendentes=%d; scan global=NÃO; OnUpdate=NÃO.",
            tonumber(roots) or 0, tonumber(lastStats.nodes) or 0,
            tonumber(lastStats.texts) or 0, tonumber(lastStats.pending) or 0
        ))
    end
end

function A.GetCharacterUIDiagnostics()
    local visibleName = "nenhum"
    for root in pairs(knownRoots) do
        if IsVisible(root) then
            visibleName = GetName(root) or "painel sem nome"
            break
        end
    end
    return {
        panel = visibleName,
        roots = tonumber(lastStats.roots) or 0,
        nodes = tonumber(lastStats.nodes) or 0,
        texts = tonumber(lastStats.texts) or 0,
        pending = tonumber(lastStats.pending) or 0,
    }
end

if A.Runtime and A.Runtime.RegisterModule then
    A.Runtime.RegisterModule("character-ui", function()
        InstallHooks()
        if CharacterVisible() then QueueRefresh(false) end
        return true
    end)
end
