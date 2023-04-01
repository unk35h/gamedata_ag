slot0 = class("SubtitleBubble", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
end

function slot0.Init(slot0)
	slot0.bubbles = {}
	slot0.curPlaying = {}
end

function slot0.OnEnter(slot0)
	slot0:RegistEventListener(DORM_CHARACTER_PLAY_SUBTITLE_SEQ, handler(slot0, slot0.OnPlaySubtitleSeq))
	slot0:RegistEventListener(DORM_CHARACTER_PLAY_SUBTITLE, handler(slot0, slot0.OnPlaySubtitle))
	slot0:RegistEventListener(DORM_CHARACTER_DISPOSE, handler(slot0, slot0.OnEntityDispose))
end

function slot0.OnExit(slot0)
	for slot4, slot5 in pairs(slot0.bubbles) do
		slot5:Dispose()
	end

	slot0.bubbles = {}

	for slot4, slot5 in pairs(slot0.curPlaying) do
		slot5:Abort()
	end

	slot0.curPlaying = {}

	slot0:RemoveAllEventListener()
end

function slot0.GetBubble(slot0, slot1)
	if not slot0.bubbles[slot1] then
		slot3 = GameObject.Instantiate(slot0.bubblePrefab, slot0.bubbleRoot)
		slot0.bubbles[slot1] = BubbleItem.New(slot3)

		slot3:SetActive(true)
	end

	return slot2
end

function slot0.OnPlaySubtitleSeq(slot0, slot1, slot2)
	slot3 = DormCharacterActionManager.frameTaskRunner:NewTask()

	DormLuaBridge.SetUIFollow(slot0:GetBubble(slot1).transform_, slot1, "gua_Hp")

	if slot0.curPlaying[slot1] then
		slot0.curPlaying[slot1]:Abort()
	end

	for slot10 = 0, slot2.Length - 1 do
		slot12 = slot3:WaitForSec(slot2[slot10].time)

		slot12:Then(function ()
			uv0:ShowSubtitle(uv1, uv2.subtitleID)
		end)
	end

	slot0.curPlaying[slot1] = slot3

	slot3:Start()
end

function slot0.OnPlaySubtitle(slot0, slot1, slot2)
	DormLuaBridge.SetUIFollow(slot0:GetBubble(slot1).transform_, slot1, "gua_Hp")

	if slot0.curPlaying[slot1] then
		slot0.curPlaying[slot1]:Abort()

		slot0.curPlaying[slot1] = nil
	end

	slot3:ShowSubtitle(slot1, slot2)
end

function slot0.OnEntityDispose(slot0, slot1)
	if slot0.bubbles[slot1] then
		slot2:Dispose()

		slot0.bubbles[slot1] = nil
	end
end

return slot0
