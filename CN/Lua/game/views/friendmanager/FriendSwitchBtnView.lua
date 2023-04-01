slot0 = class("FriendSwitchBtnView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.index_ = slot2

	slot0:CreateSelector()
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot0.model_ = slot0.selector_.compute(gameStore.getState(), 1)
	slot0.unsubscribeFun = gameStore.subscribe(function (slot0)
		uv0:OnSubscribe()
	end)

	slot0:RefreshUI()
	slot0:RefreshNotice()
end

function slot0.OnExit(slot0)
	slot0.unsubscribeFun()
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0.btnCom_ = slot0:FindCom(typeof(Button), "")
	slot0.unselectGo_ = slot0:FindGo("unselect")
	slot0.selectGo_ = slot0:FindGo("select")
	slot0.noticeImage_ = slot0:FindGo("unselect/notice")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnCom_, nil, function ()
		if uv0.model_.isSelect then
			return
		end

		if uv0.index_ == 3 and uv0.model_.recommendCnt <= 0 then
			slot0 = ActionCreators.TryToRecommendFriend(1, 0)

			slot0:next(function (slot0)
				if isSuccess(slot0.result) then
					OperationRecorder.Record(uv0.class.__cname, tostring(uv0.index_))
					uv0:Go("/friendManager", {
						fType = uv0.index_
					})
				end
			end)
		else
			OperationRecorder.Record(uv0.class.__cname, tostring(uv0.index_))
			uv0:Go("/friendManager", {
				fType = uv0.index_
			})
		end
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.btnCom_.onClick:RemoveAllListeners()
end

function slot0.CreateSelector(slot0)
	slot0.selector_ = createStructuredSelector({
		isSelect = function (slot0, slot1)
			return slot1 == uv0.index_
		end,
		recommendCnt = function (slot0)
			return #slot0.friendlist.recommendData
		end,
		notice = function (slot0, slot1)
			if uv0.index_ == 2 then
				for slot5, slot6 in pairs(slot0.friendlist.friend) do
					if slot6.fType == FriendConst.FRIEND_TYPE.APPLYED then
						return true
					end
				end
			end

			return false
		end
	})
end

function slot0.OnSubscribe(slot0)
	if slot0.model_.isSelect ~= slot0.selector_.compute(gameStore.getState(), slot0:GetViewProp("type")).isSelect then
		slot0.model_.isSelect = slot1.isSelect

		slot0:RefreshUI()
	end

	if slot0.model_.notice ~= slot1.notice then
		slot0.model_.notice = slot1.notice

		slot0:RefreshNotice()
	end

	slot0.model_.recommendCnt = slot1.recommendCnt
end

function slot0.SetBtnType(slot0, slot1)
	slot0:SetViewProp("type", slot1)
	slot0:OnSubscribe()
end

function slot0.RefreshUI(slot0)
	slot1 = slot0.model_.isSelect

	SetActive(slot0.unselectGo_, not slot1)
	SetActive(slot0.selectGo_, slot1)
end

function slot0.RefreshNotice(slot0)
	SetActive(slot0.noticeImage_, slot0.model_.notice)
end

return slot0
