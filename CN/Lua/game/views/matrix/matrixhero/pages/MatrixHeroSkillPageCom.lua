slot0 = class("MatrixHeroSkillPageCom", MatrixHeroSkillPage)

function slot0.AddUIListener(slot0)
	for slot4 = 1, 6 do
		slot5 = slot0.skillItem_[slot4]

		slot5:RegistCallBack(function (slot0)
			JumpTools.OpenPageByJump("matrixSkillUpgrade", {
				skillId = slot0.id,
				heroId = slot0.heroId,
				standardId = uv0.standardId_,
				servantId = slot0.servantId,
				lv = slot0.lv
			})
		end)
	end

	slot0:AddBtnListener(slot0.buttonComboSkill_, nil, function ()
		uv0:Go("/comboSkillInfo", {
			heroID = uv0.heroInfo_.id
		})
	end)
end

function slot0.SetMatirxHeroInfo(slot0, slot1)
	slot0.standardId_ = slot1
	slot0.heroId_ = HeroStandardSystemCfg[slot1].hero_id
	slot0.heroInfo_, slot4 = GetVirtualData(slot1)
	slot0.heroInfo_.servantId = 0

	slot0:UpdateView()
end

return slot0
