slot0 = class("GMView", ReduxView)

function slot0.UIName(slot0)
	return "UI/GMPanelUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.InitUI(slot0)
	slot0.returnBtn_ = slot0:FindCom("Button", "BtnBack")
	slot0.backgroundBtn_ = slot0:FindCom("Button", "background")
	slot0.gmBtn1_ = slot0:FindCom("Button", "GMBtnPanel/BtnGM1")
	slot0.gmBtn2_ = slot0:FindCom("Button", "GMBtnPanel/BtnGM2")
	slot0.gmBtn3_ = slot0:FindCom("Button", "GMBtnPanel/BtnGM3")
	slot0.gmBtn4_ = slot0:FindCom("Button", "GMBtnPanel/BtnGM4")
	slot0.gmBtn5_ = slot0:FindCom("Button", "GMBtnPanel/BtnGM5")
	slot0.gmBtn6_ = slot0:FindCom("Button", "GMBtnPanel/BtnGM6")
	slot0.gmBtn7_ = slot0:FindCom("Button", "GMBtnPanel/BtnGM7")
	slot0.gmBtn8_ = slot0:FindCom("Button", "GMBtnPanel/BtnGM8")
	slot0.gmBtn9_ = slot0:FindCom("Button", "GMBtnPanel/BtnGM9")
	slot0.inputField_ = slot0:FindCom("InputField", "InputPanel/InputField")
	slot0.sendBtn_ = slot0:FindCom("Button", "InputPanel/SendBtn")
	slot0.urlField_ = slot0:FindCom("InputField", "WindowUrlPanel/InputField")
	slot0.gotoUrlBtn_ = slot0:FindCom("Button", "WindowUrlPanel/GotoUrlBtn")
	slot0.inputTheme_ = slot0:FindCom("InputField", "ActivityPanel/InputField")
	slot0.ActivityBtn_ = slot0:FindCom("Button", "ActivityPanel/ActivityBtn")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.returnBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.backgroundBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.gmBtn1_, nil, function ()
		uv0:SendGMInfo("greenday")
	end)
	slot0:AddBtnListener(slot0.gmBtn2_, nil, function ()
		uv0:SendGMInfo("material")
	end)
	slot0:AddBtnListener(slot0.gmBtn3_, nil, function ()
		uv0:SendGMInfo("currency")
	end)
	slot0:AddBtnListener(slot0.gmBtn4_, nil, function ()
		uv0:SendGMInfo("equip")
	end)
	slot0:AddBtnListener(slot0.gmBtn5_, nil, function ()
		uv0:SendGMInfo("servant")
	end)
	slot0:AddBtnListener(slot0.gmBtn6_, nil, function ()
		uv0:SendGMInfo("userlevel")
	end)
	slot0:AddBtnListener(slot0.gmBtn7_, nil, function ()
		uv0:SendGMInfo("herolevel")
	end)
	slot0:AddBtnListener(slot0.gmBtn8_, nil, function ()
		uv0:SendGMInfo("open")
	end)
	slot0:AddBtnListener(slot0.gmBtn9_, nil, function ()
		uv0:SendGMInfo("mail")
	end)
	slot0:AddBtnListener(slot0.sendBtn_, nil, function ()
		if uv0.inputField_.text == "" then
			return
		end

		if string.sub(uv0.inputField_.text, 1, 3) == "lua" then
			uv0:runScript(string.sub(slot0, 4, #slot0))

			return
		end

		word = "$ " .. uv0.inputField_.text
		uv0.inputField_.text = ""

		uv0:SendGMInfo(word)
	end)
	slot0:AddBtnListener(slot0.ActivityBtn_, nil, function ()
		if uv0.inputTheme_.text == "" then
			uv0:SendGMInfo("$ bbhd start")

			return
		end

		slot0 = uv0.inputTheme_.text
		word = "$ bbhd start " .. uv0.inputTheme_.text
		uv0.inputTheme_.text = ""

		uv0:SendGMInfo(word)
	end)
	slot0:AddBtnListener(slot0.gotoUrlBtn_, nil, function ()
		if uv0.urlField_.text == "" then
			return
		end

		slot1 = string.split(uv0.urlField_.text, ",")
		slot1[1] = tonumber(slot1[1])
		slot2 = {}

		for slot6, slot7 in ipairs(slot1) do
			if tonumber(slot7) > 0 then
				slot2[slot6] = tonumber(slot7)
			else
				slot2[slot6] = slot7
			end
		end

		JumpTools.JumpToPage2(slot2)
	end)
end

function slot0.runScript(slot0, slot1)
	if assert(load(slot1)) == nil then
		return
	end

	slot2()
end

function slot1(slot0, slot1)
	print("Send Msg Return:", slot0.result)
	ShowTips(slot0.result)
end

function slot0.SendGMInfo(slot0, slot1)
	slot2 = nil

	if slot1 == "greenday" then
		slot2 = "$ greenday"
	elseif slot1 == "material" then
		slot2 = "$ setm all 1000"
	elseif slot1 == "currency" then
		slot2 = "$ set all 10000"
	elseif slot1 == "equip" then
		slot2 = "$ equipall"
	elseif slot1 == "servant" then
		slot2 = "$ allservant"
	elseif slot1 == "userlevel" then
		slot2 = "$ lv me 60"
	elseif slot1 == "herolevel" then
		slot2 = "$ lv hero all 60"
	elseif slot1 == "open" then
		slot2 = "$ open all"
	elseif slot1 == "mail" then
		slot2 = "$ mail 3"
	elseif string.sub(slot1, 1, 2) == "$ " then
		slot2 = slot1
	end

	print(slot2)
	manager.net:SendWithLoadingNew(27100, {
		content = slot2
	}, 27101, uv0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.activityView_ = GMActivityView.New(slot0:FindGo("activityGmPanel"))
end

function slot0.OnEnter(slot0)
	slot0.activityView_:OnEnter()
end

function slot0.OnExit(slot0)
	slot0.activityView_:OnExit()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.activityView_:Dispose()

	slot0.activityView_ = nil
end

return slot0
