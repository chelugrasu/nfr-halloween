local showTextUI = false
local showPumpkinTextUI = false
local show3DText = false
local pumpkin = nil
local checkpoint = nil
local hasTheQuest = false
local coordonate = {
    {-889.4756, -853.501, 19.56612,"Nae Moraru",287.8618,0x705E61F2,"mp_m_freemode_01"},
}
local npc = vector3(-889.4756, -853.501, 19.56612)

local startPosition = { x = -889.8, y = -853.501, z = 19.56612, rotX = -3.094298, rotY = 0.05532198, rotZ = 105.1108}
local secondPosition = { x = -862.6049, y = -845.4366, z = 30.47993, rotX = -19.65874, rotY = 0.0511244, rotZ= 105.8611}
local thirdPosition = { x = -1028.326, y = -193.4114, z = 46.65229, rotX = -6.560021, rotY = 0.05395295, rotZ= 156.2006} 
local fourthPosition = { x = -1081.065, y = -254.6316, z = 44.00642, rotX = 0.09085335, rotY = 0.05424575, rotZ= -62.33646} 
local fifthPosition = { x = -1067.726, y = -247.8124, z = 44.00642, rotX = 0.4461189, rotY = 0.05429566, rotZ= -48.66057}
local sixthPosition = { x = -1055.98, y = -238.8164, z = 44.00642, rotX = -1.733706, rotY = 0.05428322, rotZ= -7.70215} 
local seventhPosition = { x = -1055.238, y = -235.4389, z = 44.00642, rotX = -9.637523, rotY = 0.05351945, rotZ= -7.709808} 


local animations = {
    {
        animation = "anim@heists@ornate_bank@hostages@hit",
        type = "player_melee_pistol_kick_a",
        name = "Hitting with your foot"
    },
    {
        animation = "melee@large_wpn@streamed_core",
        type = "ground_attack_0",
        name = "Hitting with a bat"
    }
}

local showQuestSelector = false


local secondQuest = false
local showMindGame = false
local showMiniGame = false
local isInsideBuilding = false
local showDoor = false
local showComputer = false
local hasSecrets = false
local secondCutscene = {
    { x = -889.8, y = -853.501, z = 19.56612, rotX = -3.094298, rotY = 0.05532198, rotZ = 105.1108},
    { x = -862.6049, y = -845.4366, z = 30.47993, rotX = -19.65874, rotY = 0.0511244, rotZ= 105.8611},
    { x = 2605.055, y = -284.9728, z = 125.1036, rotX = -13.23201, rotY = 0.05289, rotZ = 139.1812},
    { x = 2210.688, y = 2936.337, z = -84.15481, rotX = -2.097344, rotY = 0.05555541, rotZ =  97.92321},
    { x = 2161.942, y = 2928.246, z = -84.15249, rotX = -2.820064, rotY = 0.05419815, rotZ = 87.00397},
    { x = 2153.51, y = 2928.537, z = -84.15274, rotX = 0.5753369, rotY = 0.05429083, rotZ = 88.20792}
}

local door = vector4(2515.922, -357.5224, 94.13093, 44.8131)

local interior = vector3(2154.943, 2921.086, -81.07551)

local computer = vector4(2151.081, 2928.54, -84.80001, 79.80042)


function sendProjectName()
    Citizen.Wait(500)
    SendNUIMessage({
        type = "projectName",
        projectName = GetCurrentResourceName()
    })
end

sendProjectName()


-- FUNCTIA DE CREARE A NPC-ULUI
Citizen.CreateThread(function()

    for _,v in pairs(coordonate) do
      RequestModel(GetHashKey(v[7]))
      while not HasModelLoaded(GetHashKey(v[7])) do
        Wait(1)
      end
  
      RequestAnimDict("mini@strip_club@idles@bouncer@base")
      while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
        Wait(1)
      end
      ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
      SetEntityHeading(ped, v[5])
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
      SetPedComponentVariation(ped, 1, 205)
      SetPedComponentVariation(ped, 11, 387)
      SetPedComponentVariation(ped, 4, 24)
      SetPedComponentVariation(ped, 6, 36)
      SetPedComponentVariation(ped, 8, 60)
      local blip = AddBlipForCoord(v[1],v[2],v[3])
      SetBlipScale(blip, 1.0)
      SetBlipSprite(blip, 484)
      SetBlipColour(blip, 44)
      SetBlipAlpha(blip, 255)
      AddTextEntry("NFRQUEST", ""..v[4]..": Quest Halloween")
      BeginTextCommandSetBlipName("NFRQUEST")
      EndTextCommandSetBlipName(blip)
      SetBlipCategory(blip, 2)
    end
end)

