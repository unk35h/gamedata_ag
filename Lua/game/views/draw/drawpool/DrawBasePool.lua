slot0 = class("DrawBasePool", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/Draw/PoolUI/pool_" .. slot3), slot1)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.poolId = slot2
	slot0.showId = slot3
	slot0.detailBtnList_ = {}
	slot0.btnNameList_ = {}

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:AdaptScreen()
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	if slot0.detailBtnPanelTrans_ ~= nil then
		for slot5 = 0, slot0.detailBtnPanelTrans_.childCount - 1 do
			slot6 = slot0.detailBtnPanelTrans_:GetChild(slot5)
			slot0.detailBtnList_[#slot0.detailBtnList_ + 1] = slot6:GetComponent("Button")
			slot0.btnNameList_[#slot0.btnNameList_ + 1] = tonumber(slot6.name)
		end
	end
end

function slot0.AddUIListener(slot0)
	for slot4, slot5 in ipairs(slot0.detailBtnList_) do
		slot0:AddBtnListener(slot5, nil, function ()
			JumpTools.OpenPageByJump("/heroPreviewMain", {
				isEnter = true,
				hid = uv0.btnNameList_[uv1]
			})
		end)
	end
end

function slot0.Refresh(slot0, slot1)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.ShowCountDownText(slot0, slot1)
	if slot0.countdownText_ then
		SetActive(slot0.countdownText_.gameObject, slot1)
	end
end

function slot0.SetCountDownText(slot0, slot1)
	if slot0.countdownText_ then
		if slot0.poolId == 10003 then
			slot0.countdownText_.text = string.format("<color=#663BAD>%s</color>%s", GetTips("REMAINING_TIME"), manager.time:GetLostTimeLongStr(slot1))
		elseif slot0.poolId == 10013 then
			slot0.countdownText_.text = string.format("<color=#67C7BC>%s</color>%s", GetTips("REMAINING_TIME"), manager.time:GetLostTimeLongStr(slot1))
		elseif slot0.poolId == 10023 then
			slot0.countdownText_.text = string.format("<color=#cf81e6>%s</color>%s", GetTips("REMAINING_TIME"), manager.time:GetLostTimeLongStr(slot1))
		elseif slot0.poolId == 10033 then
			slot0.countdownText_.text = string.format("<color=#E9C18A>%s</color>%s", GetTips("REMAINING_TIME"), manager.time:GetLostTimeLongStr(slot1))
		else
			slot0.countdownText_.text = string.format(GetTips("TIME_DISPLAY_14"), manager.time:GetLostTimeLongStr(slot1))
		end
	end
end

function slot0.GetPoolId(slot0)
	return slot0.poolId
end

function slot0.ShowRightPanel(slot0)
	return true
end

return slot0
