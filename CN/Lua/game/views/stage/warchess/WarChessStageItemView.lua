slot0 = class("WarChessStageItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.chapterClientID_ = slot3
	slot0.transform_.name = slot3

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot0:RefrshData()

	if WarChessData:GetCurrentChapter(0) == slot0.chapterClientID_ then
		slot0.controller_:SetSelectedState("Exploring")
	elseif slot0.isLock_ then
		slot0.controller_:SetSelectedState("Lock")
	else
		slot0.controller_:SetSelectedState("Explored")
	end

	slot0:RefreshName()
	slot0:RefreshProgress()
	slot0:RefreshBg()
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.OnExit(slot0)
	slot0:Show(false)
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	uv0.super.Dispose(slot0)

	slot0.chapterPaint_.sprite = nil

	Object.Destroy(slot0.gameObject_)

	slot0.btn_ = nil
	slot0.chapterPaint_ = nil
	slot0.chapterName_ = nil
	slot0.lockGo_ = nil
	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "con")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		uv0:ClickItemListener()
	end)
end

function slot0.ClickItemListener(slot0)
	slot2 = ChapterClientCfg[slot0.chapterClientID_]
	slot3 = WarChessData:GetCurrentChapter(0)

	if slot0.isLock_ and slot3 ~= slot0.chapterClientID_ then
		ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot2.level))

		return
	end

	slot0:ClickItem(slot1)
end

function slot0.RemoveListeners(slot0)
	slot0.btn_.onClick:RemoveAllListeners()
end

function slot0.RefrshData(slot0)
	slot0:IsNotice()
	slot0:IsLock()
end

function slot0.RefreshBg(slot0)
	slot0.chapterPaint_.sprite = getSpriteWithoutAtlas(SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[slot0.chapterClientID_].chapter_paint)
end

function slot0.IsLock(slot0)
	slot0.isLock_ = PlayerData:GetPlayerInfo().userLevel < ChapterClientCfg[slot0.chapterClientID_].level
end

function slot0.IsNotice(slot0)
	slot0.notice_ = false
end

function slot0.RefreshName(slot0)
	if not ChapterClientCfg[slot0.chapterClientID_] then
		return
	end

	slot0.chapterName_.text = slot1.name
end

function slot0.GetChapterClientID(slot0)
	return slot0.chapterClientID_
end

function slot0.RefreshProgress(slot0)
	slot0.progressText_.text = ChessTools.GetChapterProgress(slot0.chapterClientID_) .. "%"
	slot0.progressbarImg_.fillAmount = ChessTools.GetChapterProgress(slot0.chapterClientID_) / 100
end

function slot0.ClickItem(slot0, slot1)
	ChessTools.EnterChessMap(slot1)
end

return slot0
