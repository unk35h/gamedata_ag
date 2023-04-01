slot0 = class("GuildBossTeamHeadItemView", ReduxView)

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

	slot0.heroHead_ = NewHeroHead.New(slot0.headGo_)

	slot0.heroHead_:SetRedPointEnable(false)
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetTeamMark(slot0, slot1, slot2)
	SetActive(slot0.teamMark_, slot1)

	if slot1 then
		slot0.teamMarkText_.text = slot2
	end
end

function slot0.SetHeroData(slot0, slot1)
	slot0.heroId_ = slot1

	slot0.heroHead_:SetHeroId(slot1)
	slot0:UpdateView()
end

function slot0.SetSelected(slot0, slot1)
	slot0.heroHead_:SetSelected(slot1)
end

function slot0.RegisterClickListener(slot0, slot1)
	slot0.heroHead_:RegisterClickListener(slot1)
end

function slot0.UpdateView(slot0)
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
	slot0.heroId_ = nil

	if slot0.heroHead_ then
		slot0.heroHead_:Dispose()

		slot0.heroHead_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
