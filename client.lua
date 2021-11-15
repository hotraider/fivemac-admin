  ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
end)

RegisterCommand("menu", function(source, args)
  TriggerServerEvent("fivemac:permission")
    SetDisplay(true)
end)


RegisterNetEvent("nopefuck")
AddEventHandler("nopefuck", function (source)
TriggerServerEvent("fivemac:permission")
  SetDisplay(false)
end)


function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)
      for _, val in pairs(FC_S.Keys) do
          if IsControlJustPressed(0, val.key) then
            ExecuteCommand("menu", display)
              Citizen.Wait(3500)
          end
      end
  end
end)

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
  return coroutine.wrap(function()
      local iter, id = initFunc()
      if not id or id == 0 then
          disposeFunc(iter)
          return
      end
    
      local enum = {handle = iter, destructor = disposeFunc}
      setmetatable(enum, entityEnumerator)
    
      local next = true
      repeat
          coroutine.yield(id)
          next, id = moveFunc(iter)
      until not next
    
      enum.destructor, enum.handle = nil, nil
      disposeFunc(iter)
  end)
end

RegisterNUICallback("deletevehicle", function(data)
    TriggerServerEvent('fivemac:ServerAllVehicle')
end)

RegisterNUICallback("deleteped", function(data)
  TriggerServerEvent('fivemac:ServerAllPed')
end)

RegisterNUICallback("deleteobject", function(data)
  TriggerServerEvent('fivemac:ServerAllObject')
end)

RegisterNUICallback("deletecom", function(data)
  TriggerServerEvent('fivemac:community')
end)

RegisterNUICallback("deletebilling", function(data)
  TriggerServerEvent('fivemac:deletebilling')
end)

RegisterNUICallback("deleteuser", function(data)
  TriggerServerEvent('fivemac:userdatasil')
end)

RegisterNUICallback("deleteuserinventory", function(data)
  TriggerServerEvent('fivemac:userinventorysil')
end)

RegisterNUICallback("deleteownedvehicles", function(data)
  TriggerServerEvent('fivemac:ownedvehiclesremove')
end)

function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
  end
  
  function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
  end
  
  function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
  end
  
  function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
  end  


  RegisterNUICallback('close', function()
    SetNuiFocus(false)
    SetNuiFocusKeepInput(true)
  end)


  RegisterNetEvent("fivemac-VehicleDeleteAll")
AddEventHandler("fivemac-VehicleDeleteAll", function ()
    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then 
            SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
            SetEntityAsMissionEntity(vehicle, false, false) 
            DeleteVehicle(vehicle)
            if (DoesEntityExist(vehicle)) then
                DeleteVehicle(vehicle) 
            end
        end
    end
end)


RegisterNetEvent("fivemac-PedDeleteAll")
AddEventHandler("fivemac-PedDeleteAll", function ()
	for peds in EnumeratePeds() do
		if not (IsPedAPlayer(peds))then
			 DeleteEntity(peds)
			 RemoveAllPedWeapons(ped, true)
		end
    end
end)



RegisterNetEvent("fivemac-DeleteObjectAll")
AddEventHandler("fivemac-DeleteObjectAll", function ()
    for object in EnumerateObjects() do
		DeleteObject(object)
    end
end)