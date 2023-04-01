slot0 = class("SourceItem", ReduxView)
slot1 = import("game.tools.JumpTools")

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.info_ = slot3

	slot0:InitUI()
	slot0:Init()
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.info_ = slot2

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0.bg_ = slot0:FindCom(typeof(Image), "main/bg")
	slot0.icon_ = slot0:FindCom(typeof(Image), "main/bg/icon")
	slot0.title1_ = slot0:FindCom(typeof(Text), "main/bg/title1")
	slot0.title2_ = slot0:FindCom(typeof(Text), "main/bg/title2")
	slot0.midImage_ = slot0:FindCom(typeof(Image), "main/bg/image")
	slot0.goImage_ = slot0:FindCom(typeof(Image), "main/bg/goimg")
	slot0.goGo_ = slot0:FindGo("main/bg/goimg")
	slot0.invalidGo_ = slot0:FindGo("main/bg/invalid")
	slot0.lockGo_ = slot0:FindGo("main/bg/lock")

	slot0:AddBtnListener(nil, , "OnClick")
end

function slot0.Init(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot0.title2_.text, slot0.title1_.text = uv0.GetName(slot1)

		slot0:RefreshType()
	end
end

function slot0.RefreshType(slot0)
	if SystemLinkCfg[slot0.info_[1]].text_invalid ~= 0 then
		slot0.bg_.sprite = getSprite("Atlas/NewPopUI", "board_access_arrow_02")
		slot0.bg_.color = Color.New(1, 1, 1, 1)
		slot0.icon_.color = Color.New(0.3333, 0.3725, 0.3803, 1)
		slot0.midImage_.color = Color.New(0.7607, 0.8313, 0.8392, 1)
		slot0.title1_.color = Color.New(0.3333, 0.3725, 0.3803, 1)
		slot0.title2_.color = Color.New(0.3333, 0.3725, 0.3803, 1)

		SetActive(slot0.goGo_, false)
		SetActive(slot0.invalidGo_, true)
		SetActive(slot0.lockGo_, false)
	elseif uv0.GetLinkIsLocked(slot1) then
		slot0.bg_.sprite = getSprite("Atlas/NewPopUI", "board_access_arrow_02")
		slot0.bg_.color = Color.New(1, 1, 1, 1)
		slot0.icon_.color = Color.New(0.5372, 0.5843, 0.5843, 1)
		slot0.midImage_.color = Color.New(0.4666, 0.5254, 0.5372, 0.2)
		slot0.title1_.color = Color.New(0.4666, 0.5254, 0.5372, 0.9019608)
		slot0.title2_.color = Color.New(0.4666, 0.5254, 0.5372, 0.9019608)

		SetActive(slot0.goGo_, false)
		SetActive(slot0.invalidGo_, false)
		SetActive(slot0.lockGo_, true)
	else
		slot0.bg_.sprite = getSprite("Atlas/NewPopUI", "board_access_arrow_white")
		slot0.bg_.color = Color.New(0.1137, 0.1098, 0.0901, 1)
		slot0.icon_.color = Color.New(0.5372, 0.5843, 0.5843, 1)
		slot0.midImage_.color = Color.New(0.247, 0.2627, 0.2666, 1)
		slot0.title2_.color = Color.New(0.7568, 0.8392, 0.8509, 1)
		slot0.title1_.color = Color.New(0.7568, 0.8392, 0.8509, 1)

		SetActive(slot0.goGo_, true)
		SetActive(slot0.invalidGo_, false)
		SetActive(slot0.lockGo_, false)
	end
end

function slot0.OnClick(slot0)
	if slot0.clickFunc then
		slot0.clickFunc(slot0.info_)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
