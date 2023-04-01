slot0 = class("WeaponServantRaceItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.index_ = slot2
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

	slot0.raceController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "race")
	slot0.selController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "sel")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickFunc_ ~= nil then
			uv0.clickFunc_(uv0.index_, uv0.race_, uv0.count_)
		end
	end)
end

function slot0.AddClickListener(slot0, slot1)
	slot0.clickFunc_ = slot1
end

function slot0.SetSelState(slot0, slot1)
	slot0.selController_:SetSelectedState(slot1 and "true" or "false")
end

function slot0.SetRace(slot0, slot1, slot2)
	slot0.race_ = slot1
	slot0.count_ = slot2

	slot0:UpdateView()
end

function slot0.GetName(slot0)
	return slot0.nameText_.text
end

function slot0.GetSprite(slot0)
	return slot0.icon_.sprite
end

function slot0.UpdateView(slot0)
	slot0.raceController_:SetSelectedState(tostring(slot0.race_))

	if slot0.race_ == 0 then
		slot0.nameText_.text = GetTips("ALL")
	else
		slot0.nameText_.text = RaceEffectCfg[slot0.race_].name
	end

	slot0.numText_.text = tostring(slot0.count_)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.clickFunc_ = nil

	Object.Destroy(slot0.gameObject_)
	uv0.super.Dispose(slot0)
end

return slot0
