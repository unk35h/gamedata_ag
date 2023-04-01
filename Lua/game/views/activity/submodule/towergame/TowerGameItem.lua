slot0 = class("TowerGameItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.numcontroller_ = ControllerUtil.GetController(slot0.transform_, "num")
	slot0.statucontroller_ = ControllerUtil.GetController(slot0.transform_, "statu")
	slot0.isshowpointcontroller_ = ControllerUtil.GetController(slot0.transform_, "showpoint")
	slot0.selectcontroller_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if ActivityData:GetActivityIsOpen(uv0.levelid_) then
			if uv0.selectCallBack_ ~= nil then
				uv0.selectCallBack_(uv0.levelid_, uv0.index_)
			end

			TowerGameData:SetLevel(uv0.levelid_)
			uv0:Go("towerGameSectionInfoView", {
				levelid = uv0.levelid_
			})
		elseif ActivityData:GetActivityData(uv0.levelid_).stopTime < manager.time:GetServerTime() then
			ShowTips(GetTips("TIME_OVER"))
		else
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(uv0.levelid_).startTime)))
		end
	end)
end

function slot0.SetSelectCallBack(slot0, slot1)
	slot0.selectCallBack_ = slot1
end

function slot0.SetData(slot0, slot1)
	slot0.index_ = slot1
	slot0.levelid_ = TowerGameCfg.all[slot1]
	slot0.nametext_.text = BattleTowerGameCfg[TowerGameCfg[slot0.levelid_].stage_id].name

	slot0.numcontroller_:SetSelectedState(string.format(slot1))
	slot0.statucontroller_:SetSelectedState(TowerGameData:GetLevelStatuByLevelId(slot0.levelid_))

	slot3, slot0.pointtext_.text = TowerGameData:GetLevelIsShowPointByLevelID(slot0.levelid_)

	slot0.isshowpointcontroller_:SetSelectedState(slot3)
	slot0:UpdateTime()
	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME_NOT_FIGHT, slot0.levelid_))
end

function slot0.RefreshSelect(slot0, slot1)
	if slot0.levelid_ == slot1 then
		slot0.selectcontroller_:SetSelectedState("true")
	else
		slot0.selectcontroller_:SetSelectedState("false")
	end
end

function slot0.UpdateTime(slot0)
	if ActivityData:GetActivityData(slot0.levelid_).stopTime < manager.time:GetServerTime() then
		slot0.timetext_.text = GetTips("TIME_OVER")
	else
		slot0.timetext_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(slot0.levelid_).startTime))
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME_NOT_FIGHT, slot0.levelid_))

	slot0.selectCallBack_ = nil
end

return slot0
