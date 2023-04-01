slot0 = class("EquipNewSkillInfoView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.transform_ = slot1.transform
	slot0.gameObject_ = slot1

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.skillItems = {}
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.info_ = slot2

	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot2 = EquipSkillCfg[slot1.id]
		slot0.name_.text = slot2.name
		slot0.effect_.text = slot2.desc_no_value
		slot7 = slot2.icon
		slot0.icon_.sprite = getSprite("Atlas/EquipSkillIconAtlas", slot7)

		for slot7 = 1, slot2.lvmax do
			if not slot0.skillItems[slot7] then
				slot8 = Object.Instantiate(slot0.skillItem_, slot0.skillTrs_)
				slot9 = slot8.transform
				slot0.skillItems[slot7] = {
					gameObejct = slot8,
					transform = slot9,
					nameText = slot0:FindCom(typeof(Text), "bgLv/name", slot9),
					desText = slot0:FindCom(typeof(Text), "des", slot9),
					CanvasGroup = slot0:FindCom(typeof(CanvasGroup), "", slot9)
				}
			end

			slot8 = GetTips("LEVEL") .. string.format("%d", slot7)
			slot10 = string.format(GetI18NText(slot2.desc), tostring(slot2.upgrade / slot2.percent * slot7))

			if slot2.desc_spec_value ~= nil and slot2.desc_spec_value ~= "" then
				slot10 = string.gsub(slot10, tostring(slot9), slot2.desc_spec_value[slot7])
			end

			slot11 = slot0.skillItems[slot7]
			slot11.nameText.text = slot8
			slot11.desText.text = slot10
			slot11.CanvasGroup.alpha = slot7 <= slot1.num and 1 or 0.5

			SetActive(slot11.gameObejct, true)
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot11.transform)
		end

		for slot7 = slot3 + 1, #slot0.skillItems do
			SetActive(slot0.skillItems[slot7].gameObejct, false)
		end

		slot0:RefreshLayout()
	end
end

function slot0.RefreshLayout(slot0)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.skillTrs_)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
