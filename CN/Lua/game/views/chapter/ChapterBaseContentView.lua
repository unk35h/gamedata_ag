slot0 = class("ChapterBaseContentView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.chapterToggle_ = slot2
	slot0.itemList_ = {}

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot0:RefreshMapItems()

	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:OnEnter()
	end

	slot0:Display()
end

function slot0.Display(slot0)
	slot0.scrollView_.enabled = false

	slot0:BreakDisplay()

	slot1 = 1
	slot0.timer_ = Timer.New(function ()
		uv0.itemList_[uv1]:Show(true)

		if uv1 == #uv0.itemList_ then
			uv0.scrollView_.enabled = true
		end

		uv1 = uv1 + 1
	end, 0.03, #slot0.itemList_)

	slot0.timer_:Start()
end

function slot0.BreakDisplay(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnExit(slot0)
	slot0:BreakDisplay()

	for slot4, slot5 in ipairs(slot0.itemList_) do
		slot5:OnExit()
	end

	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = nil
	slot0.scrollView_ = nil
	slot0.mapItem_ = nil
	slot0.itemParent_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
end

function slot0.RemoveListeners(slot0)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 then
		for slot5, slot6 in ipairs(slot0.itemList_) do
			slot6:Show(false)
		end

		slot0:Display()
	else
		slot0:BreakDisplay()
	end
end

function slot0.ChangeSelectIndex(slot0, slot1)
end

function slot0.RefreshMapItems(slot0)
end

function slot0.InitPosition(slot0)
	slot1 = slot0.chapterToggle_
	slot2 = ChapterClientCfg.get_id_list_by_toggle[slot1]

	if slot1 ~= ChapterClientCfg[BattleFieldData:GetCacheChapterClient(slot1)].toggle then
		for slot8, slot9 in pairs(slot2) do
			for slot13, slot14 in ipairs(ChapterClientCfg[slot9].chapter_list) do
				if slot14 == slot3 then
					slot3 = slot9

					break
				end
			end
		end
	end

	slot5 = table.keyof(slot2, slot3)

	slot0:StopTimer()

	slot0.scrollTimer_ = Timer.New(function ()
		uv0.scrollView_.horizontalNormalizedPosition = uv1 / #uv2
	end, 0.013, 1)

	slot0.scrollTimer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.scrollTimer_ then
		slot0.scrollTimer_:Stop()

		slot0.scrollTimer_ = nil
	end
end

return slot0
