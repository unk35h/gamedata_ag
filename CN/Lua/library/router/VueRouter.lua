slot0 = {
	CreateMatcher = function (slot0, slot1, slot2)
		for slot6, slot7 in pairs(slot1) do
			slot0.routeCfg_[slot7.name] = {
				name = slot7.name,
				parent = slot2,
				precedenceMerge = slot7.precedenceMerge,
				ignoreMerge = slot7.ignoreMerge,
				component = slot7.component
			}

			if slot7.children then
				uv0.CreateMatcher(slot0, slot7.children, slot7.name)
			end
		end
	end,
	ExtractExit = function (slot0, slot1)
		if slot0.recordMap_[slot1] == nil then
			return
		end

		OperationRecorder.RecordStayView(slot2.class.__cname, slot2:GetStayTime())
		slot2:OnExit()
		ReduxFactory.GetInstance():CacheReduxView(slot2)

		slot0.recordMap_[slot1] = nil
	end,
	RefreshHistory = function (slot0, slot1, slot2)
		if uv0.GetIndexFromHistory(slot0, slot1, true) > 0 then
			for slot7 = #slot0.history_, slot3, -1 do
				slot0.history_[slot7] = nil
			end

			slot0.history_[slot3] = {
				url = slot1,
				state = slot2
			}
		else
			slot4 = true

			if #slot0.history_ > 0 and ViewTools.GetIsSkipRecord(uv0.GetRoutesFromUrl(slot0, slot0.history_[#slot0.history_].url)) then
				slot4 = false
			end

			if slot4 then
				table.insert(slot0.history_, {
					url = slot1,
					state = slot2
				})
			else
				slot0.history_[#slot0.history_] = {
					url = slot1,
					state = slot2
				}
			end
		end
	end,
	GetIndexFromHistory = function (slot0, slot1, slot2)
		if slot0.routeCfg_[uv0.GetRoutesFromUrl(slot0, slot1)[1]].precedenceMerge == true then
			for slot7 = 1, #slot0.history_ do
				if uv0.GetRoutesCoincideIndex(slot0, uv0.GetRoutesFromUrl(slot0, slot0.history_[slot7].url), slot3) > 0 then
					return slot7
				end
			end

			return 0
		end

		for slot7 = #slot0.history_, 1, -1 do
			slot8 = uv0.GetRoutesFromUrl(slot0, slot0.history_[slot7].url)

			if slot2 and slot0.routeCfg_[slot8[1]].ignoreMerge and slot8[1] ~= slot3[1] then
				return 0
			end

			if uv0.GetRoutesCoincideIndex(slot0, slot8, slot3) > 0 then
				return slot7
			end
		end

		return 0
	end,
	GetRoutesFromUrl = function (slot0, slot1)
		return string.split(string.sub(slot1, 2, #slot1), "/")
	end,
	GetRoutesCoincideIndex = function (slot0, slot1, slot2)
		slot3 = 0

		for slot7, slot8 in ipairs(slot2) do
			if not slot1[slot7] or slot8 ~= slot1[slot7] then
				return slot7 - 1
			end

			slot3 = slot7
		end

		return slot3
	end,
	GetFullUrl = function (slot0, slot1)
		if not (string.char(string.byte(slot1)) == "/") then
			slot1 = slot0.history_[#slot0.history_] and slot0.history_[#slot0.history_].url .. "/" .. slot1 or "/" .. (slot0.history_[#slot0.history_].url .. "/" .. slot1)
		end

		return slot1
	end,
	ParseUrl = function (slot0, slot1, slot2)
		slot5 = slot1

		if string.char(string.byte(slot1)) == "/" then
			slot5 = string.sub(slot1, 2, #slot1)
		end

		slot6 = string.split(slot5, "/")
		slot7 = {}
		slot0.url_ = ""

		if not slot4 then
			slot8 = #slot0.routes_

			for slot12, slot13 in ipairs(slot0.routes_) do
				if slot13 == slot6[1] then
					slot8 = slot12 - 1

					break
				end
			end

			for slot12 = 1, slot8 do
				table.insert(slot7, slot0.routes_[slot12])

				slot0.url_ = slot0.url_ .. "/" .. slot0.routes_[slot12]
			end

			for slot12 = 1, #slot6 do
				slot13 = slot6[slot12]

				table.insert(slot7, slot13)

				slot0.url_ = slot0.url_ .. "/" .. slot13
			end
		else
			for slot13 = (function ()
				for slot3, slot4 in ipairs(uv0) do
					if slot4 ~= uv1.routes_[slot3] then
						return slot3
					end

					table.insert(uv2, slot4)

					uv1.url_ = uv1.url_ .. "/" .. slot4
				end

				return #uv0 + 1
			end)(), #slot6 do
				table.insert(slot7, slot6[slot13])

				slot0.url_ = slot0.url_ .. "/" .. slot6[slot13]
			end
		end

		slot0.routes_ = slot7

		if slot4 then
			slot0.params_ = {}
		end

		slot8 = pairs
		slot10 = slot2 or {}

		for slot11, slot12 in slot8(slot10) do
			slot0.params_[slot11] = slot12
		end

		return slot4
	end
}
slot1 = class("VueRouter")

function slot1.Ctor(slot0, slot1)
	slot0.routeNumber_ = 0
	slot0.routeCfg_ = {}
	slot0.recordMap_ = {}
	slot0.routes_ = {}
	slot0.oldRoutes_ = {}
	slot0.params_ = {}
	slot0.history_ = {}
	slot0.goCmd_ = {}
	slot0.isGoing_ = false

	uv0.CreateMatcher(slot0, slot1.Routes)
end

function slot2(slot0)
	if slot0 then
		slot0()
	end
end

function slot1.SetActions(slot0, slot1, slot2)
	slot0.preExitAction_ = slot1 or uv0
	slot0.afterStartAction_ = slot2 or uv0
end

function slot1.PlayPreExitTransition(slot0, slot1, slot2, slot3)
	slot0.preExitAction_(slot1, slot2, slot3)
end

function slot1.PlayAfterStartTransition(slot0, slot1, slot2)
	slot0.afterStartAction_(slot1, slot2)
end

function slot1.RegistPreLoadFunc(slot0, slot1)
	slot0.preLoadFunc_ = slot1
end

function slot1.Go(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0.isGoing_ then
		table.insert(slot0.goCmd_, {
			url = slot1,
			params = slot2,
			isReplace = slot3,
			isAsync = slot4
		})

		return
	end

	slot0.isGoing_ = true
	slot4 = slot4 or false
	slot6 = uv0.ParseUrl(slot0, slot1, slot2)
	slot7 = uv0.GetRoutesCoincideIndex(slot0, slot0.oldRoutes_, slot0.routes_)

	if ViewAnimationManager.isReturnFromBattle == true then
		ViewAnimationManager.SetIsReturnFromBattle(slot0.routes_[#slot0.routes_], true)
	end

	if slot5 == true then
		ViewAnimationManager.SetIsReturnFromSubView(slot0.routes_[#slot0.routes_], true)
	end

	if #slot0.oldRoutes_ > 0 then
		if slot0.preLoadFunc_ then
			slot0.preLoadFunc_(slot0.routes_, slot0.oldRoutes_, slot7, slot4)
		end

		slot0.routeNumber_ = slot0.routeNumber_ + 1
		slot9 = "AfterExitOldRoutes" .. slot0.routeNumber_

		GlobalCall.register(slot9, function ()
			uv0:UpdateCoincideRoutes(uv1)
			uv0:EnterNewRoutes(uv2, uv1, uv3, uv4, uv5)

			if #uv0.goCmd_ <= 0 then
				GlobalCall.call("AfterGo")
			end

			uv0:EnterRouteOver()
		end)
		slot0:ExitOldRoutes(slot7, slot4, slot9, slot6)
	else
		slot0.routeNumber_ = slot0.routeNumber_ + 1

		GlobalCall.register("AfterExitOldRoutes" .. slot0.routeNumber_, function ()
			uv0:UpdateCoincideRoutes(uv1)
			uv0:EnterNewRoutes(uv2, uv1, uv3, uv4, uv5)

			if #uv0.goCmd_ <= 0 then
				GlobalCall.call("AfterGo")
			end

			uv0:EnterRouteOver()
		end)
		slot0:PlayPreExitTransition(function ()
			GlobalCall.call(uv0)
		end, slot4, slot6)
	end
end

function slot1.EnterRouteOver(slot0)
	slot0.isGoing_ = false

	if #slot0.goCmd_ > 0 then
		slot1 = slot0.goCmd_[#slot0.goCmd_]
		slot0.goCmd_[#slot0.goCmd_] = nil

		slot0:Go(slot1.url, slot1.params, slot1.isReplace, slot1.isAsync)
	end
end

function slot1.ExitOldRoutes(slot0, slot1, slot2, slot3, slot4)
	slot0:PlayPreExitTransition(function ()
		for slot3 = #uv0.oldRoutes_, uv1 + 1, -1 do
			uv2.ExtractExit(uv0, uv0.oldRoutes_[slot3])

			uv0.oldRoutes_[slot3] = nil
		end

		GlobalCall.call(uv3)
	end, slot2, slot4)
end

function slot1.UpdateCoincideRoutes(slot0, slot1)
	for slot5 = 1, slot1 do
		if slot0.recordMap_[slot0.oldRoutes_[slot5]] then
			if slot0.params_ then
				slot6:SetParams(slot0.params_)
			end

			slot6:OnUpdate()
		end
	end

	if slot0.recordMap_[slot0.oldRoutes_[slot1]] then
		slot2:OnBehind()
	end
end

function slot1.EnterNewRoutes(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = {}

	for slot10 = slot2 + 1, #slot0.routes_ do
		if not slot0.routeCfg_[slot0.routes_[slot10]] then
			error(string.format("找不到对应的界面, url = %s", tostring(slot0.routes_[slot10])))
		end

		slot12, slot13 = ReduxFactory.GetInstance():GetReduxView(slot0.routes_[slot10], slot11)
		slot0.params_.isBack = slot5

		if slot13 then
			slot12:SyncInit(slot0.routes_[slot10], slot14)
		else
			slot12.params_ = slot14
		end

		slot12:UpdateLastOpenTime()
		slot12:OnEnter()
		slot12:AdaptScreen()

		if slot10 ~= #slot0.routes_ then
			table.insert(slot6, slot12)
		end

		slot0.recordMap_[slot0.routes_[slot10]] = slot12
	end

	for slot10 = 1, #slot6 do
		slot6[slot10]:OnUpdate()
	end

	slot0.oldRoutes_ = slot0.routes_

	if slot3 then
		slot0.history_[#slot0.history_] = {
			url = slot0.url_,
			state = slot0.params_
		}
	elseif slot1 and slot2 == 0 then
		uv0.RefreshHistory(slot0, slot0.url_, slot0.params_)
	else
		slot0.history_[#slot0.history_] = {
			url = slot0.url_,
			state = slot0.params_
		}
	end

	slot0:PlayAfterStartTransition(function ()
		GlobalCall.call("AfterEnterNewRoutes")
	end, slot4)
	slot0:SetReduxViewTop(slot0.recordMap_[slot0.routes_[#slot0.routes_]], nil)
end

function slot1.Back(slot0, slot1, slot2)
	slot3 = #slot0.routes_

	if type(slot1) ~= "number" then
		if slot0.routes_[slot3] and slot0.recordMap_[slot4] then
			slot1 = slot0.recordMap_[slot4]:UIBackCount()
		else
			slot1 = 1
		end
	else
		slot4 = 0

		for slot8 = 1, slot1 do
			if slot0.routes_[slot3 - slot4] and slot0.recordMap_[slot9] then
				slot4 = slot4 + slot0.recordMap_[slot9]:UIBackCount()
			else
				break
			end
		end

		slot1 = slot4
	end

	if slot1 < slot3 then
		slot0:PlayPreExitTransition(function ()
			slot0 = {}

			for slot4 = uv0, uv0 - uv1 + 1, -1 do
				table.insert(slot0, uv2.routes_[slot4])
				uv3.ExtractExit(uv2, uv2.routes_[slot4])

				slot5 = uv2.history_[#uv2.history_].url
				uv2.history_[#uv2.history_].url = string.sub(slot5, 0, strrchr(slot5, uv2.routes_[slot4]) - 2)
				uv2.routes_[slot4] = nil
			end

			for slot4 = 1, uv0 - uv1 do
				if uv2.recordMap_[uv2.oldRoutes_[slot4]] ~= nil then
					slot5:OnUpdate()
				end
			end

			uv2:PlayAfterStartTransition(function ()
			end)
			uv2:SetReduxViewTop(uv2.recordMap_[uv2.routes_[#uv2.routes_]], slot0)
		end, false, false)
	else
		if #slot0.history_ <= 1 then
			return
		end

		slot0.history_[#slot0.history_] = nil

		if slot2 then
			for slot7, slot8 in pairs(slot2) do
				slot0.history_[#slot0.history_].state[slot7] = slot8
			end
		end

		slot0:Go(slot0.history_[#slot0.history_].url, slot0.history_[#slot0.history_].state, true, true, true)
	end
end

function slot1.ClearOneHistoryRecord(slot0)
	slot0.history_[#slot0.history_] = nil
end

function slot1.SetReduxViewTop(slot0, slot1, slot2)
	if slot1 then
		slot1:OnTop()
	end
end

function slot1.GetLastHistoryAndParams(slot0)
	return slot0.history_[#slot0.history_].url, slot0.history_[#slot0.history_].state
end

function slot1.ClearHistory(slot0)
	slot0.history_ = {
		{
			url = "/home"
		}
	}
end

function slot1.ClearHistoryByName(slot0, slot1)
	slot2 = 0

	for slot6, slot7 in ipairs(slot0.history_) do
		if slot7.url and string.find(slot7.url, slot1) then
			slot2 = slot6
		end
	end

	if slot2 > 0 then
		table.remove(slot0.history_, slot2)
	end
end

function slot1.GetUrl(slot0)
	return slot0.url_
end

function slot1.GetAllOpenRoute(slot0)
	slot1 = {}

	if slot0.routes_ == nil then
		return slot1
	end

	for slot5, slot6 in ipairs(slot0.routes_) do
		table.insert(slot1, slot6)
	end

	return slot1
end

function slot1.GetLastOpenPage(slot0)
	if slot0.routes_ == nil then
		return ""
	end

	return slot0.routes_[#slot0.routes_] or ""
end

function slot1.IsOpenRoute(slot0, slot1)
	if slot0.routes_ == nil then
		return nil
	end

	for slot5, slot6 in ipairs(slot0.routes_) do
		if slot6 == slot1 then
			return slot5
		end
	end

	return nil
end

function slot1.SetUrlAndParams(slot0, slot1, slot2)
	slot0.url_ = slot1
	slot0.newParams_ = slot2
end

function slot1.RefreshRoutes(slot0)
	slot0.oldRoutes_ = {}

	slot0:Go(slot0.url_, slot0.newParams_, false, true)
end

function slot1.DestroyCurRoutes(slot0)
	for slot4 = #slot0.routes_, 1, -1 do
		uv0.ExtractExit(slot0, slot0.routes_[slot4])
	end

	slot0.routes_ = {}
end

function slot1.GetAllOpenPage(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.routes_) do
		table.insert(slot1, slot0.recordMap_[slot6])
	end

	return slot1
end

function slot1.GetOpenPageHandler(slot0, slot1)
	if slot0:IsOpenRoute(slot1) and slot2 > 0 then
		return slot0.recordMap_[slot0.routes_[slot2]]
	end
end

function slot1.RefreshCurrentPage(slot0)
	for slot4, slot5 in pairs(slot0.recordMap_) do
		slot5:OnUpdate()
	end
end

function slot1.UpdateAllHistoryParams(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0.history_) do
		if slot7.state and slot7.state[slot1] then
			slot7.state[slot1] = slot2
		end
	end
end

function slot1.OverrideUrl(slot0, slot1, slot2, slot3)
	if uv0.GetIndexFromHistory(slot0, slot1) > 0 then
		slot0.history_[slot4] = {
			url = slot2,
			state = slot3
		}
	end
end

function slot1.IsBack(slot0, slot1)
	return uv0.GetIndexFromHistory(slot0, slot1)
end

return slot1
