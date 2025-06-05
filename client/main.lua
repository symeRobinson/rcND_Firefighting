local MenuPool = NativeUI.CreatePool()
local mainMenu
local stationListMenu

local function Notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(msg)
    DrawNotification(false, false)
end

local stations = {}

-- util for onscreen keyboard
local function keyboardInput(text, max)
    AddTextEntry('FMMC_KEY_TIP1', text)
    DisplayOnscreenKeyboard(1, 'FMMC_KEY_TIP1', '', '', '', '', '', max)
    while UpdateOnscreenKeyboard() == 0 do
        Wait(0)
    end
    if GetOnscreenKeyboardResult() then
        return GetOnscreenKeyboardResult()
    end
    return nil
end

local function saveStations()
    TriggerServerEvent('rc_fire:saveStations', stations)
end

local function refreshStations()
    TriggerServerEvent('rc_fire:requestStations')
end

RegisterNetEvent('rc_fire:receiveStations', function(data)
    stations = data or {}
end)

local function openModifyMenu(id)
    local station = stations[id]
    if not station then return end
    local menu = NativeUI.CreateMenu(station.name or 'Station', 'Modify Station')
    MenuPool:Add(menu)

    local nameItem = NativeUI.CreateItem('Name: '..(station.name or ''), 'Set station name')
    menu:AddItem(nameItem)

    local idItem = NativeUI.CreateItem('ID: '..(station.id or ''), 'Set station identifier')
    menu:AddItem(idItem)

    local tpItem = NativeUI.CreateItem('Set Teleport Location', 'Use current position')
    menu:AddItem(tpItem)

    local garageItem = NativeUI.CreateItem('Set Garage Interaction', 'Use current position')
    menu:AddItem(garageItem)

    local lockerItem = NativeUI.CreateItem('Set Locker Room', 'Use current position')
    menu:AddItem(lockerItem)

    local saveItem = NativeUI.CreateItem('Save and Exit', 'Save changes')
    menu:AddItem(saveItem)

    local cancelItem = NativeUI.CreateItem('Cancel', 'Discard changes')
    menu:AddItem(cancelItem)

    menu.OnItemSelect = function(sender, item, index)
        if item == nameItem then
            local res = keyboardInput('Station Name', 30)
            if res then
                station.name = res
                nameItem:Text('Name: '..res)
            end
        elseif item == idItem then
            local res = keyboardInput('Station ID', 10)
            if res then
                station.id = res
                idItem:Text('ID: '..res)
            end
        elseif item == tpItem then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local heading = GetEntityHeading(ped)
            station.teleport = {x = pos.x, y = pos.y, z = pos.z, h = heading}
            Notify('Teleport location saved.')
        elseif item == garageItem then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local heading = GetEntityHeading(ped)
            station.garage = {x = pos.x, y = pos.y, z = pos.z, h = heading}
            Notify('Garage location saved.')
        elseif item == lockerItem then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local heading = GetEntityHeading(ped)
            station.locker = {x = pos.x, y = pos.y, z = pos.z, h = heading}
            Notify('Locker location saved.')
        elseif item == saveItem then
            stations[id] = station
            saveStations()
            menu:Visible(false)
            stationListMenu:Visible(true)
        elseif item == cancelItem then
            menu:Visible(false)
            stationListMenu:Visible(true)
        end
    end

    menu.OnMenuClosed = function()
        stationListMenu:Visible(true)
    end

    menu:Visible(true)
end

