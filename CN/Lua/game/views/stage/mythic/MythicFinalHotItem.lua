slot0 = class("MythicFinalHotItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "statu")

	slot0:AddListeners()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if MythicData:GetLevelIsOpen(uv0.levelid_) then
			slot0 = manager.net

			slot0:SendWithLoadingNew(44024, {
				difficulty_id = uv0.levelid_
			}, 44025, function (slot0, slot1)
				if isSuccess(slot0.result) then
					MythicData:SetCurHotLevelId(slot1.difficulty_id)
					manager.notify:Invoke(MYTHIC_FINAL_HOTITEM_CLICK, uv0.selffilterid_)
				else
					ShowTips(slot0.result)
				end
			end)
		end
	end)
end

function slot0.SetSpectID(slot0, slot1, slot2, slot3)
	slot0.levelid_ = slot1
	slot0.leveltext_.text = slot0.levelid_
	slot0.selffilterid_ = slot2

	if MythicData:GetLevelIsOpen(slot0.levelid_) then
		if MythicData:GetHotLevelIsPass(slot0.levelid_) then
			slot0.controller_:SetSelectedState("finsh")
		else
			slot0.controller_:SetSelectedState("on")
		end
	else
		slot0.controller_:SetSelectedState("lock")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