-- FUNCTIA DE DRAWTEXT3D (STERGE PENTRU CONSUM MAI MIC ALATURI DE CELALALTE FUNCTII DRAWTEXT3D)
function DrawText3D(x,y,z, text, scl, font) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function lerp(a, b, t)
    return a + (b - a) * t
end

function smoothTransition(startCoords, endCoords, duration, callback)
    local startTime = GetGameTimer() 
    local interpolatedCoords = { x = startCoords.x, y = startCoords.y, z = startCoords.z, w = nil, rotX = startCoords.rotX, rotY = startCoords.rotY, rotZ = startCoords.rotZ }

    Citizen.CreateThread(function()
        local currentTime = 0

        while currentTime <= duration do
            local now = GetGameTimer()
            currentTime = now - startTime

            local t = math.min(currentTime / duration, 1)

            -- Interpolate x, y, z
            interpolatedCoords.x = lerp(startCoords.x, endCoords.x, t)
            interpolatedCoords.y = lerp(startCoords.y, endCoords.y, t)
            interpolatedCoords.z = lerp(startCoords.z, endCoords.z, t)

            interpolatedCoords.rotX = lerp(startCoords.rotX, endCoords.rotX, t)
            interpolatedCoords.rotY = lerp(startCoords.rotY, endCoords.rotY, t)
            interpolatedCoords.rotZ = lerp(startCoords.rotZ, endCoords.rotZ, t)

            if endCoords.w ~= nil then
                interpolatedCoords.w = lerp(startCoords.w or 0, endCoords.w, t)
            end

            if callback then
                callback(interpolatedCoords)
            end

            Citizen.Wait(0)

            if t >= 1 then
                break
            end
        end
    end)
end

-- CHECKING DISTANCE FOR TEXTUI 
Citizen.CreateThread(function()
	local inRange = false
	local shown = false

    while true do
    	inRange = false
        Citizen.Wait(0)
        if NearNPC() and not showTextUI and NearNPC() then
            	inRange = true

            if IsControlJustReleased(0, Config.KeyToOpenMenu) then
                SetNuiFocus(true, true)
                showQuestSelector = true
                SendNUIMessage({
                    type = "toggleQuestSelector",
                    hasSecrets = hasSecrets
                })
                
            end
        elseif NearNPC() then
        	Citizen.Wait(300)
        else
        	Citizen.Wait(1000)
        end

        if inRange and not shown then
        	shown = true
            exports['nfr_textui']:Show(''..Config.KeyToOpenMenuText..'', 'Vorbeste cu Nae Moraru')
        elseif not inRange and shown then
        	shown = false
            exports['nfr_textui']:Hide()
        end
    end
end)

RegisterNetEvent(GetCurrentResourceName()..":startQuest")
AddEventHandler(GetCurrentResourceName()..":startQuest", function(hasQuest, result)
    for _, v in pairs(result) do
        if hasQuest then
            local progress = v.progress
            local target = v.target
            startFirstQuest(progress, target)
        else
            local progress = 0
            local target = v.target
            startFirstQuest(progress, target)
        end
    end
end)

RegisterNUICallback("startQuest", function(quest)
    if showQuestSelector then
        if quest.quest == 1 then
            TriggerServerEvent(GetCurrentResourceName()..":startQuest", quest)
            showQuestSelector = false
            SetNuiFocus(0, 0)
        elseif quest.quest == 2 then
            startSecondQuest()
            showQuestSelector = false
            SetNuiFocus(0, 0)
        end
    end
end)

RegisterNUICallback("mindGameResult", function(result)
    if showMindGame then
        showMindGame = false
        if result.result == 1 then
            print('finished')
            SetNuiFocus(0, 0)
            isInsideBuilding = true
            showDoor = false
            showComputer = true
            SetEntityCoords(PlayerPedId(), interior.x, interior.y, interior.z, false, false, false, true)
            createCheckpoint(computer,"Calculatorul Magului",521)
            updateQuest("Du-te la calculatorul Magului Suprem! 🧙")
        elseif result.result == 0 then
            SetNuiFocus(0, 0)
        end
    end
end)

