PantCore	= nil
local DoorInfo	= {}

TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)

RegisterServerEvent('esx_doorlock:updateState')
AddEventHandler('esx_doorlock:updateState', function(doorID, state)
	local xPlayer = PantCore.Functions.GetPlayer(source)

	-- make each door a table, and clean it when toggled
	DoorInfo[doorID] = {}

	-- assign information
	DoorInfo[doorID].state = state
	DoorInfo[doorID].doorID = doorID

	TriggerClientEvent('esx_doorlock:setState', -1, doorID, state)
end)

PantCore.Functions.CreateCallback('esx_doorlock:getDoorInfo', function(source, cb)
	cb(DoorInfo, #DoorInfo)
end)

RegisterServerEvent('esx_doorlock:hack')
AddEventHandler('esx_doorlock:hack', function(mycb)
	local source = source
	
	TriggerClientEvent('esx_doorlock:currentlyhacking', source)
end)


local kapiDurumu = {}

RegisterServerEvent('ld-kapikilit:kapi-durumu')
AddEventHandler('ld-kapikilit:kapi-durumu', function(no, durum, ikili)
	kapiDurumu[no] = {durum = durum}
	if ikili then
		TriggerClientEvent("ld-kapikilit:kapi-durumu-guncelle-ikili", -1, no, kapiDurumu[no])
	else
		TriggerClientEvent("ld-kapikilit:kapi-durumu-guncelle", -1, no, kapiDurumu[no])
	end
end)

PantCore.Functions.CreateCallback('ld-kapikilit:ilk-giris', function(source, cb)
	cb(kapiDurumu)
end)