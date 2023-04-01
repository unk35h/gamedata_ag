slot0 = singletonClass("GameLocalData")

function slot0.Ctor(slot0)
	slot0.json_ = require("cjson")
end

function slot0.GetCommonModule(slot0, slot1)
	return slot0.json_.decode(PlayerPrefs.GetString(slot1, "{}"))
end

function slot0.SaveToCommonModule(slot0, slot1, slot2, slot3)
	slot5 = slot0.json_.decode(PlayerPrefs.GetString(slot1, "{}"))
	slot5[slot2] = slot3

	PlayerPrefs.SetString(slot1, slot0.json_.encode(slot5))
end

function slot0.SaveCommonModule(slot0, slot1, slot2)
	PlayerPrefs.SetString(slot1, slot0.json_.encode(slot2))
end

function slot0.GetValueFromCommonModule(slot0, slot1, slot2)
	if slot0:GetCommonModule(slot1)[slot2] == nil then
		print("不存在的键名", slot2)

		return
	end

	return slot4
end

function slot0.SaveUserSettingsData(slot0, slot1, slot2, slot3)
	slot4 = slot0:GetUserData()
	slot4[slot1].userSettings[slot2] = slot3

	PlayerPrefs.SetString("UserData", slot0.json_.encode(slot4))
end

function slot0.SaveTargetModule(slot0, slot1, slot2)
	PlayerPrefs.SetString(slot1 .. "_" .. PlayerPrefs.GetString("UserID"), slot0.json_.encode(slot2))
end

function slot0.GetUserData(slot0)
	return slot0.json_.decode(PlayerPrefs.GetString("UserData", "{}"))
end

function slot0.SaveUserInfoToUserData(slot0, slot1, slot2)
	slot3 = slot0:GetUserData()
	slot3[slot1] = slot2

	PlayerPrefs.SetString("UserData", slot0.json_.encode(slot3))
end

function slot0.SaveModuleNameToIndex(slot0, slot1)
	slot2 = USER_ID
	slot3 = "ModuleList_" .. slot2
	slot5 = slot0.json_.decode(PlayerPrefs.GetString(slot3, "{}"))
	slot5[slot1 .. "_" .. slot2] = 1

	PlayerPrefs.SetString(slot3, slot0.json_.encode(slot5))
end

function slot0.GetTargetModule(slot0, slot1)
	if PlayerPrefs.HasKey(slot1 .. "_" .. USER_ID) == false then
		slot0:SaveModuleNameToIndex(slot1)
	end

	return slot0.json_.decode(PlayerPrefs.GetString(slot3, "{}"))
end

function slot0.SaveToTargetModule(slot0, slot1, slot2, slot3)
	slot4 = slot0:GetTargetModule(slot1)
	slot4[slot2] = slot3

	PlayerPrefs.SetString(slot1 .. "_" .. USER_ID, slot0.json_.encode(slot4))
end

function slot0.GetValueFromTargetModule(slot0, slot1, slot2)
	if slot0:GetTargetModule(slot1)[slot2] == nil then
		return
	end

	return slot4
end

function slot0.ClearTargetUser(slot0, slot1)
	slot3 = slot0.json_.decode(PlayerPrefs.GetString("UserData"))
	slot3[slot1] = nil

	PlayerPrefs.SetString("UserData", slot0.json_.encode(slot3))

	if PlayerPrefs.HasKey("ModuleList_" .. slot1) == false then
		return
	end

	for slot10, slot11 in pairs(slot0.json_.decode(PlayerPrefs.GetString(slot4))) do
		PlayerPrefs.DeleteKey(slot10)
	end

	PlayerPrefs.DeleteKey(slot4)
end

function slot0.ClearAllData(slot0)
	PlayerPrefs.DeleteAll()
end

return slot0
