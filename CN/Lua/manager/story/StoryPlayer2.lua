slot0 = class("StoryPlayer2", import("game.extend.BaseView"))

function slot0.Ctor(slot0, slot1)
	slot0.isPlay_ = false
	slot0.auto_time = 0
	slot0.time_ = 0
	slot0.duration_ = 0
	slot0.gameObject_ = nil
	slot0.stage_ = slot1
	slot0.stage_.name = "StoryStage"
	slot0.state_ = ""
	slot0.auto_ = false
	slot0.curStory_ = nil
	slot0.onSingleLineFinish_ = nil
	slot0.onSingleLineUpdate_ = nil
	slot0.onStoryFinished_ = nil
	slot0.playNext_ = nil
	slot0.bgs_ = {}
	slot0.actors_ = {}
	slot0.spriteActors_ = {}
	slot0.CriAtomExPlaybacks_ = {}
	slot0.timelineDirector = {}
	slot0.keyword = {
		nickname = PlayerData:GetPlayerInfo().nick
	}

	slot0:InitUI()
	slot0:InitUIEvents()
end

function slot0.InitUI(slot0)
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/StoryUI"), manager.ui.uiStory.transform)
	slot0.transform_ = slot0.gameObject_.transform

	ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.gameObject_)

	slot0.historyTxt_.text = ""
	slot4 = "conName"
	slot0.iconController_ = ControllerUtil.GetController(slot0.iconTrs_, slot4)
	slot0.choices_ = {}

	for slot4 = 1, 3 do
		slot0.choices_[slot4] = {
			isShow = true,
			go = slot0["itemGo" .. slot4 .. "_"],
			txt = slot0["itemText" .. slot4 .. "_"]
		}
	end

	slot0.fswtw_ = slot0.typeWritterGo_:GetComponent("UITypewriterEffect")

	slot0.fswbg_:SetActive(false)

	if SceneSetting.Current then
		slot0.sceneSettingEffect_ = SceneSetting.Current

		slot0.sceneSettingGo_:SetActive(false)
	else
		slot0.sceneSettingGo_:SetActive(true)
	end

	slot0.screenFilterGo_:SetActive(false)

	slot0.screenFilterEffect_ = slot0.screenFilterGo_:GetComponent("Volume")
	slot0.typewritter = slot0.text_.gameObject:GetComponent("UITypewriterEffect")
	slot0.dialogCg_.alpha = 0
	slot0.blackMask_.alpha = 0
	slot0.blackMask_.blocksRaycasts = false

	slot0:ShowNextGo(false)
end

function slot0.InitUIEvents(slot0)
	slot0:AddBtnListener(slot0.allBtn_, nil, function ()
		uv0:OnClickBtnAll()
	end)
	slot0:AddBtnListener(slot0.hideBtn_, nil, function ()
		if uv0.auto_ then
			uv0.auto_ = false

			SetActive(uv0.autoBtnGo_, true)
			SetActive(uv0.manulBtnGo_, false)
		end

		if uv0.state_ ~= "waiting" then
			return
		end

		uv0.state_ = "hiding"
		uv0.isPlay_ = false

		SetActive(uv0.dialog_, false)
		SetActive(uv0.btns_, false)

		uv0.fullScreenWordFlag_ = uv0.fswbg_.activeSelf

		SetActive(uv0.fswbg_, false)

		slot1 = nil

		SDKTools.SendMessageToSDK("story_oper", {
			oper = StoryOperDefine.HIDE,
			is_first = PlayerData:GetStoryList()[uv0.curStory_.id] and 0 or 1,
			story_id = uv0.curStory_.id
		})
	end)
	slot0:AddBtnListener(slot0.autoBtn_, nil, function ()
		uv0.auto_ = true

		SetActive(uv0.autoBtnGo_, false)
		SetActive(uv0.manulBtnGo_, true)

		slot1 = nil

		SDKTools.SendMessageToSDK("story_oper", {
			oper = StoryOperDefine.AUTO,
			is_first = PlayerData:GetStoryList()[uv0.curStory_.id] and 0 or 1,
			story_id = string.format(uv0.curStory_.id)
		})
	end)
	slot0:AddBtnListener(slot0.manualBtn_, nil, function ()
		uv0.auto_ = false

		SetActive(uv0.autoBtnGo_, true)
		SetActive(uv0.manulBtnGo_, false)
	end)
	SetActive(slot0.history_, true)
	SetActive(slot0.history_, false)
	slot0:AddBtnListener(slot0.lastBtn_, nil, function ()
		uv0.isPlay_ = false

		SetActive(uv0.history_, true)
		SetActive(uv0.btns_, false)

		uv0.historyRect_.verticalNormalizedPosition = 0
		slot1 = nil

		SDKTools.SendMessageToSDK("story_oper", {
			oper = StoryOperDefine.REPLAY,
			is_first = PlayerData:GetStoryList()[uv0.curStory_.id] and 0 or 1,
			story_id = string.format(uv0.curStory_.id)
		})
	end)

	slot4 = slot0.historyBtn_

	slot0:AddBtnListener(slot4, nil, function ()
		uv0.isPlay_ = true

		SetActive(uv0.history_, false)
		SetActive(uv0.btns_, true)
	end)

	for slot4 = 1, 3 do
		slot0:AddBtnListener(slot0["itemBtn" .. slot4 .. "_"], nil, function ()
			manager.story:SetStoryChoice(uv0)
			uv1.playNext_(uv0)
			SetActive(uv1.choicesGo_, false)
		end)
	end

	slot0:AddBtnListener(slot0.skipBtn_, nil, function ()
		uv0:Skip()
	end)
	slot0:AddBtnListener(slot0.narrativeSkipBtn_, nil, function ()
		uv0.onStoryFinished_(true)
	end)
	slot0:AddBtnListener(slot0.narrativeExitBtn_, nil, function ()
		uv0.onStoryFinished_(true)
	end)
	slot0:AddBtnListener(slot0.narrativeContinueBtn_, nil, function ()
		uv0.onStoryFinished_(true)
	end)
