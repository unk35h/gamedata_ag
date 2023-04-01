ActionConst = import("game.ActionConst")

return bindActionCreators((function (slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0) do
		for slot10, slot11 in pairs(slot6) do
			slot1[slot10] = slot11
		end
	end

	return slot1
end)({
	import("game.actions.AchievementActionCreators"),
	import("game.actions.BattleFieldActionCreators"),
	import("game.actions.BulletinActionCreators"),
	import("game.actions.ChatActionCreators"),
	import("game.actions.CommonActionCreators"),
	import("game.actions.CurrencyActionCreators"),
	import("game.actions.EquipActionCreators"),
	import("game.actions.EnchantmentActionCreators"),
	import("game.actions.FriendActionCreators"),
	import("game.actions.HeroActionCreators"),
	import("game.actions.LoginActionCreators"),
	import("game.actions.MailActionCreators"),
	import("game.actions.MaterialActionCreators"),
	import("game.actions.PlayerInfoActionCreators"),
	import("game.actions.SettingActionCreators"),
	import("game.actions.ShopActionCreators"),
	import("game.actions.SignActionCreators"),
	import("game.actions.TeamActionCreators"),
	import("game.actions.HeroChatActionCreators"),
	import("game.actions.TineActionCreators")
}), gameStore.dispatch)