RegisterNUICallback("stoleSecrets", function()
    if showMiniGame then
        showMiniGame = false
        SetNuiFocus(0, 0)
        hasSecrets = true
        createCheckpoint(npc,"Preda secretele",480)
        updateQuest("Du-te înapoi la Nae Moraru pentru a îi preda secretele! 🎃")
        showComputer = false
    end
end)

function updateQuest(text)
    print(text)
    SendNUIMessage({
        type = "updateQuest",
        tip = text
    })
end

RegisterNUICallback("finishQuest", function()
    if showQuestSelector and hasSecrets then
        SetNuiFocus(0, 0)
        showQuestSelector = false
        hasSecrets = false
        SendNUIMessage({
            type = "updateQuest",
            hide = true
        })
        print('finished quest')
    end
end)

function startFirstQuest(progress, target)
    Citizen.CreateThread(function()
        if not hasTheQuest then
            hasTheQuest = true
            local finished = false
            local inRange = false
            local shown = false
            local targetPumpkins = target
            local currentPumpkins = progress
            local currentPumpkinID = nil
            if currentPumpkins == 0 then 
                currentPumpkinID = 1 
            else 
                currentPumpkinID = math.random(2, #Config.Pumpkins) 
            end
            local requirement = math.random(Config.Hits[1].value, Config.Hits[2].value)
            local pumpkinHits = 0
            local isPlaying = false
                createPumpkin(currentPumpkinID)
                if currentPumpkins <= 0 then
                    SendNUIMessage({
                        type = "startSubtitles",
                        quest = 1
                    })
                    CutsceneStart()
                end
                
                SendNUIMessage({
                    type = "toggleQuest",
                    currentPumpkins = currentPumpkins,
                    targetPumpkins = targetPumpkins
                })

                while true do
                    inRange = false
                    
                    Citizen.Wait(0)
                    if NearPumpkin(Config.Pumpkins[currentPumpkinID].pos) and not finished and NearPumpkin(Config.Pumpkins[currentPumpkinID].pos) then
                            inRange = true
                        if IsControlJustReleased(0, Config.KeyToOpenMenu) then
                            
                            if not isPlaying then
                                isPlaying = true
                                pumpkinHits = pumpkinHits + 1
                                SendNUIMessage({
                                    type = "updateHit",
                                    requirement = requirement,
                                    currentHits = pumpkinHits,
                                    currentPumpkins = currentPumpkins,
                                    targetPumpkins = targetPumpkins
                                })
                                startAnimation()
                                isPlaying = false
                                if pumpkinHits == requirement then
                                    currentPumpkins = currentPumpkins + 1
                                    TriggerServerEvent(GetCurrentResourceName()..":updateQuest", "updateProgress", currentPumpkins)
                                    SendNUIMessage({
                                        type = "updateHit",
                                        requirement = requirement,
                                        currentHits = pumpkinHits,
                                        currentPumpkins = currentPumpkins,
                                        targetPumpkins = targetPumpkins
                                    })

                                    pumpkinHits = 0
                                    requirement = math.random(Config.Hits[1].value, Config.Hits[2].value)
                                    if pumpkin then
                                        DeleteObject(pumpkin)
                                    end
                                    if DoesBlipExist(checkpoint) then
                                        RemoveBlip(checkpoint)
                                    end
                                    if currentPumpkins == targetPumpkins then
                                        SendNUIMessage({
                                            type = "toggleQuest",
                                            currentPumpkins = 0,
                                            targetPumpkins = 0
                                        })
                                        finished = true
                                        hasTheQuest = false
                                    else
                                        local prevPumpkinID = currentPumpkinID
                                        currentPumpkinID = math.random(2, 5) 
                                        while prevPumpkinID == currentPumpkinID do
                                            Citizen.Wait(300)
                                            currentPumpkinID = math.random(2, 5)
                                        end
                                        createPumpkin(currentPumpkinID)
                                    end
                                end
                            end

                        end
                    elseif NearPumpkin(Config.Pumpkins[currentPumpkinID].pos) then
                        Citizen.Wait(300)
                    else
                        Citizen.Wait(1000)
                    end
            
                    if inRange and not shown and not finished then
                        shown = true
                        exports['nfr_textui']:Show(''..Config.KeyToOpenMenuText..'', 'Distruge dovleacul')
                    elseif not inRange and shown and not finished then
                        shown = false
                        exports['nfr_textui']:Hide()
                    elseif shown and finished then
                        shown = false
                        exports['nfr_textui']:Hide()
                    end
                end
        end
    end)
end

function createPumpkin(pumpkinID)
        checkpoint = AddBlipForCoord(Config.Pumpkins[pumpkinID].pos)
        SetBlipScale(checkpoint, 1.0)
        SetBlipSprite(checkpoint, 486)
        SetBlipColour(checkpoint, 44)
        SetBlipAlpha(checkpoint, 255)
        AddTextEntry("PUMPKIN", "Dovleac de Halloween")
        BeginTextCommandSetBlipName("PUMPKIN")
        EndTextCommandSetBlipName(checkpoint)
        SetBlipCategory(checkpoint, 2)
        SetBlipRoute(checkpoint, true)
        local modelHash = `prop_veg_crop_03_pump`
        if not HasModelLoaded(modelHash) then
            RequestModel(modelHash)

            while not HasModelLoaded(modelHash) do
                Citizen.Wait(1)
            end
        end

        pumpkin = CreateObject(modelHash, Config.Pumpkins[pumpkinID].pos, false)
        SetEntityCollision(pumpkin, false, false)
end

function startAnimation()
    local bat = nil
    local animationNumber = math.random(1,2)
    local pid = PlayerPedId()
    if animationNumber == 2 then
        local batmodelHash = `p_cs_bbbat_01`
        if not HasModelLoaded(batmodelHash) then
            RequestModel(batmodelHash)

            while not HasModelLoaded(batmodelHash) do
                Citizen.Wait(1)
            end
        end
        bat = CreateObject(batmodelHash, 1.0,1.0,1.0, true, true, false)
        local boneIndex = GetPedBoneIndex(pid, 28422)
        AttachEntityToEntity(bat, pid, boneIndex, 0.043, 0.008, -0.011, 0.0, -72.909, 232.0, 1, 1, 0, 0, 2, 1)
    end
    RequestAnimDict(animations[animationNumber].animation)
    while (not HasAnimDictLoaded(animations[animationNumber].animation)) do Citizen.Wait(0) end
    TaskPlayAnim(pid, animations[animationNumber].animation, animations[animationNumber].type,1.0,-1.0, 3000, 0, 1, true, true, true)
    if animationNumber == 2 then Citizen.Wait(3000) else Citizen.Wait(2000) end
    if bat ~= nil then
        DeleteObject(bat)
    end
end

function NearPumpkin(pumpkinPos)
    local pos = GetEntityCoords(GetPlayerPed(-1))

    local dist = GetDistanceBetweenCoords(pumpkinPos.x, pumpkinPos.y, pumpkinPos.z, pos.x, pos.y, pos.z, true)

    if dist <= 1.5 then
        return true
    end
end

function CutsceneStart()
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
    local entityPosition = GetEntityCoords(PlayerPedId())
    SetEntityVisible(PlayerPedId(), 0)
    SetCamCoord(cam, -874.7107, -857.426, 19.12323)
    SetCamRot(cam, -3.094298, 0.05532198, 105.1108)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1)
    FreezeEntityPosition(PlayerPedId(), true)
    local currentCoords = startPosition
    local nextCoords = secondPosition
    smoothTransition(currentCoords, nextCoords, 10000, function(coordsFirst)
        SetCamCoord(cam, coordsFirst.x, coordsFirst.y, coordsFirst.z)
        SetCamRot(cam, coordsFirst.rotX, coordsFirst.rotY, coordsFirst.rotZ)
        SetEntityCoords(PlayerPedId(), coordsFirst.x, coordsFirst.y, coordsFirst.z, false, false, false, true)
        if coordsFirst.x == nextCoords.x then 
            Citizen.Wait(3000)
            SetCamCoord(cam, thirdPosition.x, thirdPosition.y, thirdPosition.z)
            SetCamRot(cam, thirdPosition.rotX, thirdPosition.rotY, thirdPosition.rotZ)
            SetEntityCoords(PlayerPedId(), thirdPosition.x, thirdPosition.y, thirdPosition.z, false, false, false, true)
            Citizen.Wait(3500)
            SetCamCoord(cam, fourthPosition.x, fourthPosition.y, fourthPosition.z)
            SetCamRot(cam, fourthPosition.rotX, fourthPosition.rotY, fourthPosition.rotZ)
            SetEntityCoords(PlayerPedId(), fourthPosition.x, fourthPosition.y, fourthPosition.z, false, false, false, true)
            currentCoords = fourthPosition
            nextCoords = fifthPosition
            smoothTransition(currentCoords, nextCoords, 5500, function(coordsSecond)
                SetCamCoord(cam, coordsSecond.x, coordsSecond.y, coordsSecond.z)
                SetCamRot(cam, coordsSecond.rotX, coordsSecond.rotY, coordsSecond.rotZ)
                SetEntityCoords(PlayerPedId(), coordsSecond.x, coordsSecond.y, coordsSecond.z, false, false, false, true)
                if coordsSecond.x == nextCoords.x then
                    currentCoords = fifthPosition
                    nextCoords = sixthPosition
                    smoothTransition(currentCoords, nextCoords, 5000, function(coordsThird)
                        SetCamCoord(cam, coordsThird.x, coordsThird.y, coordsThird.z)
                        SetCamRot(cam, coordsThird.rotX, coordsThird.rotY, coordsThird.rotZ)
                        SetEntityCoords(PlayerPedId(), coordsThird.x, coordsThird.y, coordsThird.z, false, false, false, true)
                        if nextCoords.x == coordsThird.x then
                            currentCoords = sixthPosition
                            nextCoords = seventhPosition
                            smoothTransition(currentCoords, nextCoords, 2000, function(coordsFourth)
                                SetCamCoord(cam, coordsFourth.x, coordsFourth.y, coordsFourth.z)
                                SetCamRot(cam, coordsFourth.rotX, coordsFourth.rotY, coordsFourth.rotZ)
                                SetEntityCoords(PlayerPedId(), coordsFourth.x, coordsFourth.y, coordsFourth.z, false, false, false, true)
                                if nextCoords.x == coordsFourth.x then
                                    Citizen.Wait(4000)
                                    if DoesCamExist(cam) then
                                        DestroyCam(cam, true)
                                        RenderScriptCams(false, true, 1)
                                        cam = nil
                                        SetEntityCoords(PlayerPedId(), entityPosition.x, entityPosition.y, entityPosition.z, false, false, false, true)
                                        SetEntityVisible(PlayerPedId(), 1)
                                        FreezeEntityPosition(PlayerPedId(), false)
                                    end 
                                end
                            end)
                        end
                    end)
                end
            end)
        end
    end)
