slot0 = class("ChapterStageArchiveItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
	slot0:UnBindRedPoint(slot0.archiveID_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.isLock_ then
			ShowTips(string.format(GetTips("ACTIVITY_RACE_UNLOCK"), BattleStageTools.GetStageCfg(ChapterCfg[uv0.chapterID_].type, uv0.stageID_).name))

			return
		end

		manager.notify:Invoke(CHAPTER_SCROLL_STOP)
		BattleStageAction.ClickChapterArchive(uv0.archiveID_)
		JumpTools.OpenPageByJump("chapterStageArchiveInfo", {
			archiveID = uv0.archiveID_
		})

		uv0.isLock_ = false

		uv0:RefreshLockState()
	end)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0:UnBindRedPoint(slot0.archiveID_)
	slot0:BindRedPoint(slot3)

	slot0.archiveID_ = slot3
	slot0.chapterID_ = slot1
	slot0.stageID_ = slot2
	slot0.isLock_ = BattleStageData:GetStageData()[slot2].clear_times <= 0

	slot0:RefreshLockState()

	slot5 = StageArchiveCfg[slot3].position
	slot0.transform_.localPosition = Vector3(slot5[1], slot5[2], 0)
	slot0.titleText_.text = StageArchiveCfg[slot3].name

	slot0:Show(true)
end

function slot0.RefreshLockState(slot0)
	slot0.lockController_:SetSelectedState(tostring(slot0.isLock_))
end

function slot0.BindRedPoint(slot0, slot1)
	manager.redPoint:bindUIandKey(slot0.redPointTf_, string.format("%s_%s", RedPointConst.COMBAT_CHAPTER_ARCHIVE, slot1))
end

function slot0.UnBindRedPoint(slot0, slot1)
	if slot1 then
		manager.redPoint:unbindUIandKey(slot0.redPointTf_, string.format("%s_%s", RedPointConst.COMBAT_CHAPTER_ARCHIVE, slot1))
	end
end

return slot0
