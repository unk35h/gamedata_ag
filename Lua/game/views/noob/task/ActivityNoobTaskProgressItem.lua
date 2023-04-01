slot0 = class("ActivityNoobTaskProgressItem", ReduxView)
slot1 = {
	"uncomplete",
	"complete",
	"received"
}

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.progress_ < uv0.need_ then
			ShowPopItem(POP_ITEM, uv0.rewardCfg_)

			return
		end

		ActivityNoobAction.ReceiveAccumulateReward(uv0.index_)
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.needText_.text = slot2[1]
	slot0.rewardCfg_ = slot2[2]
	slot0.numText_.text = "x" .. slot0.rewardCfg_[2]
	slot0.index_ = slot1
	slot0.progress_ = slot3
	slot0.need_ = slot2[1]

	slot0:RefreshState()
end

function slot0.RefreshState(slot0)
	slot0.stateCon_:SetSelectedState(slot0:GetItemState())
end

function slot0.GetItemState(slot0)
	if slot0.progress_ < slot0.need_ then
		return uv0[1]
	elseif not ActivityNoobData:GetAccumulateReceivedList()[slot0.index_] then
		return uv0[2]
	else
		return uv0[3]
	end
end

return slot0
