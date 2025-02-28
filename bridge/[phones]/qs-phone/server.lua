if Config.Phone.QsPhone ~= true then return print("QsPhone SS Off") end

local function getOwnerByPhoneNumber(phoneNumber)
    local query = 'SELECT `owner` FROM `phone_backups` WHERE `phone` = ?'
    local response = MySQL.query.await(query, {phoneNumber})

    if response and #response > 0 then
        return response[1].owner
    end

    return nil
end

local function getPlayerDataByCitizenId(CitizenID)
    local CitizenID = QBCore.Functions.GetPlayerByCitizenId(citizenId)
    if not CitizenID then return nil end
	return CitizenID.PlayerData.source
end

function getPlayerSource(phoneNumber)
	local CitizenID = getOwnerByPhoneNumber(phoneNumber)
	local TargetSource = getPlayerDataByCitizenId(CitizenID)
	if not TargetSource then return nil end
	return TargetSource
end

function getPlayerCoords(TargetSource)
	local ped = GetPlayerPed(TargetSource)
	local coords = GetEntityCoords(ped)
	return { x = coords.x, y = coords.y, z = coords.z }
end