end

function slot0.OnClickBtnAll(slot0)
	if slot0.state_ == "hiding" then
		slot0.state_ = "waiting"
		slot0.isPlay_ = true

		SetActive(slot0.dialog_, true)
		SetActive(slot0.btns_, true)
		SetActive(slot0.fswbg_, slot0.fullScreenWordFlag_ and true)

		if slot0.fullScreenWordFlag_ == true then
			SetActive(slot0.dialog_, false)
		end
	elseif slot0.state_ == "waiting" and not slot0.choicesGo_.activeSelf then
		slot0.playNext_(1)
	elseif slot0.dialogNext_.activeSelf and slot0.typewriterNext_.activeSelf and not slot0.choicesGo_.activeSelf then
		slot0:JumpToEnd()
		slot0.playNext_(1)
	elseif slot0.state_ == "playing" then
		slot0:JumpToEnd()
	end
end

function slot0.JumpToEnd(slot0)
	for slot5 = 1, (slot0.duration_ - slot0.time_) / 0.033 + 1 do
		slot0:Update(0.033)
	end
end

function slot0.Skip(slot0, slot1)
	slot1 = slot1 or StoryOperDefine.PASS
	slot2 = slot0.curStory_.name
	slot0.isPlay_ = false
	slot0.auto_ = false

	if slot0.curStory_.desc and slot3 ~= "" then
		if slot0.skipView_ then
			slot0.skipView_:Dispose()

			slot0.skipView_ = nil
		end

		for slot7, slot8 in pairs(slot0.CriAtomExPlaybacks_) do
			if slot8 then
				slot8:Stop()
			end
		end

		slot4 = manager.audio

		slot4:ClearBGMFlag()

		slot0.skipView_ = StoryKipView.New(Object.Instantiate(Asset.Load("UI/PopUp/StorySkipUI"), manager.ui.uiStory.transform))
		slot6 = slot0.skipView_

		slot6:SetContentTitle(slot2, slot3)

		slot6 = slot0.skipView_

		slot6:SetCallback(handler(slot0, function ()
			slot1 = nil

			SDKTools.SendMessageToSDK("story_oper", {
				oper = uv1,
				is_first = PlayerData:GetStoryList()[uv0.curStory_.id] and 0 or 1,
				story_id = string.format(uv0.curStory_.id)
			})

			if BirthdayCfg.get_id_list_by_story_id[uv0.curStory_.id] and slot1 == 1 then
				SDKTools.SendMessageToSDK("birthday_viewed", {
					story_skip = 1
				})
			end

			uv0.onStoryFinished_(true)
		end))
	else
		slot5 = nil

		SDKTools.SendMessageToSDK("story_oper", {
			oper = slot1,
			is_first = PlayerData:GetStoryList()[slot0.curStory_.id] and 0 or 1,
			story_id = string.format(slot0.curStory_.id)
		})

		if BirthdayCfg.get_id_list_by_story_id[slot0.curStory_.id] and slot5 == 1 then
			SDKTools.SendMessageToSDK("birthday_viewed", {
				story_skip = 1
			})
		end

		slot0.onStoryFinished_(true)
	end

	slot0:AddBtnListener(slot0.narrativeExitBtn_, nil, function ()
		uv0.onStoryFinished_(true)
	end)
end

