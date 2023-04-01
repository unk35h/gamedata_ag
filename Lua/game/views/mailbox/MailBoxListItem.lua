slot0 = class("MailBoxListItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:AddEventListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.starController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "star")
	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.haveRewardController_ = ControllerUtil.GetController(slot0.transform_, "haveReward")
	slot0.isSelectedController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isSelected")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.normalBtn_, nil, function ()
		if uv0.handler_ ~= nil then
			uv0:handler_()
		end
	end)
end

function slot0.AddEventListener(slot0)
	slot0:RegistEventListener(MAIL_INFO_UPDATE, handler(slot0, slot0.OnMailInfoUpdate))
	slot0:RegistEventListener(MAIL_STAR_UPDATE, handler(slot0, slot0.OnMailStarUpdate))
end

function slot0.OnMailInfoUpdate(slot0, slot1)
	if slot1.id == slot0.data_.id then
		slot0:UpdateView()
	end
end

function slot0.OnMailStarUpdate(slot0, slot1)
	if slot1.id == slot0.data_.id then
		slot0:UpdateStar()
	end
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.SetMailData(slot0, slot1)
	slot0.data_ = slot1

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot1 = MailData.GetMailTitle(slot0.data_.id)
	slot0.nameText_.text = slot1
	slot0.nameText1_.text = slot1

	slot0.haveRewardController_:SetSelectedState(slot0.data_.attach_flag > 0 and "true" or "false")

	if slot0.data_.attach_flag == 2 then
		slot0.statusController_:SetSelectedState("get")
	elseif slot0.data_.read_flag == 2 or slot0.data_.read_flag == 0 then
		slot0.statusController_:SetSelectedState("read")
	else
		slot0.statusController_:SetSelectedState("unread")
	end

	slot0:UpdateStar()
	slot0:UpdateCountdown()
end

function slot0.UpdateStar(slot0)
	if slot0.data_.star_state == 1 then
		slot0.starController_:SetSelectedState("true")
	else
		slot0.starController_:SetSelectedState("false")
	end
end

function slot0.SetSelected(slot0, slot1)
	slot0.isSelectedController_:SetSelectedState(slot1 and "true" or "false")

	if not slot1 and (slot0.data_.read_flag == 0 or slot0.data_.read_flag == 2) and (slot0.data_.attach_flag == 0 or slot0.data_.attach_flag == 2) then
		slot0.alphaGroup_.alpha = 0.7
	else
		slot0.alphaGroup_.alpha = 1
	end
end

function slot0.UpdateCountdown(slot0)
	slot1 = MailTools.GetLostTimeStr(slot0.data_.timeout_timestamp)
	slot0.tipsText_.text = string.format(GetTips("TIME_DISPLAY_5"), slot1)
	slot0.tipsText1_.text = string.format(GetTips("TIME_DISPLAY_5"), slot1)
end

function slot0.GetData(slot0)
	return slot0.data_
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0:RemoveAllEventListener()
	uv0.super.Dispose(slot0)
end

return slot0
