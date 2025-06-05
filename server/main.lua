local json = json or {}
local stationFile = 'data/stations.json'
local stations = {}

local function saveStations()
    local file = io.open(stationFile, 'w+')
    if file then
        file:write(json.encode(stations))
        file:close()
    end
end

local function loadStations()
    local file = io.open(stationFile, 'r')
    if file then
        local content = file:read('*a')
        file:close()
        if content and content ~= '' then
            local success, data = pcall(json.decode, content)
            if success and type(data) == 'table' then
                stations = data
            end
        end
    else
        -- create file if not exists
        saveStations()
    end
end

AddEventHandler('onResourceStart', function(res)
    if res ~= GetCurrentResourceName() then return end
    loadStations()
end)

RegisterNetEvent('rc_fire:requestStations', function()
    loadStations()
    TriggerClientEvent('rc_fire:receiveStations', source, stations)
end)

RegisterNetEvent('rc_fire:saveStations', function(data)
    stations = data or {}
    saveStations()
end)