function slot0.SetGaussion(slot0, slot1)
	slot0:SetGaussionBg(slot1)
	manager.ui:SetUISeparateRender(slot1)
	SetActive(slot0.gaussionBgGo_, slot1)
end

function slot0.ShowNextGo(slot0, slot1)
	SetActive(slot0.dialogNext_, slot1)
	SetActive(slot0.typewriterNext_, slot1)
end

function slot0.Update(slot0, slot1)
	if not slot0.isPlay_ then
		return
	end

	if slot0.state_ ~= "pause" then
		slot0.time_ = slot0.time_ + slot1
	end

	if slot0.onSingleLineUpdate_ then
		slot0.onSingleLineUpdate_(slot1)
	end

	if slot0.duration_ < slot0.time_ and slot0.onSingleLineFinish_ then
		slot0.onSingleLineFinish_()

		if slot0.duration_ < 2 then
			slot0.auto_time = 2 - slot0.duration_
		end

		slot0.auto_time = slot0.auto_time + 1
	end

	if slot0.state_ == "waiting" and slot0.playNext_ and slot0.auto_ then
		if slot0.auto_time <= 0 and not slot0.choicesGo_.activeSelf then
			slot0.playNext_(1)

			slot0.auto_time = 0
		else
			slot0.auto_time = slot0.auto_time - slot1
		end
	end
end

function slot0.FormatText(slot0, slot1)
	return slot0:ReplaceSpace(string.gsub(GetI18NText(slot1), "#{(%w+)}#", function (slot0)
		if uv0.keyword[slot0] then
			return slot1
		else
			return slot0
		end
	end))
end

function slot0.ReplaceSpace(slot0, slot1)
	return slot1
end

function slot0.RecordName(slot0, slot1)
	slot2 = "<size=32><color=#2ea9f6>【" .. slot1 .. "】</color></size>\n"

	if SettingData:GetCurrentLanguage() == "kr" then
		slot2 = "<size=32><color=#2ea9f6>[" .. slot1 .. "]</color></size>\n"
	end

	slot0:RecordHistory(slot2)
end

function slot0.RecordContent(slot0, slot1)
	slot0:RecordHistory(slot1 .. "\n\n")
end

function slot0.RecordHistory(slot0, slot1)
	slot0.historyTxt_.text = slot0.historyTxt_.text .. slot1
end

function slot0.GetFullAwbName(slot0, slot1)
	if slot1 ~= "" then
		slot1 = string.format("%s.awb", tostring(slot1))
	end

	return slot1
end

