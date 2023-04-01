slot0 = class("BattleBossTargetItem", SectionTargetItem)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
end

function slot0.Refresh(slot0, slot1, slot2)
	if slot1 then
		SetActive(slot0.activeImage_, true)

		slot0.targetText_.color = Color(0.8392158, 0.8627452, 0.882353)
	else
		SetActive(slot0.activeImage_, false)

		slot0.targetText_.color = Color(0.63, 0.63, 0.63)
	end

	slot0.starCfg = slot2

	if slot0.starCfg then
		slot0.targetText_.text = BattleInstance.GetStarMissionText(slot0.starCfg[1], slot0.starCfg[2], slot0.starCfg[3])

		SetActive(slot0.gameObject_, true)
	else
		SetActive(slot0.gameObject_, false)
	end
end

return slot0
