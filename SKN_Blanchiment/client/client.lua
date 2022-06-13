ESX = nil 

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

CreateThread(function()
    while true do 
        local interval = 250 
        local playerPos = GetEntityCoords(PlayerPedId())


        for k,v in pairs(Config.PositionPoint) do 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local pos = Config.PositionPoint
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

            if dist <= 3 then
                interval = 0
                Visual.Subtitle("Appuyez sur [~b~E~s~] pour parler à ~r~KJ", 1)
                DrawMarker(22, pos[k].x + 1, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.5, 0.5, 0.5, 255, 0, 0, 255, false, true, p19, true)
            end

            if dist <= 2.0 then 
                interval = 0 
                if IsControlJustPressed(1, 51) then 
                    discu()
                end
            end
        end
        Wait(interval)
    end
end)

CreateThread(function()
    local Hash = GetHashKey("s_m_y_dealer_01")
    while not HasModelLoaded(Hash) do
		RequestModel(Hash)
		Wait(20)
	end

    pos = Config.PositionPed

    local ped = CreatePed("PED_TYPE_CIVFEMALE", Hash, pos.x, pos.y, pos.z, 340.00, true, false)
    SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
end)

function discu()
    Visual.Subtitle("[~y~Vous~s~] Yo j'ai de l'argent à faire blanchire", 3000)
    Wait(3000)
    Visual.Subtitle("[~r~KJ~s~] T'as combien pour moi ?", 3000)
    Wait(3000)
    local count = KeyboardInput("Combien as-tu à blanchire ?", nil, 8)
    count = tonumber(count)
    Wait(500)
    Visual.Subtitle("[~y~Vous~s~] J'ai ~r~"..count.."$~s~ tu peux me les faires ?", 3000)
    Wait(3000)
    Visual.Subtitle("[~r~KJ~s~] Passes moi l'argent je vais compter", 3000)
    TriggerServerEvent("skn:Blanchiment", count)
end

RegisterNetEvent("skn:Checked")
AddEventHandler("skn:Checked", function(amount)
    Wait(7000)
    Visual.Subtitle("[~r~KJ~s~] Y'a bien le compte tiens ~g~"..amount.."$~s~ d'argent propre", 4000)
    Wait(4000)
    Visual.Subtitle("[~y~Vous~s~] Merci on ce revois plus tard", 3000)
    Wait(3000)
    Visual.Subtitle("[~r~KJ~s~] Vsy à plus fréro", 3000)
end)

RegisterNetEvent("skn:Unchecked")
AddEventHandler("skn:Unchecked", function()
    Wait(7000)
    Visual.Subtitle("[~r~KJ~s~] Tu te fou de ma geule y'a pas le compte !!", 4000)
    Wait(4000)
    Visual.Subtitle("[~r~KJ~s~] Dégages, tu reviendras quand tu auras de l'argent", 4000)
    Wait(3000)
    Visual.Subtitle("[~y~Vous~s~] Okok calme", 3000)
end)


function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    
    blockinput = true 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "Somme", ExampleText, "", "", "", MaxStringLenght) 
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end 
         
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end