end

-- CHECKING DISTANCE FOR TEXTUI
function NearNPC()
    local pos = GetEntityCoords(GetPlayerPed(-1))

    for k, v in pairs(Config.NPC) do
        local dist = GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true)

        if dist <= 3 then
            return true
        end
    end
end

-- CHECKING DISTANCE FOR DRAWTEXT3D (STERGE PENTRU CONSUM MAI MIC ALATURI DE CELALALTE FUNCTII DRAWTEXT3D)
Citizen.CreateThread(function()
	local inRange = false
	local shown = false

    while true and Config.showNPCName do
    	inRange = false
        Citizen.Wait(0)
        if NearNPC3D() and not show3DText and NearNPC3D() then
            	inRange = true

                for _,v in pairs(coordonate) do
                    DrawText3D(v[1],v[2],v[3]+2.05, "~o~"..v[4], 1.2, 1)
                end
        elseif NearNPC3D() then
        	Citizen.Wait(0)
        else
        	Citizen.Wait(1000)
        end

        if inRange and not shown then
        	shown = true
        elseif not inRange and shown then
        	shown = false
        end
    end
end)

-- CHECKING DISTANCE FOR DRAWTEXT3D (STERGE PENTRU CONSUM MAI MIC ALATURI DE CELALALTE FUNCTII DRAWTEXT3D)
function NearNPC3D()
    local pos = GetEntityCoords(GetPlayerPed(-1))

    local dist = GetDistanceBetweenCoords(-889.4756, -853.501, 19.56612, pos.x, pos.y, pos.z, true)

    if dist <= 10 then
        return true
    end
