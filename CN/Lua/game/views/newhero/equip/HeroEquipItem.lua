slot0 = class("HeroEquipItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.info_ = slot3

	slot0:InitUI()
	slot0:Init()
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.info_ = slot2

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.starS_ = {}

	for slot4 = 1, 6 do
		slot0.starS_[slot4] = slot0[string.format("star%dGo_", slot4)]
	end

	slot0:AddBtnListener(nil, , "OnClick")
end

function slot0.Init(slot0)
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.IgnoreAdd(slot0)
	slot0.ignoreAdd_ = true
end

function slot0.RefreshUI(slot0, slot1)
	SetActive(slot0.activeGo_, slot1.equip_id ~= 0)

	if not slot0.ignoreAdd_ then
		SetActive(slot0.addGo_, not slot2)
	end

	if slot2 then
		slot0.bgTrs_.localEulerAngles = Vector3.New(0, 0, 60 * (EquipCfg[slot1.prefab_id].pos - 1))

		SetSpriteWithoutAtlasAsync(slot0.iconImg_, SpritePathCfg.EquipIcon.path .. ItemCfg[slot1.prefab_id].icon)

		slot0.lvText_.text = string.format("%d", slot1.GetLevel and slot1:GetLevel() or 1)
		slot5 = RaceEffectCfg.all

		if (slot1.race or 0) ~= 0 then
			SetActive(slot0.raceImg_.transform.parent.gameObject, true)

			if table.keyof(slot5, slot4) ~= nil then
				slot0.raceImg_.sprite = getSprite("Atlas/Item", string.format("icon_group_%d_c", slot1.race))
			else
				slot0.raceImg_.sprite = HeroTools.GetSmallHeadSprite(slot4)
			end
		else
			SetActive(slot0.raceImg_.transform.parent.gameObject, false)
		end

		for slot9 = 1, 6 do
			SetActive(slot0.starS_[slot9], slot9 <= slot3.starlevel)
		end
	else
		slot0.bgTrs_.localEulerAngles = Vector3.New(0, 0, 60 * (slot1.pos - 1))
	end
end

function slot0.ShowSelect(slot0, slot1)
	SetActive(slot0.selectGo_, slot1)
end

function slot0.OnClick(slot0)
	if slot0.clickFunc then
		slot0.clickFunc(slot0.info_)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.GetItemInfo(slot0)
	return slot0.info_
end

function slot0.Dispose(slot0)
	slot0.clickFunc = nil

	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
