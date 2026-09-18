-- WelcomeToMiddleEarth 1.4.17-community.
-- Skill names/icons/descriptions still come from the live client.
-- Normal class skills are filtered against current level milestones verified
-- from the LOTRO Wiki tables supplied on 2026-09-11. Level-75 mounted-combat
-- entries are intentionally preserved. Warden gambits are read separately.
Progression = {}

function Progression.Call(object, method, ...)
    if object == nil then return nil end
    local ok, fn = pcall(function() return object[method] end)
    if not ok or type(fn) ~= "function" then return nil end
    local success, value = pcall(fn, object, ...)
    if success then return value end
    return nil
end

local call = Progression.Call
local function validNumber(value)
    return type(value) == "number" and value == value and value >= 0 and value < math.huge
end

-- Verified normal/default skill level milestones. These are deliberately only
-- level gates: localized names, icons and descriptions always come from LOTRO.
-- Stance skills that are granted automatically are included (Minstrel), while
-- trait-tree unlocks are outside this reference. Mounted combat is handled
-- separately at level 75.
local levelLists = {
    Beorning   = {1,6,10,12,14,15,16,18,20,22,24,30,32,36},
    Brawler    = {1,4,6,8,10,12,15,18,20,22,24,30,32,38},
    Burglar    = {1,2,3,5,6,8,10,12,14,15,16,17,18,20,24,26,30,36,40,42},
    Captain    = {1,4,8,12,14,16,18,20,30,38,40,46,52,62},
    Champion   = {1,2,10,14,16,18,20,22,24,26,32,34,36,40},
    Guardian   = {1,4,6,8,10,14,16,18,20,22,24,26,28,32,34,36,38},
    Hunter     = {1,2,3,4,7,8,10,12,14,16,18,20,22,24,30,32,36,38,42,46,54},
    LoreMaster = {1,3,4,6,7,8,10,12,15,20,22,26,30,32,34,38,40},
    Mariner    = {1,2,3,5,6,8,10,12,14,18,25,28,34,40,42,48},
    Minstrel   = {1,4,6,8,12,14,16,20,26,30,34,38,42,45,48,50,54,64,68,70},
    RuneKeeper = {1,6,8,14,18,20,22,24,26,28,32,36,40,44,50},
    Warden     = {1,2,5,10,14,16,20,24,25,30,38,39}
}

Progression.DefaultSkillLevels = {}
for classKey, levels in pairs(levelLists) do
    local set = {}
    for _, level in ipairs(levels) do set[level] = true end
    Progression.DefaultSkillLevels[classKey] = set
end

local classKeys = {
    "Beorning","Brawler","Burglar","Captain","Champion","Guardian",
    "Hunter","LoreMaster","Mariner","Minstrel","RuneKeeper","Warden"
}

function Progression.ResolveClassKey(player)
    local classValue = call(player, "GetClass")
    local turbine = Turbine
    local gameplay = turbine and turbine.Gameplay
    local classes = gameplay and gameplay.Class
    if classValue == nil or classes == nil then return nil end
    for _, key in ipairs(classKeys) do
        if classes[key] ~= nil and classValue == classes[key] then return key end
    end
    return nil
end

function Progression.IsAllowedDefaultLevel(classKey, level)
    local levels = Progression.DefaultSkillLevels[classKey]
    -- Unknown/new classes keep the previous fully dynamic behaviour.
    if levels == nil then return true end
    -- Mounted combat is intentionally retained. Current class skill lists expose
    -- these skills at level 75 (for example the Beorning mounted Slash/Coup tranchant).
    if level == 75 then return true end
    return levels[level] == true
end

-- The original 98-point U34 schedule is retained, not extrapolated above 140.
-- Cross-checked against the table linked by the author: hdro-community.de/klassenpunkte/.
-- Official U34 notes confirm the starting level and total.
Progression.TraitLevels = {
    2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,23,25,27,29,
    31,33,35,37,39,41,43,45,47,49,50,51,53,55,57,58,59,60,61,62,63,64,
    65,66,68,70,72,74,75,76,78,80,82,84,85,86,88,90,92,94,95,96,97,98,
    99,100,101,102,103,104,105,106,108,110,112,114,115,116,117,118,119,
    120,121,123,125,127,129,130,131,133,135,137,139,140
}

