slot0 = class("MatrixHeroAttributePage", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.nullController_ = ControllerUtil.GetController(slot0.transform_, "null")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.detailView_ = WeaponServantDetailView.New(slot0.m_detailGo)
end

function slot0.SetMatirxHeroInfo(slot0, slot1)
	slot0.heroId_ = slot1

	if slot0:GetHeroData(slot1):GetWeaponServantEffect() ~= 0 then
		slot0.detailView_:SetWeaponServantData({
			locked = 0,
			uid = 0,
			id = slot3,
			stage = slot2:GetWeaponServantEffectLevel()
		})
		slot0.nullController_:SetSelectedIndex(0)

		slot0.m_countLab.text = "1/1"
	else
		slot0.nullController_:SetSelectedIndex(1)

		slot0.m_countLab.text = "0/1"
	end
end

function slot0.OnEnter(slot0)
	if slot0.detailView_ then
		slot0.detailView_:OnEnter()
	end
end

function slot0.OnExit(slot0)
	if slot0.detailView_ then
		slot0.detailView_:OnExit()
	end
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.Show(slot0)
	SetActive(slot0.gameObject_, true)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.handler_ = nil

	if slot0.detailView_ then
		slot0.detailView_:Dispose()

		slot0.detailView_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.GetHeroData(slot0, slot1)
	return MatrixData:GetHeroData(slot1)
end

return slot0