end


function createCheckpoint(coords, title, icon)
    if DoesBlipExist(checkpoint) then
        RemoveBlip(checkpoint)
    end
    checkpoint = AddBlipForCoord(coords)
    SetBlipScale(checkpoint, 1.0)
    SetBlipSprite(checkpoint, icon)
    SetBlipColour(checkpoint, 44)
    SetBlipAlpha(checkpoint, 255)
    AddTextEntry("QUEST", title)
    BeginTextCommandSetBlipName("QUEST")
    EndTextCommandSetBlipName(checkpoint)
    SetBlipCategory(checkpoint, 2)
    SetBlipRoute(checkpoint, true)
end

function startSecondQuest()
    SendNUIMessage({
        type = "startSubtitles",
        quest = 2
    })
    cutsceneSecondStart()
    createCheckpoint(door,"Locatia cladirii",438)
    updateQuest("Du-te la locatia setată pe minimap! 🗺️")
    secondQuest = true
    showDoor = true
end

Citizen.CreateThread(function()
    local inRange = false
    local shown = false
    while true do
        local sleep = 2000 -- Default set sleep to run every 2 seconds
        inRange = false
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)

            local dist = GetDistanceBetweenCoords(pos, door.x, door.y, door.z, true)

            if dist < 30.0 and showDoor then
                sleep = 0 -- If distance is 30 units away run thread continuously
                if not shown then 
                    DrawMarker(0, door.x, door.y, door.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.75, 255, 136, 0, 255, true, true, 2, nil, nil, false) 
                end
                if dist < 3.0 and showDoor then
                    -- sleep = 300
                    inRange = true
                    if IsControlJustPressed(0, Config.KeyToOpenMenu) then -- E
                        if not showMindGame then
                            SetNuiFocus(1, 1)
                            showMindGame = true
                            print('here')
                            SendNUIMessage({
                                type = "startMindGame",
                            })
                        end
                    end
                end
            end

        if inRange and not shown then
            shown = true
            exports['nfr_textui']:Show(''..Config.KeyToOpenMenuText..'', 'Pentru a sparge lacătul')
        elseif not inRange and shown then
            shown = false
            exports['nfr_textui']:Hide()
        end

        Citizen.Wait(sleep) -- Set the wait to the defined sleep cycle
    end
