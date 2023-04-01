slot0 = class("ActivityFactoryArchiveView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.isLock_ then
			ShowTips(string.format(GetTips("ACTIVITY_RACE_UNLOCK"), BattleActivityStoryStageCfg[uv0.stageID_].name))

			return
		end

		JumpTools.OpenPageByJump("stageArchive", {
			archiveID = uv0.archiveID_
		})
		saveData("StageArchive", "archiveID" .. uv0.archiveID_, true)
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.stageID_ = slot1
	slot0.archiveID_ = slot2
	slot0.isLock_ = slot3
	slot4 = StageArchiveCfg[slot2]
	slot0.nameText_.text = slot4.name
	slot0.transform_.localPosition = Vector3(slot4.position[1], slot4.position[2], 0)

	if slot3 then
		slot0.lockController_:SetSelectedState("lock")
	elseif getData("StageArchive", "archiveID" .. slot2) == true then
		slot0.lockController_:SetSelectedState("read")
	else
		slot0.lockController_:SetSelectedState("unlock")
	end

	slot0:Show(true)
end

function slot0.OnExit(slot0)
	slot0:Show(false)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