local function openCreateMenu()
    local newStation = {name='', id='', teleport=nil, garage=nil, locker=nil}
    local menu = NativeUI.CreateMenu('Create Station', 'New Station')
    MenuPool:Add(menu)

    local nameItem = NativeUI.CreateItem('Name: '..newStation.name, 'Set station name')
    menu:AddItem(nameItem)

    local idItem = NativeUI.CreateItem('ID: '..newStation.id, 'Set station identifier')
    menu:AddItem(idItem)

    local tpItem = NativeUI.CreateItem('Set Teleport Location', 'Use current position')
    menu:AddItem(tpItem)

    local garageItem = NativeUI.CreateItem('Set Garage Interaction', 'Use current position')
    menu:AddItem(garageItem)

    local lockerItem = NativeUI.CreateItem('Set Locker Room', 'Use current position')
    menu:AddItem(lockerItem)

    local saveItem = NativeUI.CreateItem('Save and Exit', 'Save station')
    menu:AddItem(saveItem)

    local cancelItem = NativeUI.CreateItem('Cancel', 'Discard station')
    menu:AddItem(cancelItem)

    menu.OnItemSelect = function(sender, item, index)
        if item == nameItem then
            local res = keyboardInput('Station Name', 30)
            if res then
                newStation.name = res
                nameItem:Text('Name: '..res)
            end
        elseif item == idItem then
            local res = keyboardInput('Station ID', 10)
            if res then
                newStation.id = res
                idItem:Text('ID: '..res)
            end
        elseif item == tpItem then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local heading = GetEntityHeading(ped)
            newStation.teleport = {x = pos.x, y = pos.y, z = pos.z, h = heading}
            Notify('Teleport location saved.')
        elseif item == garageItem then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local heading = GetEntityHeading(ped)
            newStation.garage = {x = pos.x, y = pos.y, z = pos.z, h = heading}
            Notify('Garage location saved.')
        elseif item == lockerItem then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local heading = GetEntityHeading(ped)
            newStation.locker = {x = pos.x, y = pos.y, z = pos.z, h = heading}
            Notify('Locker location saved.')
        elseif item == saveItem then
            local nextId = #stations + 1
            stations[nextId] = newStation
            saveStations()
            menu:Visible(false)
            stationListMenu:Visible(true)
        elseif item == cancelItem then
            menu:Visible(false)
            stationListMenu:Visible(true)
        end
    end

    menu.OnMenuClosed = function()
        stationListMenu:Visible(true)
    end

    menu:Visible(true)
end

local function buildStationList()
    if stationListMenu then
        MenuPool:Remove(stationListMenu)
    end
    stationListMenu = NativeUI.CreateMenu('Stations', 'View/Create/Modify')
    MenuPool:Add(stationListMenu)

    local createItem = NativeUI.CreateItem('Create New', 'Create a new station')
    stationListMenu:AddItem(createItem)

    local items = {}
    for i, st in pairs(stations) do
        local itm = NativeUI.CreateItem(string.format('[%s] %s', st.id or '?', st.name or 'Unknown'), 'Select to modify')
        stationListMenu:AddItem(itm)
        items[itm] = i
    end

    stationListMenu.OnItemSelect = function(sender, item, index)
        if item == createItem then
            stationListMenu:Visible(false)
            openCreateMenu()
        elseif items[item] then
            stationListMenu:Visible(false)
            openModifyMenu(items[item])
        end
    end
end

local function openMainMenu()
    MenuPool:Remove()
    MenuPool = NativeUI.CreatePool()
    mainMenu = NativeUI.CreateMenu('Configuration', 'Fire Settings')
    MenuPool:Add(mainMenu)

    local openStations = NativeUI.CreateItem('View, Modify, Create Stations', 'Open stations menu')
    mainMenu:AddItem(openStations)

    mainMenu.OnItemSelect = function(sender, item, index)
        if item == openStations then
            stationListMenu:Visible(true)
            mainMenu:Visible(false)
        end
    end

    mainMenu:Visible(true)
end

CreateThread(function()
    while true do
        Wait(0)
        MenuPool:ProcessMenus()
    end
end)

RegisterCommand('config', function(source, args)
    if args[1] and args[1]:lower() == 'fire' then
        refreshStations()
        Wait(500)
        buildStationList()
        openMainMenu()
    end
end, false)