function slot0.AudioAction(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot1 == "play" then
		if slot2 == "voice" then
			slot0.CriAtomExPlaybacks_[slot4] = manager.audio:PlayVoice(slot3, slot4, slot0:GetFullAwbName(slot5))
		elseif slot2 == "music" then
			slot0.CriAtomExPlaybacks_[slot4] = manager.audio:PlayBGM(slot3, slot4, slot0:GetFullAwbName(slot5))
		elseif slot2 == "effect" then
			slot0.CriAtomExPlaybacks_[slot4] = manager.audio:PlayEffect(slot3, slot4, slot0:GetFullAwbName(slot5))
		end
	end

	if slot0.CriAtomExPlaybacks_[slot4] then
		if slot1 == "pause" then
			slot6:Pause()
		elseif slot1 == "resume" then
			slot6:Resume(CriAtomEx.ResumeMode.AllPlayback)
		elseif slot1 == "stop" then
			slot6:Stop()
		elseif slot1 == "forcestop" then
			slot6:Stop(true)
		end
	end
end

function slot0.ShowWeapon(slot0, slot1, slot2)
	LuaForUtil.ShowWeapon(slot1, slot2)
end

function slot0.CheckSpriteTmpPos(slot0, slot1, slot2)
	slot0.spriteActors_[slot1] = slot2

	for slot6, slot7 in pairs(slot0.spriteActors_) do
		if slot6 ~= slot1 and slot7 == slot2 and not isNil(slot0.actors_[slot6]) then
			slot0.actors_[slot6]:SetActive(false)
		end
	end

	if not isNil(slot0.actors_[slot1]) then
		slot0.actors_[slot1]:SetActive(true)
	end
end

function slot0.PlayTimeline(slot0, slot1, slot2)
	if slot0.actors_[slot1] == nil then
		slot3 = Object.Instantiate(Asset.Load("Char/" .. slot1), slot0.stage_.transform)
		slot3.name = slot1
		slot3.transform.localPosition = Vector3.New(0, 100, 0)
		slot0.actors_[slot1] = slot3

		if slot3.transform:Find("Directional Light") then
			SetActive(slot4.gameObject, false)
		end

		slot3:GetComponentInChildren(typeof(CharacterEffect)).enabled = true

		if GameObjectTools.GetOrAddComponent(slot3, typeof(DynamicBoneHelper)) then
			slot6:EnableDynamicBone(false)
		end

		slot0:ShowWeapon(slot5.transform, false)

		slot0.var_[slot1 .. "Animator"] = slot5.gameObject:GetComponent(typeof(UnityEngine.Animator))

		if slot4 then
			-- Nothing
		end

		slot0.var_[slot1 .. "Animator"].applyRootMotion = true
		slot0.var_[slot1 .. "LipSync"] = slot5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
	end

	slot4 = Asset.InstantiateWithoutCache(slot2)

	slot4.transform:SetParent(slot0.actors_[slot1].transform)

	slot6 = slot0.var_[slot1 .. "Animator"]
	slot7 = slot0.var_[slot1 .. "LipSync"]

	if slot4.transform:Find("Timeline").gameObject:GetComponent("PlayableDirector") then
		for slot13 = 0, slot5.playableAsset.outputTrackCount - 1 do
			if (slot8:GetOutputTrack(slot13).name == "Animator" or slot15 == "Animator Track") and slot6 then
				slot5:SetGenericBinding(slot14, slot6)

				if slot0.var_[slot1 .. "timelineAnimator"] then
					Object.Destroy(slot0.var_[slot1 .. "timelineAnimator"])
				end

				slot0.var_[slot1 .. "timelineAnimator"] = slot4
			elseif slot15 == "LipSync" and slot7 then
				slot5:SetGenericBinding(slot14, slot7)
			elseif slot15 == "Story Timeline Enable Render Track" then
				slot5:SetGenericBinding(slot14, slot3)
			end
		end

		slot5.time = 0

		slot5:Play()

		slot5.stopped = slot5.stopped + function (slot0)
			Object.Destroy(slot0.transform.parent.gameObject, 0.1)
		end

		table.insert(slot0.timelineDirector, slot5)
	end
end

function slot0.Dispose(slot0)
	if not isNil(slot0.sceneSettingEffect_) then
		slot0.sceneSettingEffect_.enabled = true
	end

	for slot4, slot5 in pairs(slot0.timelineDirector) do
		if not isNil(slot5) then
			slot5:Stop()
		end
	end

	slot0.timelineDirector = {}

	if slot0.gameObject_ then
		Object.Destroy(slot0.gameObject_)

		slot0.gameObject_ = nil
	end

	for slot4, slot5 in pairs(slot0.bgs_) do
		if slot5 then
			Object.Destroy(slot5)
		end
	end

	for slot4, slot5 in pairs(slot0.actors_) do
		if slot5 then
			Object.Destroy(slot5)
		end
	end

	if slot0.stage_ then
		Object.Destroy(slot0.stage_, 1)

		slot0.stage_ = nil
	end

	for slot4, slot5 in pairs(slot0.CriAtomExPlaybacks_) do
		if slot5 then
			slot5:Stop()
		end
	end

	manager.audio:ClearBGMFlag()

	for slot4, slot5 in pairs(slot0.var_) do
		if slot5 and type(slot5) == "userdata" and string.find(slot4, "effect") then
			Object.Destroy(slot5)
		end
	end

	if slot0.skipView_ then
		slot0.skipView_:Dispose()

		slot0.skipView_ = nil
	end

	slot0.CriAtomExPlaybacks_ = {}
	slot0.isPlay_ = false
	slot0.auto_ = false
	slot0.time_ = 0
	slot0.duration_ = 0
	slot0.state_ = ""
	slot0.curStory_ = nil
	slot0.onSingleLineFinish_ = nil
	slot0.onSingleLineUpdate_ = nil
	slot0.onStoryFinished_ = nil
	slot0.playNext_ = nil
	slot0.bgs_ = {}
	slot0.actors_ = {}
	slot0.var_ = {}
	slot0.spriteActors_ = {}

	uv0.super.Dispose(slot0)
	slot0:AudioAction("play", "voice", "story_v_empty", "empty", "")
end

function slot0.HideSkipBtn(slot0, slot1)
	SetActive(slot0.skipBtn_.gameObject, not slot1)
end

function slot0.Play(slot0, slot1)
	slot0.var_ = {}
	slot2 = _G["Story" .. slot1]
	slot0.curStory_ = StoryCfg[slot1]
	slot3 = slot0.curStory_.start

	slot2["Play" .. slot3](slot2, slot0)

	slot0.isPlay_ = true

	manager.story:ResetStoryChoice()
	print("开始播放 " .. slot1 .. ", " .. slot3)
end

function slot0.RecordAudio(slot0, slot1, slot2)
	slot0.CriAtomExPlaybacks_[slot1] = slot2
end

return slot0
