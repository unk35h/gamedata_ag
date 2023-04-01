slot0 = class("TeachStageBaseItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.transform_.name = slot3
	slot0.stageID_ = slot3

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
	slot0:SetData(slot0.stageID_)
end

function slot0.InitUI(slot0)
	SetActive(slot0.gameObject_, true)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.itemBtn_, nil, function ()
		if uv0.isLock_ then
			ShowTips(uv0.lockStr_)

			return
		end

		BattleFieldData:SetCacheStage(getChapterAndSectionID(uv0.stageID_), uv0.stageID_)
		uv0:Go("teachSectionInfo", {
			section = uv0.stageID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING
		})
	end)
end

function slot0.Dispose(slot0)
	slot0.icon_ = nil
	slot0.itemBtn_ = nil
	slot0.text_ = nil
	slot0.clear_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.stageID_ = slot1

	for slot5, slot6 in ipairs(GameSetting.new_player_study_stage_unlock.value) do
		if slot6[1] == slot1 then
			if BattleStageData:GetStageData()[slot6[2]] and slot7.clear_times > 0 then
				slot0.isLock_ = false
			else
				slot0.isLock_ = true
				slot10, slot11 = BattleStageTools.GetChapterSectionIndex(getChapterClientCfgByStageID(slot6[2]).toggle, slot6[2])
				slot0.lockStr_ = string.format(GetTips("MISSION_PROGRESS_UNLOCK"), getChapterDifficulty(slot6[2]), slot10, slot11)
			end
		end
	end

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if slot0.oldStageID_ ~= slot0.stageID_ then
		slot0.oldStageID_ = slot0.stageID_
		slot1 = BattleBaseTeachStageCfg[slot0.stageID_]
		slot0.transform_.localPosition = Vector3(slot1.position[1], slot1.position[2], 0)
		slot0.icon_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.StageHDPaint.path, slot1.hd_image))
		slot0.text_.text = slot1.name
	end

	SetActive(slot0.gameObject_, true)
	SetActive(slot0.clear_, BattleTeachData:GetBaseTeachList()[slot0.stageID_] and slot1 > 0 or false)
	SetActive(slot0.lockGo_, slot0.isLock_)
end

function slot0.GetLocalPosition(slot0)
	return slot0.transform_.localPosition
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("teachSectionInfo")
end

return slot0
