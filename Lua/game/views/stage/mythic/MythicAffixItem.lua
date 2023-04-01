slot0 = class("MythicAffixItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.lockController = ControllerUtil.GetController(slot0.transform_, "lock")
end

function slot0.SetData(slot0, slot1)
	if slot1.lock then
		slot0.lockController:SetSelectedIndex(1)
	else
		slot0.lockController:SetSelectedIndex(0)

		slot0.nameText_.text = getAffixName(slot1)
		slot0.icon_.sprite = getAffixSprite(slot1)
		slot0.level_.text = slot1[2]
	end

	slot0:Show(true)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
