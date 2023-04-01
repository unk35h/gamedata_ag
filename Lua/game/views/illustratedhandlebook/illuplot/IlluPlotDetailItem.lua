slot0 = class("IlluPlotDetailItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.gameObject_.transform, "ButItem")
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.storyID_ = slot1
	slot0.type_ = slot2
	slot0.unlock_ = IllustratedData:GetPlotInfo()[slot1]

	if slot0.unlock_ then
		slot0.controller_:SetSelectedState("normal")
	else
		slot0.controller_:SetSelectedState("empty")
	end

	slot0.nameText_.text = StoryCfg[slot1].name
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.itemBtn_, nil, function ()
		if IllustratedData:GetPlotInfo()[uv0.storyID_] then
			manager.story:StartStory(uv0.storyID_)
		elseif uv0.type_ == 1 then
			slot0 = getStageViaStoryID(uv0.storyID_)
			slot3, slot4 = BattleStageTools.GetChapterSectionIndex(getChapterClientCfgByStageID(slot0).toggle, slot0)

			ShowTips(string.format(GetTips("MISSION_PROGRESS_UNLOCK"), getChapterDifficulty(slot0), slot3, slot4))
		end
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
