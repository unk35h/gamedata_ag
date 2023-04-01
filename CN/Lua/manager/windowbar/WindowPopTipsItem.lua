slot0 = class("WindowPopTipsItem", import("game.extend.ReduxView"))

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.infoHandler_ = handler(slot0, slot0.RefreshInfo)

	manager.notify:RegistListener(WINDOW_BAR_INFO, slot0.infoHandler_)
end

function slot0.AddListeners(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0:StopTimer()
	manager.notify:RemoveListener(WINDOW_BAR_INFO, slot0.infoHandler_)

	slot0.infoHandler_ = nil
end

function slot0.RefreshInfo(slot0, slot1, slot2)
	if slot1 == CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A then
		if GuildData:GetGuildInfo().id == nil then
			return
		end

		slot0.textNum_.text = string.format("%s/%s", slot3.curWeekCoin, GuildData:GetMaxWeekCoin())
	else
		return
	end

	slot0:CalcOffsetX(slot2)
	slot0:AddTimer()
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()
	SetActive(slot0.gameObject_, true)

	slot0.timer_ = Timer.New(function ()
		uv0:StopTimer()
	end, 3, 1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	SetActive(slot0.gameObject_, false)

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.CalcOffsetX(slot0, slot1)
	slot0.transform_.localPosition = Vector3(slot1.transform:InverseTransformPoint(slot0.goRight_.transform:TransformPoint(Vector3.zero)).x * -1, slot0.transform_.localPosition.y, 0)
end

return slot0
