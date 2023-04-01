slot0 = class("AbyssRankItemView", ReduxView)

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

	slot0.rankController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "rank")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.checkBtn_, nil, function ()
		JumpTools.OpenPageByJump("abyssTeamCheck", {
			layerInfo = AbyssData:GetRankLayerHeroList(uv0.index_, uv0.isGuild_)
		})
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.data_ = slot2
	slot0.isGuild_ = slot3

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.icon_.sprite = ItemTools.getItemSprite(slot0.data_.portrait)
	slot0.frame_.sprite = ItemTools.getItemSprite(slot0.data_.frame)

	if slot0.data_.rank < 4 then
		slot0.rankController_:SetSelectedIndex(slot0.data_.rank)
	else
		slot0.rankController_:SetSelectedIndex(0)
	end

	slot0.rankLabel_.text = slot0.data_.rank
	slot0.nickLabel_.text = slot0.data_.nick
	slot0.scoreLabel_.text = slot0.data_.score
	slot0.layerLabel_.text = slot0.data_.layer
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