end)


Citizen.CreateThread(function()
    local inRangeOfInterior = false
    local shownInterior = false

    local inRangeOfComputer = false
    local shownComputer = false
    while true do
        local sleep = 2000 -- Default set sleep to run every 2 seconds
        inRangeOfInterior = false
        inRangeOfComputer = false
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)

            local distInterior = GetDistanceBetweenCoords(pos, interior.x, interior.y, interior.z, true)

            local distComputer = GetDistanceBetweenCoords(pos, computer.x, computer.y, computer.z, true)

            if distInterior < 30.0 and isInsideBuilding then
                sleep = 0 -- If distance is 30 units away run thread continuously
                if not shownInterior then 
                    DrawMarker(0, interior.x, interior.y, interior.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.75, 255, 136, 0, 255, true, true, 2, nil, nil, false) 
                end
                if distInterior < 3.0 then
                    -- sleep = 300
                    inRangeOfInterior = true
                    if IsControlJustPressed(0, Config.KeyToOpenMenu) then -- E
                        SetEntityCoords(PlayerPedId(), door.x, door.y, door.z, false, false, false, true)
                        isInsideBuilding = false
                    end
                end
            end

            
            if distComputer < 30.0 and showComputer then
                sleep = 0 -- If distance is 30 units away run thread continuously
                if not shownComputer then 
                    DrawMarker(0, computer.x, computer.y, computer.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.75, 255, 136, 0, 255, true, true, 2, nil, nil, false) 
                end
                if distComputer < 3.0 then
                    -- sleep = 300
                    inRangeOfComputer = true
                    if IsControlJustPressed(0, Config.KeyToOpenMenu) then -- E
                        if not showMiniGame then
                            SetNuiFocus(1, 1)
                            showMiniGame = true
                            SendNUIMessage({
                                type = "startMiniGame",
                            })
                        end
                    end
                end
            end

        if inRangeOfInterior and not shownInterior then
            shownInterior = true
            exports['nfr_textui']:Show(''..Config.KeyToOpenMenuText..'', 'Pentru a sparge lacătul')
        elseif not inRangeOfInterior and shownInterior then
            shownInterior = false
            exports['nfr_textui']:Hide()
        end

        if inRangeOfComputer and not shownComputer then
            shownComputer = true
            exports['nfr_textui']:Show(''..Config.KeyToOpenMenuText..'', 'Pentru a folosii calculatorul')
        elseif not inRangeOfComputer and shownComputer then
            shownComputer = false
            exports['nfr_textui']:Hide()
        end



        Citizen.Wait(sleep) -- Set the wait to the defined sleep cycle
    end
