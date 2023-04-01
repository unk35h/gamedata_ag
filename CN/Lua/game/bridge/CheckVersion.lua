slot0 = require("cjson")
slot1 = {}
slot2 = {}

function CheckVersion(slot0, slot1)
	CheckManagers()
	Debug.Log("开始检查版本信息")

	slot2 = manager.ui

	slot2:UIEventEnabled(false)
	SendMessageToSDKWithCallBack("{\"messageType\" : \"GetUpdateInfo\"}", "UpdateInfoGet", function ()
		manager.ui:UIEventEnabled(true)
		Debug.Log("结束检查版本信息")

		if IsVersionNeedUpdate() then
			ShowNeedUpdateWindow()

			if uv0 then
				uv0()
			end
		else
			uv1()
		end
	end)
end

function UpdateInfoGet(slot0, slot1)
	uv0 = uv1.decode(slot0 or "{}") or {}
	uv2 = uv1.decode(slot1 or "{}") or {}
end

function IsVersionNeedUpdate()
	if LuaForUtil.GetResourceVersionName() and slot0 ~= "" and uv0 and uv0.versionName then
		slot2 = string.split(string.sub(slot0, 2), ".")
		slot5 = string.split(string.sub(uv0.versionName, 2), ".")

		for slot9 = 1, 3 do
			if tonumber(slot5[slot9]) < tonumber(slot2[slot9]) then
				return false
			elseif slot10 < slot11 then
				return true
			end
		end
	end

	return false
end

function ShowNeedUpdateWindow()
	GameToSDK.UpUserEvent("{\"eventType\" : \"End\"}")

	if whereami == "battle" then
		CheckManagers()
	end

	ShowMessageBox({
		isTop = true,
		ButtonType = "SingleBtn",
		title = GetTips("PROMPT"),
		content = GetTips("CHECK_UPDATE_NOTE"),
		OkCallback = function ()
			LuaHelper.Quit()
		end,
		CancelCallback = function ()
		end
	})
end
