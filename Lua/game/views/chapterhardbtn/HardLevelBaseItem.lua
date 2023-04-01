slot0 = class("HardLevelBaseItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.hardLevel_ = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot0:IsLock()
	slot0:RefreshItem()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()

	slot0.transform_ = nil
	slot0.btn_ = nil
	slot0.gameObject_ = nil
	slot0.text_ = nil
	slot0.canvasGroup_ = nil
	slot0.unsubscribeFun = nil
	slot0.selector_ = nil
	slot0.lockGo_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0.btn_ = slot0:FindCom(typeof(Button), "")
	slot0.lockGo_ = slot0:FindGo("lockImage")
	slot0.text_ = slot0:FindCom(typeof(Text), "Text")
	slot0.canvasGroup_ = slot0:FindCom(typeof(CanvasGroup), "")
	slot0.image_ = slot0:FindCom(typeof(Image), "")
	slot0.iconImg_ = slot0:FindCom(typeof(Image), "icon")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.isLock_ then
			uv0:LockTips()

			return
		end

		uv0:ClickBtn()
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.btn_.onClick:RemoveAllListeners()
end

function slot0.LockTips(slot0)
	slot6, slot7 = ChapterTools.IsFinishPreChapter(BattleFieldData:GetCacheChapter(getChapterClientCfgByChapterID(getChapterNumList(ChapterCfg[BattleFieldData:GetCacheChapter(BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT))].sub_type)[slot0.hardLevel_][1]).id))

	if not slot6 then
		if ChapterCfg[slot7] == nil then
			ShowTips("ERROR_FUNCTION_NOT_OPEN")

			return
		end

		ShowTips(string.format(GetTips("NEED_FINISH_PRE_STAGE"), GetTips(BattleConst.HARD_LANGUAGE[slot8.difficulty]), slot8.english))

		return
	end

	ShowTips("ERROR_FUNCTION_NOT_OPEN")
end

function slot0.ClickBtn(slot0)
	slot2 = BattleFieldData:GetCacheChapter(BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT))

	if slot2 ~= BattleFieldData:GetCacheChapter(getChapterClientCfgByChapterID(getChapterNumList(ChapterCfg[slot2].sub_type)[slot0.hardLevel_][1]).id) then
		slot0:Go("/chapterSection", {
			chapterID = slot5
		})
	end
end

function slot0.RefreshItem(slot0)
	if slot0.isLock_ then
		SetActive(slot0.lockGo_, true)

		slot0.image_.sprite = getSprite("Atlas/BattleStage", "but_difficulty_lcok")
		slot1 = Color(0.3176471, 0.3176471, 0.3176471)
		slot0.iconImg_.color = slot1
		slot0.text_.color = slot1
	else
		SetActive(slot0.lockGo_, false)

		slot0.image_.sprite = getSprite("Atlas/BattleStage", "but_difficulty")
		slot0.iconImg_.color = BattleConst.HARD_COLOR[slot0.hardLevel_]
		slot0.text_.color = Color(0.6313726, 0.6313726, 0.6313726)
	end
end

function slot0.SetSiblingIndex(slot0, slot1)
	slot0.transform_:SetSiblingIndex(slot1)
end

function slot0.IsLock(slot0)
	slot3 = ChapterCfg[BattleFieldData:GetCacheChapter(BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT))].sub_type

	if slot0.hardLevel_ ~= 1 and slot3 <= 1 then
		slot3 = 2
	end

	if getChapterNumList(slot3)[slot0.hardLevel_] then
		slot0.isLock_ = not ChapterTools.IsFinishPreChapter(getChapterNumList(slot3)[slot0.hardLevel_][1])
	else
		slot0.isLock_ = false
	end
end

return slot0
