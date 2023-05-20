-- RegisterNetEvent and AddEventHandler for buying a car
RegisterNetEvent('qb-bennys:buyCar')
AddEventHandler('qb-bennys:buyCar', function(model)
    local source = source
    local player = QBCore.Functions.GetPlayer(source)

    -- Check if the player has the job "cardealer"
    if player.PlayerData.job.name == "cardealer" then
        -- Implement your car purchase logic for cardealer here
        local carPrice = GetCarPrice(model) -- Retrieve the car price based on the model

        if carPrice then
            if player.Functions.RemoveMoney('bank', carPrice) then
                player.Functions.AddCar(model)
                TriggerClientEvent('qb-bennys:purchaseSuccessful', source)
            else
                TriggerClientEvent('qb-bennys:purchaseFailed', source)
            end
        else
            -- Invalid car model, handle the error or notify the player
            TriggerClientEvent('qb-bennys:purchaseFailed', source)
        end
    elseif player.PlayerData.job.name == "police" or player.PlayerData.job.name == "ambulance" then
        -- Implement your car purchase logic for police/ambulance here
        local carPrice = GetCarPrice(model) -- Retrieve the car price based on the model

        if carPrice then
            -- Check if the player has enough money in their personal account
            if player.Functions.RemoveMoney('money', carPrice) then
                player.Functions.AddCar(model)
                TriggerClientEvent('qb-bennys:purchaseSuccessful', source)
            else
                TriggerClientEvent('qb-bennys:purchaseFailed', source)
            end
        else
            -- Invalid car model, handle the error or notify the player
            TriggerClientEvent('qb-bennys:purchaseFailed', source)
        end
    else
        -- Player does not have the required job, cannot buy a car
        TriggerClientEvent('qb-bennys:purchaseFailed', source)
    end
end)

-- Function to retrieve the car price based on the model
function GetCarPrice(model)
    -- Retrieve the car price based on the model
    if model == "buffalo" then
        return 5000
    elseif model == "adder" then
        return 100000
    -- Add more car models and their respective prices here
    end

    -- Car model not found, return nil
    return nil
end

-- Created by Cryotix
