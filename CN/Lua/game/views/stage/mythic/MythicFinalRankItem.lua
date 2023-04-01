slot0 = class("MythicFinalRankItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
	slot0:AddListeners()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.rankController_ = ControllerUtil.GetController(slot0.transform_, "rank")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.herobtn_, nil, function ()
		JumpTools.OpenPageByJump("mythicFinalRankHeroView", {
			herolist = uv0.team_list_,
			name = uv0.name_,
			userID = uv0.user_id
		})
	end)
end

function slot0.Refresh(slot0, slot1)
	slot0.user_id = slot1.user_id
	slot0.m_rankText.text = slot1.rank
	slot0.m_scoreText.text = slot1.score
	slot0.m_difficultyText.text = slot1.difficulty

	if slot1.rank <= 3 then
		slot0.rankController_:SetSelectedIndex(slot1.rank)
	else
		slot0.rankController_:SetSelectedIndex(0)
	end

	slot0.name_ = slot1.nick
	slot0.m_name.text = slot1.nick
	slot0.m_icon.sprite = ItemTools.getItemSprite(slot1.icon)
	slot5 = slot1.icon_frame
	slot0.m_frame.sprite = ItemTools.getItemSprite(slot5)
	slot0.team_list_ = {}

	for slot5, slot6 in ipairs(slot1.team_list) do
		slot0.team_list_[slot5] = {}

		for slot10, slot11 in ipairs(slot6) do
			table.insert(slot0.team_list_[slot5], {
				id = slot11.id,
				skin_id = slot11.skin_id
			})
		end
	end
end

function firstLargeSize(slot0, slot1)
	if #slot0 <= 0 then
		return slot0
	end

	slot2, slot3, slot4, slot5 = string.find(slot0, "<(.-)>(.+)")
	slot6 = {
		"“",
		"《"
	}
	slot7 = 0
	slot8 = nil
	slot12 = slot5 or slot0

	for slot12 = 1, slot5.getWCharCount(slot12) do
		if table.indexOf(slot6, slot5:getWChar(slot12)) == -1 then
			slot8 = string.format("%s<size=%d>%s</size>%s", string.sub(slot5, 1, slot7), slot1, slot13, string.sub(slot5, slot7 + string.len(slot13) + 1, -1))

			break
		else
			slot7 = slot7 + string.len(slot13)
		end
	end

	if not slot8 then
		return slot0
	end

	if slot4 then
		slot8 = string.format("<%s>%s", slot4, slot8)
	end

	return slot8
end

return slot0
