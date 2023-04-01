slot0 = class("GuildActivityRecordItemView", ReduxView)

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
	if slot0.index_ < 4 then
		slot0.rankController_:SetSelectedState(tostring(slot0.index_ - 1))
	else
		slot0.rankController_:SetSelectedState("3")
	end

	slot0.m_rankText.text = slot0.index_
	slot0.m_icon.sprite = ItemTools.getItemSprite(slot0.data_.icon)
	slot0.m_name.text = slot0.data_.name
	slot0.m_scoreText.text = slot0.data_.damage
	slot0.m_frame.sprite = ItemTools.getItemSprite(slot0.data_.icon_frame)
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
