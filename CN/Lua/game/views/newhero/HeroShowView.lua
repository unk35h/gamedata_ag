slot0 = class("HeroShowView", ReduxView)
slot1 = import("game.tools.HeroTools")
slot2 = import("game.const.HeroConst")

function slot0.UIName(slot0)
	return "UI/Common/HeroShowUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.InitUI(slot0)
	slot0.playable_ = slot0:FindCom(typeof(PlayableDirector), "")
	slot0.pinZhiGuang_ = slot0:FindCom(typeof(Image), "role/pinzhiguang")
	slot0.guangBan_ = slot0:FindCom(typeof(Image), "role/guangban")
	slot0.ghS_ = slot0:FindCom("Effect_distortion_add", "role/ghS")
	slot0.beiGuang_ = slot0:FindCom("Effect_distortion_add", "role/beiguang")
	slot0.icon_ = slot0:FindCom(typeof(Image), "role/lihui")
	slot0.rare_ = slot0:FindCom(typeof(Image), "role/pinji")
	slot0.rare2_ = slot0:FindCom(typeof(Image), "role/pinji/1")
	slot0.race_ = slot0:FindCom(typeof(Image), "role/zyBg/zy")
	slot0.name_ = slot0:FindCom(typeof(Text), "role/name")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener("bg", nil, function ()
		uv0:Back()
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot3 = HeroCfg[slot1]
	slot4 = ItemCfg[slot1].rare - 2
	slot0.pinZhiGuang_.color = uv0.HERO_RARE_COLOR[slot4]
	slot0.guangBan_.color = uv0.HERO_RARE_COLOR[slot4]
	slot0.ghS_._MainColor = uv0.HERO_RARE_COLOR[slot4]
	slot0.beiGuang_._MainColor = uv0.HERO_RARE_COLOR[slot4]
	slot0.icon_.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. SkinCfg[slot1].picture_id)
	slot0.rare_.sprite = getSprite("Atlas/NewCommon", "star" .. slot4)
	slot0.rare2_.sprite = getSprite("Atlas/NewCommon", "star" .. slot4)
	slot0.race_.sprite = getSprite("Atlas/CampItem", RaceEffectCfg[slot3.race].icon)
	slot0.name_.text = slot3.name
	slot0.playable_.time = slot2

	uv1.PlayTalk(slot1, "get")
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI(slot0.params_.heroId, slot0.params_.startTime or 5)
end

function slot0.OnExit(slot0)
	uv0.StopTalk()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

function slot0.Cacheable(slot0)
	return false
end

return slot0
