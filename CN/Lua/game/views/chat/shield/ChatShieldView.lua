slot0 = class("ChatShieldView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Chat/ChatShieldUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
	slot0:CreateSelector()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot0.shieldModel_ = slot0.selector_.compute(gameStore.getState())

	slot0:RefreshToggle(slot0.shieldModel_.openShieldWord)

	slot0.unsubscribeFun = gameStore.subscribe(function (slot0)
		uv0:OnSubscribe()
	end)
end

function slot0.OnExit(slot0)
	slot0.unsubscribeFun()
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0.closeBtn_ = slot0:FindCom(typeof(Button), "mask")
	slot0.closeBtn1_ = slot0:FindCom(typeof(Button), "bg/closeBtn")
	slot0.cancelBtn_ = slot0:FindCom(typeof(Button), "bg/cancelBtn")
	slot0.managerBtn_ = slot0:FindCom(typeof(Button), "bg/managerBtn")
	slot0.btnToggle_ = slot0:FindCom(typeof(Toggle), "bg/btnToggle")
	slot0.offImg_ = slot0:FindGo("bg/btnToggle/offImg")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.closeBtn1_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.managerBtn_, nil, function ()
		uv0:Go("/chatShieldSet")
	end)
	slot0:AddToggleListener(slot0.btnToggle_, function (slot0)
		SetActive(uv0.offImg_, not slot0)

		if uv0:GetViewProp("firstEnter") == nil then
			uv0:SetViewProp("firstEnter", true)

			return
		end

		slot1 = 1

		if slot0 then
			slot1 = 0
		end

		if slot0 == uv0.shieldModel_.openShieldWord then
			return
		end

		slot2 = ActionCreators.ShieldWordOperate(slot0)

		slot2:next(function (slot0)
			print(slot0.result)

			if slot0.result == 0 then
				ActionCreators.ShieldWordOperateSuccess(uv0)
			else
				ShowTips(slot0.result)
			end
		end, function (slot0)
			print(slot0)
		end)
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.closeBtn_.onClick:RemoveAllListeners()
	slot0.closeBtn1_.onClick:RemoveAllListeners()
	slot0.cancelBtn_.onClick:RemoveAllListeners()
	slot0.managerBtn_.onClick:RemoveAllListeners()
	slot0.btnToggle_.onValueChanged:RemoveAllListeners()
end

function slot0.CreateSelector(slot0)
	slot0.selector_ = createStructuredSelector({
		openShieldWord = function (slot0)
			return slot0.chat.openShieldWord
		end
	})
end

function slot0.OnSubscribe(slot0)
	if slot0.selector_.compute(gameStore.getState()).openShieldWord ~= slot0.shieldModel_.openShieldWord then
		slot0.shieldModel_.openShieldWord = slot1.openShieldWord
	end
end

function slot0.RefreshToggle(slot0, slot1)
	slot2 = false

	if slot1 == 0 then
		slot2 = true
	end

	if slot0.btnToggle_.isOn == slot2 then
		slot0.btnToggle_.onValueChanged:Invoke(slot2)
	else
		slot0.btnToggle_.isOn = slot2
	end
end

return slot0
