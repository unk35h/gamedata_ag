slot0 = class("PolyhedronRankItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.rankController_ = ControllerUtil.GetController(slot0.transform_, "rank")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.m_squadsBtn, nil, function ()
		JumpTools.OpenPageByJump("polyhedronRankSquads", {
			list = uv0.heroList_
		})
	end)
end

function slot0.Refresh(slot0, slot1)
	slot0.user_id = slot1.user_id
	slot0.m_rankText.text = slot1.rank
	slot0.m_scoreText.text = slot1.score
	slot0.m_difficultyText.text = slot1.difficulty
	slot0.heroList_ = slot1.select_hero_id_list

	if slot1.rank <= 3 then
		slot0.rankController_:SetSelectedIndex(slot1.rank)
	else
		slot0.rankController_:SetSelectedIndex(0)
	end

	slot0.m_name.text = slot1.nick
	slot0.m_icon.sprite = ItemTools.getItemSprite(slot1.icon)
	slot0.m_frame.sprite = ItemTools.getItemSprite(slot1.icon_frame)
end

return slot0
