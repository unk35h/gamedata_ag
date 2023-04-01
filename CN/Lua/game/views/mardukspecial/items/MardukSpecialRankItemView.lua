slot0 = class("MardukSpecialRankItemView", ReduxView)

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

	slot0.heroCountController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "heroCount")
	slot0.rankController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "rank")
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.data_ = slot2

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.icon_.sprite = ItemTools.getItemSprite(slot0.data_.portrait)
	slot0.frame_.sprite = ItemTools.getItemSprite(slot0.data_.frame)
	slot0.name_.text = slot0.data_.nick
	slot0.score_.text = slot0.data_.score
	slot0.rank_.text = slot0.data_.rank

	if slot0.data_.rank <= 3 then
		slot0.rankController_:SetSelectedState(tostring(slot0.data_.rank))
	else
		slot0.rankController_:SetSelectedState("0")
	end

	slot4 = tostring

	slot0.heroCountController_:SetSelectedState(slot4(#slot0.data_.select_hero_id_list))

	for slot4 = 1, 3 do
		slot5 = slot0["m_heroIcon_" .. slot4].gameObject
		slot6 = slot0["m_heroIcon_" .. slot4]

		if slot0.data_.select_hero_id_list[slot4] then
			if slot0.data_.select_hero_id_list[slot4].skin_id == 0 then
				slot8 = slot7.id
			end

			slot6.sprite = ItemTools.getItemSprite(slot8)
		end
	end
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