function Progression.IsTraitLevel(level)
    if not validNumber(level) then return false end
    for _, required in ipairs(Progression.TraitLevels) do
        if required == level then return true end
        if required > level then return false end
    end
    return false
end

function Progression.NextTrait(level)
    for _, required in ipairs(Progression.TraitLevels) do
        if required > level then return required end
    end
    return nil
end

function Progression.SkillsAtLevel(skills, level)
    local entries = {}
    if type(skills) ~= "table" or not validNumber(level) then return entries end
    for _, entry in ipairs(skills) do
        if type(entry) == "table" and entry.level == level then
            entries[#entries+1] = entry
        end
    end
    return entries
end

function Progression.NextSkills(skills, level)
    local nextLevel = nil
    local entries = {}
    if type(skills) ~= "table" then return entries, nextLevel end
    for _, entry in ipairs(skills) do
        if type(entry) == "table" and validNumber(entry.level) and entry.level > level then
            if nextLevel == nil then nextLevel = entry.level end
            if entry.level ~= nextLevel then break end
            entries[#entries+1] = entry
        end
    end
    return entries, nextLevel
end

function Progression.Read(player, classKeyOverride)
    local classKey = classKeyOverride or Progression.ResolveClassKey(player)
    local result = {
        skills = {}, skipped = 0, filtered = 0, unavailable = false,
        lists = {}, classKey = classKey
    }
    local seen = {}
    local function readList(list, required, source)
        local count = call(list, "GetCount")
        if not validNumber(count) or count ~= math.floor(count) then
            if required then result.unavailable = true end
            return
        end
        result.lists[#result.lists+1] = list
        for i = 1, count do
            local skill = call(list, "GetItem", i)
            local info = call(skill, "GetSkillInfo")
            local level = call(skill, "GetRequiredLevel")
            local rank = call(skill, "GetRequiredRank")
            local name = call(info, "GetName")
            local kind = call(info, "GetType")
            -- Mounts and rank-gated PvMP skills do not belong to level progression.
            -- Use the named LOTRO enum instead of relying on its numeric value.
            local skillTypes = Turbine and Turbine.Gameplay and Turbine.Gameplay.SkillType
            local isMount = skillTypes ~= nil and skillTypes.Mount ~= nil and kind == skillTypes.Mount
            if not isMount and (rank == nil or (validNumber(rank) and rank == 0)) then
                if validNumber(level) and level >= 1 and level == math.floor(level)
                    and type(name) == "string" and name ~= "" then
                    local allowed = source ~= "skills" or Progression.IsAllowedDefaultLevel(classKey, level)
                    if allowed then
                        local icon = call(info, "GetIconImageID")
                        local key = tostring(level).."\031"..name.."\031"..tostring(icon)
                        if not seen[key] then
                            seen[key] = true
                            result.skills[#result.skills+1] = {
                                name = name, level = level, icon = icon,
                                description = call(info, "GetDescription") or "",
                                source = source,
                                mounted = source == "skills" and classKey ~= nil and level == 75
                            }
                        end
                    else
                        result.filtered = result.filtered + 1
                    end
                else
                    result.skipped = result.skipped + 1
                end
            end
        end
    end
    readList(call(player, "GetUntrainedSkills"), true, "skills")
    local attributes = call(player, "GetClassAttributes")
    local gambits = call(attributes, "GetUntrainedGambits")
    if gambits ~= nil then readList(gambits, true, "gambits") end
    table.sort(result.skills, function(a,b)
        if a.level ~= b.level then return a.level < b.level end
        if a.name ~= b.name then return a.name < b.name end
        return tostring(a.icon) < tostring(b.icon)
    end)
    return result
end

-- Preserve other plugins' handlers and unregister only our own callbacks.
function Progression.AddCallback(object, event, callback)
    local old = object[event]
    if old == nil then object[event] = callback
    elseif type(old) == "table" then table.insert(old, callback)
    else object[event] = { old, callback } end
end

function Progression.RemoveCallback(object, event, callback)
    local old = object[event]
    if old == callback then object[event] = nil
    elseif type(old) == "table" then
        for i = #old, 1, -1 do
            if old[i] == callback then table.remove(old, i) end
        end
    end
end
