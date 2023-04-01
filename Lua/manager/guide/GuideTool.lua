slot1 = {}
slot2 = nil
slot3 = ""

return {
	SatisfyCondition = function (slot0)
		if type(slot0) ~= "table" then
			return true
		end

		for slot4, slot5 in pairs(slot0) do
			if slot5[1] == "stage" then
				if not BattleStageData:GetStageData()[slot5[2]] or slot7[slot6].clear_times < 1 then
					return false
				end
			elseif slot5[1] == "task" then
				if TaskData:GetTask(slot5[2]) then
					if TaskData:GetTask(slot5[2]).complete_flag ~= slot5[3] then
						return false
					end
				end
			elseif slot5[1] == "playerLevel" then
				if PlayerData:GetPlayerInfo().userLevel < slot5[2] then
					return false
				end
			elseif slot5[1] == "playerLevelLessThan" then
				if slot5[2] <= PlayerData:GetPlayerInfo().userLevel then
					return false
				end
			elseif slot5[1] == "uiName" then
				if not gameContext:GetOpenPageHandler(slot5[2]) then
					return false
				end
			elseif slot5[1] == "uiNameList" then
				slot7 = false

				for slot11, slot12 in ipairs(slot5[2]) do
					if gameContext:GetOpenPageHandler(slot12) then
						slot7 = true
					end
				end

				if not slot7 then
					return false
				end
			elseif slot5[1] == "activityId" then
				if not ActivityData:GetActivityIsOpen(slot5[2]) then
					return false
				end
			elseif slot5[1] == "guide" then
				if not GuideData:IsFinish(slot5[2]) then
					return false
				end
			elseif slot5[1] == "storyId" then
				if not manager.story:IsStoryPlayed(slot5[2]) then
					return false
				end
			elseif slot5[1] == "drawNewHero" then
				if DrawData:GetNewHeroFlag() == false then
					return false
				end
			elseif slot5[1] == "equipLevel" then
				slot6 = slot5[2]
				slot7 = false
				slot10 = EquipData
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.GetEquipList(slot12)) do
					if slot6 <= slot12.GetLevel(slot12) then
						slot7 = true

						break
					end
				end

				if slot7 == false then
					return false
				end
			elseif slot5[1] == "heroFavorability" then
				if slot5[2][1] and ArchiveData:GetArchive(slot6) then
					if ArchiveData:GetArchive(slot6).lv and slot7 < slot5[2][2] then
						return false
					end
				else
					print("档案id获取错误")
				end
			else
				print("未实现的条件类型:", slot5[1])
			end
		end

		return true
	end,
	FindComponent = function (slot0)
		if ComponentStep.New(nil, 101):AnalyzeComponentCfg(GuideTool.stringToTable(slot0)) then
			slot4 = slot3.gameObject

			LeanTween.scale(slot4, Vector3.New(1.2, 1.2, 1.2), 0.2)
			LeanTween.scale(slot4, Vector3.one, 0.2):setDelay(0.2)
			print("<color=#00ff00>找到了</color>")
		else
			print("<color=#ff0000>找不到</color>")
		end
	end,
	stringToTable = function (slot0)
		return loadstring("return " .. slot0)()
	end,
	Log = function (slot0)
		print("<color=#00ff00>" .. slot0 .. "</color>")
	end,
	GetGameContentUrl = function ()
		return gameContext:GetUrl()
	end,
	GetGameContextParams = function ()
		if not gameContext:GetOpenPageHandler(gameContext:GetLastOpenPage()) then
			return {}
		end

		uv0 = {}
		uv1 = slot1
		uv2 = slot0

		uv3.GetGuideComponent(slot1, "", 0)

		uv1 = nil

		return uv0
	end,
	GetListComponets = function (slot0, slot1, slot2)
		if not gameContext:GetOpenPageHandler(slot0) then
			return {}
		end

		if not slot3[slot1] then
			return {}
		end

		if not slot4.GetItemList(slot4) or not slot5[slot2] then
			return {}
		end

		slot6 = slot5[slot2]
		uv0 = {}
		uv1 = slot6
		uv2 = "LuaList_Item"

		uv3.GetGuideComponent(slot6, "", 0)

		return uv0
	end,
	GetGuideComponent = function (slot0, slot1, slot2)
		if slot2 > 2 then
			return
		end

		for slot6, slot7 in pairs(slot0) do
			slot8 = slot1 .. slot6

			if type(slot7) == "userdata" and not isNil(slot7) then
				table.insert(uv0, {
					uv1,
					slot8,
					slot7
				})
			elseif type(slot7) == "table" then
				if slot7.__cname == "LuaList" and slot7.uiList_ ~= nil then
					table.insert(uv0, {
						uv1,
						slot8,
						slot7.uiList_
					})
				elseif slot7 ~= uv2 then
					uv3.GetGuideComponent(slot7, slot8 .. "/", slot2 + 1)
				end
			end
		end
	end
}
