local DEBUG_ENABLED = PolyZone.DebugEnabled
local comboZone = nil
local insideZone = false
local createdZones = {}

---@param zona table La zona da aggiungere
local function aggiungiAComboZone(zona)
    if comboZone ~= nil then
        comboZone:AddZone(zona)
    else
        comboZone = ComboZone:Create({ zona }, { name = "lowsime" })
        comboZone:onPlayerInOutExhaustive(function(isPointInside, point, insideZones, enteredZones, leftZones)
            if leftZones ~= nil then
                for i = 1, #leftZones do
                    TriggerEvent("lowsime:exit", leftZones[i].name)
                end
            end
            if enteredZones ~= nil then
                for i = 1, #enteredZones do
                    TriggerEvent("lowsime:enter", enteredZones[i].name, enteredZones[i].data, enteredZones[i].center)
                end
            end
        end, 500)
    end
end

---@param opzioni table Le opzioni per la zona
---@return boolean true se la zona è stata creata, false altrimenti
local function creaZona(opzioni)
    if opzioni.data and opzioni.data.id then
        local key = opzioni.name .. "_" .. tostring(opzioni.data.id)
        if not createdZones[key] then
            createdZones[key] = true
            return true
        else
            return false
        end
    end
    return true
end

---@param nome string Il nome della zona
---@param vettori vector3 Le coordinate della zona
---@param lunghezza number La lunghezza della zona
---@param larghezza number La larghezza della zona
---@param opzioni table Le opzioni per la zona
exports("AggiungiBoxZona", function(nome, vettori, lunghezza, larghezza, opzioni)
    if not opzioni then opzioni = {} end
    opzioni.name = nome
    opzioni.debugPoly = DEBUG_ENABLED or opzioni.debugPoly
    if not creaZona(opzioni) then return end
    local centroBox = type(vettori) ~= 'vector3' and vector3(vettori.x, vettori.y, vettori.z) or vettori
    local zona = BoxZone:Create(centroBox, lunghezza, larghezza, opzioni)
    aggiungiAComboZone(zona)
end)

---@param nome string Il nome della zona
---@param centro vector3 Il centro della zona
---@param raggio number Il raggio della zona
---@param opzioni table Le opzioni per la zona
local function aggiungiCerchioZona(nome, centro, raggio, opzioni)
    if not opzioni then opzioni = {} end
    opzioni.name = nome
    opzioni.debugPoly = DEBUG_ENABLED or opzioni.debugPoly
    if not creaZona(opzioni) then return end
    local centroCerchio = type(centro) ~= 'vector3' and vector3(centro.x, centro.y, centro.z) or centro
    local zona = CircleZone:Create(centroCerchio, raggio, opzioni)
    aggiungiAComboZone(zona)
end
exports("AggiungiCerchioZona", aggiungiCerchioZona)

---@param nome string Il nome della zona
---@param vettori table Le coordinate della zona
---@param opzioni table Le opzioni per la zona
exports("AggiungiPolyZona", function(nome, vettori, opzioni)
    if not opzioni then opzioni = {} end
    opzioni.name = nome
    opzioni.debugPoly = DEBUG_ENABLED or opzioni.debugPoly
    if not creaZona(opzioni) then return end
    local zona = PolyZone:Create(vettori, opzioni)
    aggiungiAComboZone(zona)
end)

RegisterNetEvent("lowsime:creaCerchioZona")
AddEventHandler("lowsime:creaCerchioZona", function(nome, ...)
    aggiungiCerchioZona(nome, ...)
end)

RegisterCommand("CreaZona", function(source, args, rawCommand)
    local nome = args[1]
    local vettori = json.decode(args[2])
    local opzioni = json.decode(args[3])
    TriggerEvent("lowsime:creaPolyZona", nome, vettori, opzioni)
end, false)