end)


function cutsceneSecondStart() 
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
    local entityPosition = GetEntityCoords(PlayerPedId())
    SetEntityVisible(PlayerPedId(), 0)
    SetCamCoord(cam, -874.7107, -857.426, 19.12323)
    SetCamRot(cam, -3.094298, 0.05532198, 105.1108)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1)
    FreezeEntityPosition(PlayerPedId(), true)
    local currentCoords = secondCutscene[1]
    local nextCoords = secondCutscene[2]
    smoothTransition(currentCoords, nextCoords, 5850, function(firstCoords)
        SetCamCoord(cam, firstCoords.x, firstCoords.y, firstCoords.z)
        SetCamRot(cam, firstCoords.rotX, firstCoords.rotY, firstCoords.rotZ)
        SetEntityCoords(PlayerPedId(), firstCoords.x, firstCoords.y, firstCoords.z, false, false, false, true)
        if nextCoords.x == firstCoords.x then
            currentCoords = secondCutscene[2]
            nextCoords = secondCutscene[3]
            SetCamCoord(cam, nextCoords.x, nextCoords.y, nextCoords.z)
            SetCamRot(cam, nextCoords.rotX, nextCoords.rotY, nextCoords.rotZ)
            SetEntityCoords(PlayerPedId(), nextCoords.x, nextCoords.y, nextCoords.z, false, false, false, true)
            Citizen.Wait(5850)
            currentCoords = secondCutscene[3]
            nextCoords = secondCutscene[4]
            SetCamCoord(cam, nextCoords.x, nextCoords.y, nextCoords.z)
            SetCamRot(cam, nextCoords.rotX, nextCoords.rotY, nextCoords.rotZ)
            SetEntityCoords(PlayerPedId(), nextCoords.x, nextCoords.y, nextCoords.z, false, false, false, true)
            currentCoords = secondCutscene[4]
            nextCoords = secondCutscene[5]
            smoothTransition(currentCoords, nextCoords, 8700, function(secondCoords)
                SetCamCoord(cam, secondCoords.x, secondCoords.y, secondCoords.z)
                SetCamRot(cam, secondCoords.rotX, secondCoords.rotY, secondCoords.rotZ)
                SetEntityCoords(PlayerPedId(), secondCoords.x, secondCoords.y, secondCoords.z, false, false, false, true)
                if nextCoords.x == secondCoords.x then
                    currentCoords = secondCutscene[5]
                    nextCoords = secondCutscene[6]
                    smoothTransition(currentCoords, nextCoords, 3000, function(thirdCoords)
                        SetCamCoord(cam, thirdCoords.x, thirdCoords.y, thirdCoords.z)
                        SetCamRot(cam, thirdCoords.rotX, thirdCoords.rotY, thirdCoords.rotZ)
                        SetEntityCoords(PlayerPedId(), thirdCoords.x, thirdCoords.y, thirdCoords.z, false, false, false, true)
                        if nextCoords.x == thirdCoords.x then
                            Citizen.Wait(5850)
                            if DoesCamExist(cam) then
                                DestroyCam(cam, true)
                                RenderScriptCams(false, true, 1)
                                cam = nil
                                SetEntityCoords(PlayerPedId(), entityPosition.x, entityPosition.y, entityPosition.z, false, false, false, true)
                                SetEntityVisible(PlayerPedId(), 1)
                                FreezeEntityPosition(PlayerPedId(), false)
                            end 
                        end
                    end)
                end
            end)
        end
    end)
end
