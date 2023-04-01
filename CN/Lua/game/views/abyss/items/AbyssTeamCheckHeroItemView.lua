slot0 = class("AbyssTeamCheckHeroItemView", ReduxView)

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
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.userId_ = slot2
	slot0.heroInfo_ = slot3

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	if slot0.heroInfo_.skin_id == 0 then
		slot1 = slot0.heroInfo_.hero_id
	end

	slot0.icon_.sprite = getSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. slot1)
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
