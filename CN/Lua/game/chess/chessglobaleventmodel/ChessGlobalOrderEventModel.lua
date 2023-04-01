slot0 = class("ChessGlobalOrderEventModel")

function slot0.Ctor(slot0, slot1)
	slot0.curIndex_ = nil
	slot0.curEventID_ = nil
	slot0.curGridList_ = nil
	slot0.changeGrid_ = nil
	slot0.isRight_ = false
end

function slot0.SetUp(slot0, slot1)
	if slot0.curEventID_ and slot0.curEventID_ ~= slot1 then
		slot0.handler_:ClearGlobalEventByID(slot0.curEventID_)
	end

	slot0.curIndex_ = WarChessData:GetGlobalEventProgress(slot1) or 0
	slot0.curEventID_ = slot1
	slot0.curGridList_ = {}

	WarChessData:SetGlobalEventProgress(WarchessGlobalCfg[slot0.curEventID_].type, slot1, slot0.curIndex_)

	if WarchessGlobalCfg[slot0.curEventID_].sub_type == 701 then
		for slot7, slot8 in pairs(WarchessGlobalCfg[slot0.curEventID_].params) do
			table.insert(slot0.curGridList_, {
				x = slot8[1],
				z = slot8[2]
			})
		end
	elseif slot2 == 702 then
		for slot7, slot8 in pairs(WarchessGlobalCfg[slot0.curEventID_].params[1]) do
			table.insert(slot0.curGridList_, {
				x = slot8[1],
				z = slot8[2]
			})
		end

		slot0.changeGrid_ = WarchessGlobalCfg[slot0.curEventID_].params[2]

		if #slot0.changeGrid_ ~= 2 then
			error("配置错误：数量不对" .. slot0.curEventID_)
		end
	end
end

function slot0.IsConditionCheck(slot0, slot1, slot2)
	if not slot0.curEventID_ then
		return
	end

	if slot2 == ChessConst.TIMING_INTERACT and slot0.curIndex_ >= #slot0.curGridList_ then
		return true
	end

	return false
end

function slot0.ExternExecutePhase(slot0, slot1, slot2)
	if slot2 ~= ChessConst.TIMING_INTERACT then
		return
	end

	slot3 = WarchessGlobalCfg[slot0.curEventID_].sub_type
	slot4 = manager.ChessManager:GetExecutingChess()
	slot5 = false

	for slot9, slot10 in ipairs(slot0.curGridList_) do
		if slot10.x == slot4.x and slot10.z == slot4.z then
			slot5 = slot9

			break
		end
	end

	if not slot5 then
		return false
	end

	slot6 = slot4.paramList[0]

	if slot0.isRight_ then
		if WarchessEventPoolCfg[slot6].event_group_second == "" then
			return nil
		end

		slot7 = deepClone(WarchessEventPoolCfg[slot6].event_group_second)

		if slot3 == 702 then
			if slot0.curIndex_ == 3 then
				table.insert(slot7, {
					10602,
					{
						{
							10304,
							slot0.curGridList_[1].x,
							slot0.curGridList_[1].z,
							{
								2
							}
						},
						{
							10304,
							slot0.curGridList_[2].x,
							slot0.curGridList_[2].z,
							{
								2
							}
						},
						{
							10304,
							slot0.curGridList_[3].x,
							slot0.curGridList_[3].z,
							{
								2
							}
						},
						{
							10304,
							slot0.changeGrid_[1],
							slot0.changeGrid_[2],
							{
								1
							}
						}
					}
				})
			elseif slot0.curIndex_ == 6 then
				table.insert(slot7, {
					10602,
					{
						{
							10304,
							slot0.curGridList_[4].x,
							slot0.curGridList_[4].z,
							{
								2
							}
						},
						{
							10304,
							slot0.curGridList_[5].x,
							slot0.curGridList_[5].z,
							{
								2
							}
						},
						{
							10304,
							slot0.curGridList_[6].x,
							slot0.curGridList_[6].z,
							{
								2
							}
						},
						{
							10304,
							slot0.changeGrid_[1],
							slot0.changeGrid_[2],
							{
								2
							}
						}
					}
				})
			end
		end

		return ChessTools.ParseEventPollCfg(slot7)
	else
		if WarchessEventPoolCfg[slot6].event_group_third == "" then
			return nil
		end

		slot7 = deepClone(WarchessEventPoolCfg[slot6].event_group_third)

		if slot3 == 702 then
			slot11 = slot0.curEventID_

			for slot11, slot12 in ipairs(WarchessGlobalCfg[slot11].event_list2) do
				table.insert(slot7, slot12)
			end
		end

		return ChessTools.ParseEventPollCfg(slot7)
	end
end

function slot0.ExecutePhase(slot0, slot1)
	slot0.curIndex_ = nil
	slot0.curEventID_ = nil
	slot0.curGridList_ = nil
end

function slot0.UpdateProgress(slot0, slot1, slot2)
	if not slot0.curEventID_ then
		return
	end

	if slot2 == ChessConst.TIMING_INTERACT then
		if slot0.curGridList_[slot0.curIndex_ + 1].x == manager.ChessManager:GetExecutingChess().x and slot4.z == slot3.z then
			slot0.curIndex_ = slot0.curIndex_ + 1
			slot0.isRight_ = true

			WarChessData:SetGlobalEventProgress(WarchessGlobalCfg[slot1].type, slot1, slot0.curIndex_)
		else
			slot0.isRight_ = false
		end
	end
end

function slot0.Dispose(slot0)
	slot0.curIndex_ = nil
	slot0.curEventID_ = nil
	slot0.curGridList_ = nil
end

return slot0
