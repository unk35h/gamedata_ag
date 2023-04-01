return {
	[10000] = {
		name = "新人入职限定探测",
		pool_type = 5,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
在「新人入职限定探测」中，10次探测只需使用<color=#FF9500>6</color>枚修正者探测凭证。
「新人入职限定探测」一共可进行20次，前<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级修正者<color=#FF9500>夜之寄生·霍德尔</color>。
若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 1,
		pool_selected_type = 0,
		exchange_id = 1180001,
		optional_groups = 0,
		optional_bgId = "",
		discount = 60,
		id = 10000,
		cost_once = {
			5,
			1
		},
		cost_ten_times = {
			5,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10001] = {
		name = "修正者常规探测",
		pool_type = 1,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
在修正者探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时将会重置当前探测种类已探测的次数。
若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 3,
		pool_selected_type = 0,
		exchange_id = 1180001,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10001,
		cost_once = {
			5,
			1
		},
		cost_ten_times = {
			5,
			10
		},
		cost_once_activity_material = {
			53004,
			1
		},
		cost_ten_times_activity_material = {
			53004,
			10
		}
	},
	[10002] = {
		name = "钥从常规探测",
		pool_type = 2,
		detail_note = [[
在钥从探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>4</color>星或以上品质钥从，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>5</color>星钥从。获得5星钥从时将会重置当前探测种类已探测的次数。
当探测获得4星钥从时，<color=#FF9500>必定</color>为当前选择的神系的钥从。
当探测获得5星钥从时，<color=#FF9500>必定</color>为当前选择的沉睡之子。

更换UP的钥从不会重置已探测的次数。

获得5星钥从时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得4星钥从时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出4星或以上品质钥从\n每70次探测必出5星钥从",
		pool_change = 0,
		order = 5,
		pool_selected_type = 9,
		exchange_id = 1180002,
		optional_groups = 2101,
		discount = 100,
		id = 10002,
		optional_lists = {
			200001,
			200002,
			200003,
			200004,
			200005,
			200009
		},
		optional_detail = {
			2510000,
			2520000,
			2530000,
			2540000,
			2550000,
			2590000
		},
		optional_bgId = {
			10007,
			10005,
			10002,
			10004,
			10006,
			10009
		},
		cost_once = {
			19,
			1
		},
		cost_ten_times = {
			19,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10003] = {
		name = "雷光的剑息",
		pool_type = 3,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
「雷光的剑息」活动探测开启。活动期间，<color=#FF9500>限定</color>S级修正者<color=#FF9500>「震离·月读」</color>以及A级修正者<color=#B67FE3>「低吹雪·利维坦」</color>、<color=#B67FE3>「真红·丰前坊天狗」</color>、<color=#B67FE3>「狂鳄·索贝克」</color>的探测获取概率<color=#FF9500>大幅提升</color>！
限定修正者不会进入「修正者共鸣」常规探测。

在「雷光的剑息」活动探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时，已探测的次数将重置为0，并重新开始计算。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「震离·月读」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。
当探测获得A级修正者时，有<color=#FF9500>90%</color>的概率为本期UP修正者<color=#B67FE3>「低吹雪·利维坦」</color>、<color=#B67FE3>「真红·丰前坊天狗」</color>、<color=#B67FE3>「狂鳄·索贝克」</color>中的一个（概率均等）。如果本次探测获得的A级修正者非本期UP的A级修正者，下次探测获得的A级修正者<color=#FF9500>必定</color>为本期UP的A级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

「雷光的剑息」属于精准探测，探测次数会一直累计在精准探测中，所有的精准探测将共享探测保底次数。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 2,
		pool_selected_type = 1,
		exchange_id = 1180003,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10003,
		cost_once = {
			38,
			1
		},
		cost_ten_times = {
			38,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10013] = {
		name = "绝处逢生魂",
		pool_type = 3,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
「绝处逢生魂」活动探测开启。活动期间，<color=#FF9500>限定</color>S级修正者<color=#FF9500>「生魂·奥西里斯」</color>以及A级修正者<color=#B67FE3>「旧誓·薇儿丹蒂」</color>、<color=#B67FE3>「雏心·奥西里斯」</color>、<color=#B67FE3>「夜之寄生·霍德尔」</color>的探测获取概率<color=#FF9500>大幅提升</color>！
限定修正者不会进入「修正者共鸣」常规探测。

在「绝处逢生魂」活动探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时，已探测的次数将重置为0，并重新开始计算。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「生魂·奥西里斯」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。
当探测获得A级修正者时，有<color=#FF9500>90%</color>的概率为本期UP修正者<color=#B67FE3>「旧誓·薇儿丹蒂」</color>、<color=#B67FE3>「雏心·奥西里斯」</color>、<color=#B67FE3>「夜之寄生·霍德尔」</color>中的一个（概率均等）。如果本次探测获得的A级修正者非本期UP的A级修正者，下次探测获得的A级修正者<color=#FF9500>必定</color>为本期UP的A级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

「绝处逢生魂」属于精准探测，探测次数会一直累计在精准探测中，所有的精准探测将共享探测保底次数。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 2,
		pool_selected_type = 1,
		exchange_id = 1180003,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10013,
		cost_once = {
			38,
			1
		},
		cost_ten_times = {
			38,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10023] = {
		name = "海拉池子",
		pool_type = 3,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
「永夜暗星」活动探测开启。活动期间，<color=#FF9500>限定</color>S级修正者<color=#FF9500>「暗星·海拉」</color>以及A级修正者<color=#B67FE3>「彗光·前鬼坊天狗」</color>、<color=#B67FE3>「疾风之枪·休」</color>、<color=#B67FE3>「朔望·月读」</color>的探测获取概率<color=#FF9500>大幅提升</color>！
限定修正者不会进入「修正者共鸣」常规探测。

在「永夜暗星」活动探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时，已探测的次数将重置为0，并重新开始计算。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「暗星·海拉」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。
当探测获得A级修正者时，有<color=#FF9500>90%</color>的概率为本期UP修正者<color=#B67FE3>「彗光·前鬼坊天狗」</color>、<color=#B67FE3>「疾风之枪·休」</color>、<color=#B67FE3>「朔望·月读」</color>中的一个（概率均等）。如果本次探测获得的A级修正者非本期UP的A级修正者，下次探测获得的A级修正者<color=#FF9500>必定</color>为本期UP的A级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

「永夜暗星」属于精准探测，探测次数会一直累计在精准探测中，所有的精准探测将共享探测保底次数。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 2,
		pool_selected_type = 1,
		exchange_id = 1180003,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10023,
		cost_once = {
			38,
			1
		},
		cost_ten_times = {
			38,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10033] = {
		name = "赫拉池子",
		pool_type = 3,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
「瞬息幻光」活动探测开启。活动期间，<color=#FF9500>限定</color>S级修正者<color=#FF9500>「黎幻·赫拉」</color>以及A级修正者<color=#B67FE3>「风行·赫尔墨斯」</color>、<color=#B67FE3>「寒霜之牙·维达尔」</color>、<color=#B67FE3>「羽灼·赫拉」</color>的探测获取概率<color=#FF9500>大幅提升</color>！
限定修正者不会进入「修正者共鸣」常规探测。

在「瞬息幻光」活动探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时，已探测的次数将重置为0，并重新开始计算。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「黎幻·赫拉」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。
当探测获得A级修正者时，有<color=#FF9500>90%</color>的概率为本期UP修正者<color=#B67FE3>「风行·赫尔墨斯」</color>、<color=#B67FE3>「寒霜之牙·维达尔」</color>、<color=#B67FE3>「羽灼·赫拉」</color>中的一个（概率均等）。如果本次探测获得的A级修正者非本期UP的A级修正者，下次探测获得的A级修正者<color=#FF9500>必定</color>为本期UP的A级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

「瞬息幻光」属于精准探测，探测次数会一直累计在精准探测中，所有的精准探测将共享探测保底次数。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 2,
		pool_selected_type = 1,
		exchange_id = 1180003,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10033,
		cost_once = {
			38,
			1
		},
		cost_ten_times = {
			38,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10043] = {
		name = "波涛的奔行",
		pool_type = 3,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
「波涛的奔行」活动探测开启。活动期间，<color=#FF9500>限定</color>S级修正者<color=#FF9500>「斩浪·丝卡蒂」</color>以及A级修正者<color=#B67FE3>「雷獠·伽梨」</color>、<color=#B67FE3>「低吹雪·利维坦」</color>、<color=#B67FE3>「光煌·阿波罗」</color>的探测获取概率<color=#FF9500>大幅提升</color>！
限定修正者不会进入「修正者共鸣」常规探测。

在「波涛的奔行」活动探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时，已探测的次数将重置为0，并重新开始计算。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「斩浪·丝卡蒂」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。
当探测获得A级修正者时，有<color=#FF9500>90%</color>的概率为本期UP修正者<color=#B67FE3>「雷獠·伽梨」</color>、<color=#B67FE3>「低吹雪·利维坦」</color>、<color=#B67FE3>「光煌·阿波罗」</color>中的一个（概率均等）。如果本次探测获得的A级修正者非本期UP的A级修正者，下次探测获得的A级修正者<color=#FF9500>必定</color>为本期UP的A级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

「波涛的奔行」属于精准探测，探测次数会一直累计在精准探测中，所有的精准探测将共享探测保底次数。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 2,
		pool_selected_type = 1,
		exchange_id = 1180003,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10043,
		cost_once = {
			38,
			1
		},
		cost_ten_times = {
			38,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10053] = {
		name = "鲸歌的鸣奏",
		pool_type = 3,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
「鲸歌的鸣奏」活动探测开启。活动期间，<color=#FF9500>限定</color>S级修正者<color=#FF9500>「逆潮·利维坦」</color>以及A级修正者<color=#B67FE3>「寒霜之牙·维达尔」</color>、<color=#B67FE3>「朔望·月读」</color>、<color=#B67FE3>「银臂·努阿达」</color>的探测获取概率<color=#FF9500>大幅提升</color>！
限定修正者不会进入「修正者共鸣」常规探测。

在「鲸歌的鸣奏」活动探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时，已探测的次数将重置为0，并重新开始计算。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「逆潮·利维坦」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。
当探测获得A级修正者时，有<color=#FF9500>90%</color>的概率为本期UP修正者<color=#B67FE3>「寒霜之牙·维达尔」</color>、<color=#B67FE3>「朔望·月读」</color>、<color=#B67FE3>「银臂·努阿达」</color>中的一个（概率均等）。如果本次探测获得的A级修正者非本期UP的A级修正者，下次探测获得的A级修正者<color=#FF9500>必定</color>为本期UP的A级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

「鲸歌的鸣奏」属于精准探测，探测次数会一直累计在精准探测中，所有的精准探测将共享探测保底次数。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 2,
		pool_selected_type = 1,
		exchange_id = 1180003,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10053,
		cost_once = {
			38,
			1
		},
		cost_ten_times = {
			38,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10011] = {
		name = "修正者常规探测",
		pool_type = 1,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
修正者探测限时UP开启。S级修正者<color=#FF9500>「逆潮·利维坦」</color>的探测获取概率<color=#FF9500>限时大幅提升</color>！

在修正者探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时将会重置当前探测种类已探测的次数。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「逆潮·利维坦」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

UP修正者的变更不会影响修正者探测的保底。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 3,
		pool_selected_type = 1,
		exchange_id = 1180001,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10011,
		cost_once = {
			5,
			1
		},
		cost_ten_times = {
			5,
			10
		},
		cost_once_activity_material = {
			53004,
			1
		},
		cost_ten_times_activity_material = {
			53004,
			10
		}
	},
	[10063] = {
		name = "缪斯茶会",
		pool_type = 3,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
「缪斯茶会」活动探测开启。活动期间，<color=#FF9500>精准扩充</color>S级修正者<color=#FF9500>「操偶师·哈迪斯」</color>以及A级修正者<color=#B67FE3>「小困·俄尼里伊」</color>、<color=#B67FE3>「羽灼·赫拉」</color>、<color=#B67FE3>「真红·丰前坊天狗」</color>的探测获取概率<color=#FF9500>大幅提升</color>！
精准扩充修正者始终可以在精准扩充探测中获取，但不会进入「修正者共鸣」常规探测。

在「缪斯茶会」活动探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时，已探测的次数将重置为0，并重新开始计算。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「操偶师·哈迪斯」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。
当探测获得A级修正者时，有<color=#FF9500>90%</color>的概率为本期UP修正者<color=#B67FE3>「小困·俄尼里伊」</color>、<color=#B67FE3>「羽灼·赫拉」</color>、<color=#B67FE3>「真红·丰前坊天狗」</color>中的一个（概率均等）。如果本次探测获得的A级修正者非本期UP的A级修正者，下次探测获得的A级修正者<color=#FF9500>必定</color>为本期UP的A级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

「缪斯茶会」属于精准扩充探测，所有的精准扩充探测和精准探测共享探测保底次数。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 2,
		pool_selected_type = 1,
		exchange_id = 1180003,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10063,
		cost_once = {
			38,
			1
		},
		cost_ten_times = {
			38,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10073] = {
		name = "旧时流萤",
		pool_type = 3,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
「旧时流萤」活动探测开启。活动期间，S级修正者<color=#FF9500>「流萤岚雾·休」</color>以及A级修正者<color=#B67FE3>「旧誓·薇儿丹蒂」</color>、<color=#B67FE3>「夜之寄生·霍德尔」</color>、<color=#B67FE3>「疾风之枪·休」</color>的探测获取概率<color=#FF9500>大幅提升</color>！

在「旧时流萤」活动探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时，已探测的次数将重置为0，并重新开始计算。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「流萤岚雾·休」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。
当探测获得A级修正者时，有<color=#FF9500>90%</color>的概率为本期UP修正者<color=#B67FE3>「旧誓·薇儿丹蒂」</color>、<color=#B67FE3>「夜之寄生·霍德尔」</color>、<color=#B67FE3>「疾风之枪·休」</color>中的一个（概率均等）。如果本次探测获得的A级修正者非本期UP的A级修正者，下次探测获得的A级修正者<color=#FF9500>必定</color>为本期UP的A级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

「旧时流萤」属于精准扩充探测，所有的精准扩充探测和精准探测将共享探测保底次数。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 2,
		pool_selected_type = 1,
		exchange_id = 1180003,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10073,
		cost_once = {
			38,
			1
		},
		cost_ten_times = {
			38,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10021] = {
		name = "修正者常规探测",
		pool_type = 1,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
修正者探测限时UP开启。S级修正者<color=#FF9500>「龙切·迦具土」</color>的探测获取概率<color=#FF9500>限时大幅提升</color>！

在修正者探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时将会重置当前探测种类已探测的次数。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「龙切·迦具土」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

UP修正者的变更不会影响修正者探测的保底。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 3,
		pool_selected_type = 1,
		exchange_id = 1180001,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10021,
		cost_once = {
			5,
			1
		},
		cost_ten_times = {
			5,
			10
		},
		cost_once_activity_material = {
			53005,
			1
		},
		cost_ten_times_activity_material = {
			53005,
			10
		}
	},
	[10031] = {
		name = "修正者常规探测",
		pool_type = 1,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
修正者探测限时UP开启。S级修正者<color=#FF9500>「流萤岚雾·休」</color>的探测获取概率<color=#FF9500>限时大幅提升</color>！

在修正者探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时将会重置当前探测种类已探测的次数。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「流萤岚雾·休」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

UP修正者的变更不会影响修正者探测的保底。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 3,
		pool_selected_type = 1,
		exchange_id = 1180001,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10031,
		cost_once = {
			5,
			1
		},
		cost_ten_times = {
			5,
			10
		},
		cost_once_activity_material = {
			53005,
			1
		},
		cost_ten_times_activity_material = {
			53005,
			10
		}
	},
	[10083] = {
		name = "雅典娜",
		pool_type = 3,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
「剑怅弦鸣」活动探测开启。活动期间，<color=#FF9500>精准扩充</color>S级修正者<color=#FF9500>「铃兰之弦·雅典娜」</color>以及A级修正者<color=#B67FE3>「启明·海姆达尔」</color>、<color=#B67FE3>「羽灼·赫拉」</color>、<color=#B67FE3>「银臂·努阿达」</color>的探测获取概率<color=#FF9500>大幅提升</color>！
精准扩充修正者始终可以在精准扩充探测中获取，但不会进入「修正者共鸣」常规探测。

在「剑怅弦鸣」活动探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时，已探测的次数将重置为0，并重新开始计算。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「铃兰之弦·雅典娜」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。
当探测获得A级修正者时，有<color=#FF9500>90%</color>的概率为本期UP修正者<color=#B67FE3>「启明·海姆达尔」</color>、<color=#B67FE3>「羽灼·赫拉」</color>、<color=#B67FE3>「银臂·努阿达」</color>中的一个（概率均等）。如果本次探测获得的A级修正者非本期UP的A级修正者，下次探测获得的A级修正者<color=#FF9500>必定</color>为本期UP的A级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

「剑怅弦鸣」属于精准扩充探测，所有的精准扩充探测和精准探测将共享探测保底次数。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 2,
		pool_selected_type = 1,
		exchange_id = 1180003,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10083,
		cost_once = {
			38,
			1
		},
		cost_ten_times = {
			38,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10041] = {
		name = "修正者常规探测",
		pool_type = 1,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
修正者探测限时UP开启。S级修正者<color=#FF9500>「熯天·提尔」</color>的探测获取概率<color=#FF9500>限时大幅提升</color>！

在修正者探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时将会重置当前探测种类已探测的次数。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「熯天·提尔」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

UP修正者的变更不会影响修正者探测的保底。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 3,
		pool_selected_type = 1,
		exchange_id = 1180001,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10041,
		cost_once = {
			5,
			1
		},
		cost_ten_times = {
			5,
			10
		},
		cost_once_activity_material = {
			53009,
			1
		},
		cost_ten_times_activity_material = {
			53009,
			10
		}
	},
	[10004] = {
		name = "震离、欧申纳斯",
		pool_type = 3,
		detail_note = [[
「风掠洋转」与「月华的剑语」活动探测开启。活动期间，管理员可<color=#FF9500>自选</color>任意活动探测参与，更换活动探测不会重置已探测次数。

<color=#295886>「风掠洋转」活动探测</color>
活动期间，S级修正者<color=#FF9500>「流转之洋·欧申纳斯」</color>以及A级修正者<color=#B67FE3>「沐风·恩利尔」</color>、<color=#B67FE3>「光煌·阿波罗」</color>、<color=#B67FE3>「真红·丰前坊天狗」</color>的探测获取概率<color=#FF9500>大幅提升</color>！
在「风掠洋转」活动探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时，已探测的次数将重置为0，并重新开始计算。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为当前自选活动探测的UP修正者<color=#FF9500>「流转之洋·欧申纳斯」</color>。如果本次探测获得的S级修正者非当前自选活动探测UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得当前自选活动探测UP的修正者。
当探测获得A级修正者时，有<color=#FF9500>90%</color>的概率为本期UP修正者<color=#B67FE3>「沐风·恩利尔」</color>、<color=#B67FE3>「光煌·阿波罗」</color>、<color=#B67FE3>「真红·丰前坊天狗」</color>中的一个（概率均等）。如果本次探测获得的A级修正者非本期UP的A级修正者，下次探测获得的A级修正者<color=#FF9500>必定</color>为本期UP的A级修正者。

<color=#295886>「月华的剑语」活动探测</color>
活动期间，<color=#FF9500>限定</color>S级修正者<color=#FF9500>「震离·月读」</color>以及A级修正者<color=#B67FE3>「沐风·恩利尔」</color>、<color=#B67FE3>「光煌·阿波罗」</color>、<color=#B67FE3>「真红·丰前坊天狗」</color>的探测获取概率<color=#FF9500>大幅提升</color>！
在「月华的剑语」活动探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时，已探测的次数将重置为0，并重新开始计算。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为当前自选活动探测的UP修正者<color=#FF9500>「震离·月读」</color>。如果本次探测获得的S级修正者非当前自选活动探测UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得当前自选活动探测UP的S级修正者。
当探测获得A级修正者时，有<color=#FF9500>90%</color>的概率为本期UP修正者<color=#B67FE3>「沐风·恩利尔」</color>、<color=#B67FE3>「光煌·阿波罗」</color>、<color=#B67FE3>「真红·丰前坊天狗」</color>中的一个（概率均等）。如果本次探测获得的A级修正者非本期UP的A级修正者，下次探测获得的A级修正者<color=#FF9500>必定</color>为本期UP的A级修正者。
在本期活动探测期间及结束后，<color=#FF9500>限定</color>S级修正者<color=#FF9500>「震离·月读」</color>始终可以在精准扩充探测中获取，但不会进入「修正者共鸣」常规探测。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

「风掠洋转」和「月华的剑语」均属于精准扩充探测，所有的精准扩充探测和精准探测共享探测保底次数。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 2,
		pool_selected_type = 2,
		exchange_id = 1180003,
		optional_groups = 1102,
		discount = 100,
		id = 10004,
		optional_lists = {
			400001,
			400002
		},
		optional_detail = {
			1067,
			1199
		},
		optional_bgId = {
			400001,
			400002
		},
		cost_once = {
			38,
			1
		},
		cost_ten_times = {
			38,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10051] = {
		name = "修正者常规探测",
		pool_type = 1,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
修正者探测限时UP开启。S级修正者<color=#FF9500>「流转之洋·欧申纳斯」</color>的探测获取概率<color=#FF9500>限时大幅提升</color>！

在修正者探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时将会重置当前探测种类已探测的次数。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「流转之洋·欧申纳斯」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

UP修正者的变更不会影响修正者探测的保底。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 3,
		pool_selected_type = 1,
		exchange_id = 1180001,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10051,
		cost_once = {
			5,
			1
		},
		cost_ten_times = {
			5,
			10
		},
		cost_once_activity_material = {
			53009,
			1
		},
		cost_ten_times_activity_material = {
			53009,
			10
		}
	},
	[10093] = {
		name = "陨铁星火",
		pool_type = 3,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
「陨铁星火」活动探测开启。活动期间，<color=#FF9500>精准扩充</color>S级修正者<color=#FF9500>「怒蛇·马尔杜克」</color>以及A级修正者<color=#B67FE3>「荒獠·金固」</color>、<color=#B67FE3>「低吹雪·利维坦」</color>、<color=#B67FE3>「雷獠·伽梨」</color>的探测获取概率<color=#FF9500>大幅提升</color>！
精准扩充修正者始终可以在精准扩充探测中获取，但不会进入「修正者共鸣」常规探测。

在「陨铁星火」活动探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时，已探测的次数将重置为0，并重新开始计算。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「怒蛇·马尔杜克」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。
当探测获得A级修正者时，有<color=#FF9500>90%</color>的概率为本期UP修正者<color=#B67FE3>「荒獠·金固」</color>、<color=#B67FE3>「低吹雪·利维坦」</color>、<color=#B67FE3>「雷獠·伽梨」</color>中的一个（概率均等）。如果本次探测获得的A级修正者非本期UP的A级修正者，下次探测获得的A级修正者<color=#FF9500>必定</color>为本期UP的A级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

「陨铁星火」属于精准扩充探测，所有的精准扩充探测和精准探测将共享探测保底次数。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 2,
		pool_selected_type = 1,
		exchange_id = 1180003,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10093,
		cost_once = {
			38,
			1
		},
		cost_ten_times = {
			38,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10061] = {
		name = "修正者常规探测",
		pool_type = 1,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
修正者探测限时UP开启。S级修正者<color=#FF9500>「障月·阿修罗」</color>的探测获取概率<color=#FF9500>限时大幅提升</color>！

在修正者探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时将会重置当前探测种类已探测的次数。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「障月·阿修罗」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

UP修正者的变更不会影响修正者探测的保底。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 3,
		pool_selected_type = 1,
		exchange_id = 1180001,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10061,
		cost_once = {
			5,
			1
		},
		cost_ten_times = {
			5,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10014] = {
		name = "幽魂倩影、启奏晨辉",
		pool_type = 3,
		detail_note = [[
「幽魂倩影」与「启奏晨辉」活动探测开启。活动期间，管理员可<color=#FF9500>自选</color>任意活动探测参与，更换活动探测不会重置已探测次数。

<color=#295886>「幽魂倩影」活动探测</color>
活动期间，S级修正者<color=#FF9500>「胡狼·阿努比斯」</color>以及A级修正者<color=#B67FE3>「灵猫·芭丝特」</color>、<color=#B67FE3>「狂鳄·索贝克」</color>、<color=#B67FE3>「风行·赫尔墨斯」</color>的探测获取概率<color=#FF9500>大幅提升</color>！
在「幽魂倩影」活动探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时，已探测的次数将重置为0，并重新开始计算。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为当前自选活动探测的UP修正者<color=#FF9500>「胡狼·阿努比斯」</color>。如果本次探测获得的S级修正者非当前自选活动探测UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得当前自选活动探测UP的修正者。
当探测获得A级修正者时，有<color=#FF9500>90%</color>的概率为本期UP修正者<color=#B67FE3>「灵猫·芭丝特」</color>、<color=#B67FE3>「狂鳄·索贝克」</color>、<color=#B67FE3>「风行·赫尔墨斯」</color>中的一个（概率均等）。如果本次探测获得的A级修正者非本期UP的A级修正者，下次探测获得的A级修正者<color=#FF9500>必定</color>为本期UP的A级修正者。

<color=#295886>「启奏晨辉」活动探测</color>
活动期间，<color=#FF9500>限定</color>S级修正者<color=#FF9500>「黎幻·赫拉」</color>以及A级修正者<color=#B67FE3>「灵猫·芭丝特」</color>、<color=#B67FE3>「狂鳄·索贝克」</color>、<color=#B67FE3>「风行·赫尔墨斯」</color>的探测获取概率<color=#FF9500>大幅提升</color>！
在「启奏晨辉」活动探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时，已探测的次数将重置为0，并重新开始计算。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为当前自选活动探测的UP修正者<color=#FF9500>「黎幻·赫拉」</color>。如果本次探测获得的S级修正者非当前自选活动探测UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得当前自选活动探测UP的S级修正者。
当探测获得A级修正者时，有<color=#FF9500>90%</color>的概率为本期UP修正者<color=#B67FE3>「灵猫·芭丝特」</color>、<color=#B67FE3>「狂鳄·索贝克」</color>、<color=#B67FE3>「风行·赫尔墨斯」</color>中的一个（概率均等）。如果本次探测获得的A级修正者非本期UP的A级修正者，下次探测获得的A级修正者<color=#FF9500>必定</color>为本期UP的A级修正者。
在本期活动探测期间及结束后，<color=#FF9500>限定</color>S级修正者<color=#FF9500>「黎幻·赫拉」</color>始终可以在精准扩充探测中获取，但不会进入「修正者共鸣」常规探测。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

「幽魂倩影」和「启奏晨辉」均属于精准扩充探测，所有的精准扩充探测和精准探测共享探测保底次数。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 2,
		pool_selected_type = 2,
		exchange_id = 1180003,
		optional_groups = 1102,
		discount = 100,
		id = 10014,
		optional_lists = {
			401001,
			401002
		},
		optional_detail = {
			1024,
			1138
		},
		optional_bgId = {
			401001,
			401002
		},
		cost_once = {
			38,
			1
		},
		cost_ten_times = {
			38,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10071] = {
		name = "修正者常规探测",
		pool_type = 1,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
修正者探测限时UP开启。S级修正者<color=#FF9500>「胡狼·阿努比斯」</color>的探测获取概率<color=#FF9500>限时大幅提升</color>！

在修正者探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时将会重置当前探测种类已探测的次数。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「胡狼·阿努比斯」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

UP修正者的变更不会影响修正者探测的保底。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 3,
		pool_selected_type = 1,
		exchange_id = 1180001,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10071,
		cost_once = {
			5,
			1
		},
		cost_ten_times = {
			5,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10103] = {
		name = "极昼的闪电宫",
		pool_type = 3,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
「极昼的闪电宫」活动探测开启。活动期间，<color=#FF9500>精准扩充</color>S级修正者<color=#FF9500>「轰雷·托尔」</color>以及A级修正者<color=#B67FE3>「彗光·前鬼坊天狗」</color>、<color=#B67FE3>「光煌·阿波罗」</color>、<color=#B67FE3>「启明·海姆达尔」</color>的探测获取概率<color=#FF9500>大幅提升</color>！
精准扩充修正者始终可以在精准扩充探测中获取，但不会进入「修正者共鸣」常规探测。

在「极昼的闪电宫」活动探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时，已探测的次数将重置为0，并重新开始计算。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「轰雷·托尔」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。
当探测获得A级修正者时，有<color=#FF9500>90%</color>的概率为本期UP修正者<color=#B67FE3>「彗光·前鬼坊天狗」</color>、<color=#B67FE3>「光煌·阿波罗」</color>、<color=#B67FE3>「启明·海姆达尔」</color>中的一个（概率均等）。如果本次探测获得的A级修正者非本期UP的A级修正者，下次探测获得的A级修正者<color=#FF9500>必定</color>为本期UP的A级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

「极昼的闪电宫」属于精准扩充探测，所有的精准扩充探测和精准探测将共享探测保底次数。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 2,
		pool_selected_type = 1,
		exchange_id = 1180003,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10103,
		cost_once = {
			38,
			1
		},
		cost_ten_times = {
			38,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10081] = {
		name = "修正者常规探测",
		pool_type = 1,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
修正者探测限时UP开启。S级修正者<color=#FF9500>「冰渊·波塞冬」</color>的探测获取概率<color=#FF9500>限时大幅提升</color>！

在修正者探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时将会重置当前探测种类已探测的次数。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「冰渊·波塞冬」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

UP修正者的变更不会影响修正者探测的保底。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 3,
		pool_selected_type = 1,
		exchange_id = 1180001,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10081,
		cost_once = {
			5,
			1
		},
		cost_ten_times = {
			5,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10113] = {
		name = "刺耳的安魂曲",
		pool_type = 3,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
「刺耳的安魂曲」活动探测开启。活动期间，<color=#FF9500>限定</color>S级修正者<color=#FF9500>「生魂·奥西里斯」</color>以及A级修正者<color=#B67FE3>「疾风之枪·休」</color>、<color=#B67FE3>「旧誓·薇儿丹蒂」</color>、<color=#B67FE3>「雏心·奥西里斯」</color>的探测获取概率<color=#FF9500>大幅提升</color>！

在「刺耳的安魂曲」活动探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时，已探测的次数将重置为0，并重新开始计算。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「生魂·奥西里斯」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。
当探测获得A级修正者时，有<color=#FF9500>90%</color>的概率为本期UP修正者<color=#B67FE3>「疾风之枪·休」</color>、<color=#B67FE3>「旧誓·薇儿丹蒂」</color>、<color=#B67FE3>「雏心·奥西里斯」</color>中的一个（概率均等）。如果本次探测获得的A级修正者非本期UP的A级修正者，下次探测获得的A级修正者<color=#FF9500>必定</color>为本期UP的A级修正者。
在本期活动探测期间及结束后，<color=#FF9500>限定</color>S级修正者<color=#FF9500>「生魂·奥西里斯」</color>始终可以在精准扩充探测中获取，但不会进入「修正者共鸣」常规探测。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

「刺耳的安魂曲」属于精准扩充探测，所有的精准扩充探测和精准探测将共享探测保底次数。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 2,
		pool_selected_type = 1,
		exchange_id = 1180003,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10113,
		cost_once = {
			38,
			1
		},
		cost_ten_times = {
			38,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10091] = {
		name = "修正者常规探测",
		pool_type = 1,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
修正者探测限时UP开启。S级修正者<color=#FF9500>「早樱·大国主」</color>的探测获取概率<color=#FF9500>限时大幅提升</color>！

在修正者探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时将会重置当前探测种类已探测的次数。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「早樱·大国主」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

UP修正者的变更不会影响修正者探测的保底。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 3,
		pool_selected_type = 1,
		exchange_id = 1180001,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10091,
		cost_once = {
			5,
			1
		},
		cost_ten_times = {
			5,
			10
		},
		cost_once_activity_material = {
			53018,
			1
		},
		cost_ten_times_activity_material = {
			53018,
			10
		}
	},
	[10123] = {
		name = "暗焰重燃",
		pool_type = 3,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
「暗焰重燃」活动探测开启。活动期间，<color=#FF9500>精准扩充</color>S级修正者<color=#FF9500>「烙焰·提尔」</color>以及A级修正者<color=#B67FE3>「启明·海姆达尔」</color>、<color=#B67FE3>「夜之寄生·霍德尔」</color>、<color=#B67FE3>「寒霜之牙·维达尔」</color>的探测获取概率<color=#FF9500>大幅提升</color>！
精准扩充修正者始终可以在精准扩充探测中获取，但不会进入「修正者共鸣」常规探测。

在「暗焰重燃」活动探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时，已探测的次数将重置为0，并重新开始计算。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「烙焰·提尔」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。
当探测获得A级修正者时，有<color=#FF9500>90%</color>的概率为本期UP修正者<color=#B67FE3>「启明·海姆达尔」</color>、<color=#B67FE3>「夜之寄生·霍德尔」</color>、<color=#B67FE3>「寒霜之牙·维达尔」</color>中的一个（概率均等）。如果本次探测获得的A级修正者非本期UP的A级修正者，下次探测获得的A级修正者<color=#FF9500>必定</color>为本期UP的A级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

「暗焰重燃」属于精准扩充探测，所有的精准扩充探测和精准探测将共享探测保底次数。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 2,
		pool_selected_type = 1,
		exchange_id = 1180003,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10123,
		cost_once = {
			38,
			1
		},
		cost_ten_times = {
			38,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10101] = {
		name = "修正者常规探测",
		pool_type = 1,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
修正者探测限时UP开启。S级修正者<color=#FF9500>「流萤岚雾·休」</color>的探测获取概率<color=#FF9500>限时大幅提升</color>！

在修正者探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时将会重置当前探测种类已探测的次数。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「流萤岚雾·休」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

UP修正者的变更不会影响修正者探测的保底。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 3,
		pool_selected_type = 1,
		exchange_id = 1180001,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10101,
		cost_once = {
			5,
			1
		},
		cost_ten_times = {
			5,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10133] = {
		name = "缪斯茶会",
		pool_type = 3,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
「缪斯茶会」活动探测开启。活动期间，<color=#FF9500>精准扩充</color>S级修正者<color=#FF9500>「操偶师·哈迪斯」</color>以及A级修正者<color=#B67FE3>「小困·俄尼里伊」</color>、<color=#B67FE3>「真红·丰前坊天狗」</color>、<color=#B67FE3>「朔望·月读」</color>的探测获取概率<color=#FF9500>大幅提升</color>！
精准扩充修正者始终可以在精准扩充探测中获取，但不会进入「修正者共鸣」常规探测。

在「缪斯茶会」活动探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时，已探测的次数将重置为0，并重新开始计算。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「操偶师·哈迪斯」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。
当探测获得A级修正者时，有<color=#FF9500>90%</color>的概率为本期UP修正者<color=#B67FE3>「小困·俄尼里伊」</color>、<color=#B67FE3>「真红·丰前坊天狗」</color>、<color=#B67FE3>「朔望·月读」</color>中的一个（概率均等）。如果本次探测获得的A级修正者非本期UP的A级修正者，下次探测获得的A级修正者<color=#FF9500>必定</color>为本期UP的A级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

「缪斯茶会」属于精准扩充探测，所有的精准扩充探测和精准探测将共享探测保底次数。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 2,
		pool_selected_type = 1,
		exchange_id = 1180003,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10133,
		cost_once = {
			38,
			1
		},
		cost_ten_times = {
			38,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10111] = {
		name = "修正者常规探测",
		pool_type = 1,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
修正者探测限时UP开启。S级修正者<color=#FF9500>「觅影·国常立」</color>的探测获取概率<color=#FF9500>限时大幅提升</color>！

在修正者探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时将会重置当前探测种类已探测的次数。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「觅影·国常立」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

UP修正者的变更不会影响修正者探测的保底。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 3,
		pool_selected_type = 1,
		exchange_id = 1180001,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10111,
		cost_once = {
			5,
			1
		},
		cost_ten_times = {
			5,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10024] = {
		name = "自选UP池",
		pool_type = 3,
		detail_note = [[
「自选扩充探测」活动探测开启。活动期间，管理员可以在<color=#FF9500>「胡狼·阿努比斯」</color>、<color=#FF9500>「黎幻·赫拉」</color>、<color=#FF9500>「流萤岚雾·休」</color>、<color=#FF9500>「早樱·大国主」</color>、<color=#FF9500>「觅影·国常立」</color>、<color=#FF9500>「障月·阿修罗」</color>、<color=#FF9500>「龙切·迦具土」</color>、<color=#FF9500>「冰渊·波塞冬」</color>、<color=#FF9500>「熯天·提尔」</color>、<color=#FF9500>「逆潮·利维坦」</color>、<color=#FF9500>「操偶师·哈迪斯」</color>、<color=#FF9500>「铃兰之弦·雅典娜」</color>、<color=#FF9500>「震离·月读」</color>、<color=#FF9500>「流转之洋·欧申纳斯」</color>、<color=#FF9500>「怒蛇·马尔杜克」</color>中选择一位S级修正者使其探测获取概率<color=#FF9500>大幅提升</color>！
在「自选扩充探测」中，管理员可以更换UP修正者，本次活动探测期间最多可更换<color=#FF9500>5</color>次。更换UP修正者不会重置已探测次数。
 
在「自选扩充探测」活动探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时，已探测的次数将重置为0，并重新开始计算。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为当前自选活动探测的UP修正者。如果本次探测获得的S级修正者非当前自选活动探测UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得当前自选活动探测UP的S级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

「自选扩充探测」属于精准扩充探测，所有的精准扩充探测和精准探测共享探测保底次数。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 6,
		order = 3,
		pool_selected_type = 2,
		exchange_id = 1180003,
		optional_groups = 1102,
		optional_bgId = "",
		discount = 100,
		id = 10024,
		optional_lists = {
			150001,
			150002,
			150003,
			150004,
			150005,
			150006,
			150007,
			150008,
			150009,
			150010,
			150011,
			150012,
			150013,
			150014,
			150015
		},
		optional_detail = {
			1024,
			1138,
			1119,
			1066,
			1093,
			1013,
			1058,
			1139,
			1032,
			1127,
			1042,
			1041,
			1199,
			1067,
			1052
		},
		cost_once = {
			38,
			1
		},
		cost_ten_times = {
			38,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10143] = {
		name = "丹焰还真",
		pool_type = 3,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
「丹焰还真」活动探测开启。活动期间，<color=#FF9500>精准扩充</color>S级修正者<color=#FF9500>「澄心·陵光」</color>以及A级修正者<color=#B67FE3>「羽灼·赫拉」</color>、<color=#B67FE3>「雷獠·伽梨」</color>、<color=#B67FE3>「灵猫·芭丝特」</color>的探测获取概率<color=#FF9500>大幅提升</color>！
精准扩充修正者始终可以在精准扩充探测中获取，但不会进入「修正者共鸣」常规探测。

在「丹焰还真」活动探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时，已探测的次数将重置为0，并重新开始计算。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「澄心·陵光」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。
当探测获得A级修正者时，有<color=#FF9500>90%</color>的概率为本期UP修正者<color=#B67FE3>「羽灼·赫拉」</color>、<color=#B67FE3>「雷獠·伽梨」</color>、<color=#B67FE3>「灵猫·芭丝特」</color>中的一个（概率均等）。如果本次探测获得的A级修正者非本期UP的A级修正者，下次探测获得的A级修正者<color=#FF9500>必定</color>为本期UP的A级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

「丹焰还真」属于精准扩充探测，所有的精准扩充探测和精准探测将共享探测保底次数。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 2,
		pool_selected_type = 1,
		exchange_id = 1180003,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10143,
		cost_once = {
			38,
			1
		},
		cost_ten_times = {
			38,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10121] = {
		name = "修正者常规探测",
		pool_type = 1,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
修正者探测限时UP开启。S级修正者<color=#FF9500>「十曜·金乌」</color>的探测获取概率<color=#FF9500>限时大幅提升</color>！

在修正者探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时将会重置当前探测种类已探测的次数。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「十曜·金乌」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

UP修正者的变更不会影响修正者探测的保底。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 4,
		pool_selected_type = 1,
		exchange_id = 1180001,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10121,
		cost_once = {
			5,
			1
		},
		cost_ten_times = {
			5,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10153] = {
		name = "玉龙吟风",
		pool_type = 3,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
「玉龙吟风」活动探测开启。活动期间，<color=#FF9500>精准扩充</color>S级修正者<color=#FF9500>「青君·孟章」</color>以及A级修正者<color=#B67FE3>「沐风·恩利尔」</color>、<color=#B67FE3>「风行·赫尔墨斯」</color>、<color=#B67FE3>「荒獠·金固」</color>的探测获取概率<color=#FF9500>大幅提升</color>！
精准扩充修正者始终可以在精准扩充探测中获取，但不会进入「修正者共鸣」常规探测。

在「玉龙吟风」活动探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时，已探测的次数将重置为0，并重新开始计算。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「青君·孟章」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。
当探测获得A级修正者时，有<color=#FF9500>90%</color>的概率为本期UP修正者<color=#B67FE3>「沐风·恩利尔」</color>、<color=#B67FE3>「风行·赫尔墨斯」</color>、<color=#B67FE3>「荒獠·金固」</color>中的一个（概率均等）。如果本次探测获得的A级修正者非本期UP的A级修正者，下次探测获得的A级修正者<color=#FF9500>必定</color>为本期UP的A级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

「玉龙吟风」属于精准扩充探测，所有的精准扩充探测和精准探测将共享探测保底次数。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 2,
		pool_selected_type = 1,
		exchange_id = 1180003,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10153,
		cost_once = {
			38,
			1
		},
		cost_ten_times = {
			38,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[10131] = {
		name = "修正者常规探测",
		pool_type = 1,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
修正者探测限时UP开启。S级修正者<color=#FF9500>「青君·孟章」</color>的探测获取概率<color=#FF9500>限时大幅提升</color>！

在修正者探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时将会重置当前探测种类已探测的次数。当探测获得S级修正者时，有<color=#FF9500>50%</color>的概率为本期UP修正者<color=#FF9500>「青君·孟章」</color>。如果本次探测获得的S级修正者非本期UP的S级修正者，下次最多70次探测<color=#FF9500>必定</color>获得本期UP的S级修正者。

若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

UP修正者的变更不会影响修正者探测的保底。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 4,
		pool_selected_type = 1,
		exchange_id = 1180001,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 10131,
		cost_once = {
			5,
			1
		},
		cost_ten_times = {
			5,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[30000] = {
		name = "新人入职限定探测",
		pool_type = 5,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
在「新人入职限定探测」中，10次探测只需使用<color=#FF9500>6</color>枚修正者探测凭证。
「新人入职限定探测」一共可进行20次，前<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级修正者<color=#FF9500>夜之寄生·霍德尔</color>。
若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 1,
		pool_selected_type = 0,
		exchange_id = 1180001,
		optional_groups = 0,
		optional_bgId = "",
		discount = 60,
		id = 30000,
		cost_once = {
			5,
			1
		},
		cost_ten_times = {
			5,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[30001] = {
		name = "修正者常规探测",
		pool_type = 1,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
在修正者探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时将会重置当前探测种类已探测的次数。
若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 3,
		pool_selected_type = 0,
		exchange_id = 1180001,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 30001,
		cost_once = {
			5,
			1
		},
		cost_ten_times = {
			5,
			10
		},
		cost_once_activity_material = {
			53004,
			1
		},
		cost_ten_times_activity_material = {
			53004,
			10
		}
	},
	[50000] = {
		name = "新人入职限定探测",
		pool_type = 5,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
在「新人入职限定探测」中，10次探测只需使用<color=#FF9500>6</color>枚修正者探测凭证。
「新人入职限定探测」一共可进行20次，前<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级修正者<color=#FF9500>夜之寄生·霍德尔</color>。
若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 1,
		pool_selected_type = 0,
		exchange_id = 1180001,
		optional_groups = 0,
		optional_bgId = "",
		discount = 60,
		id = 50000,
		cost_once = {
			5,
			1
		},
		cost_ten_times = {
			5,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[50001] = {
		name = "修正者常规探测",
		pool_type = 1,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
在修正者探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时将会重置当前探测种类已探测的次数。
若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 3,
		pool_selected_type = 0,
		exchange_id = 1180001,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 50001,
		cost_once = {
			5,
			1
		},
		cost_ten_times = {
			5,
			10
		},
		cost_once_activity_material = {
			53004,
			1
		},
		cost_ten_times_activity_material = {
			53004,
			10
		}
	},
	[70000] = {
		name = "新人入职限定探测",
		pool_type = 5,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
在「新人入职限定探测」中，10次探测只需使用<color=#FF9500>6</color>枚修正者探测凭证。
「新人入职限定探测」一共可进行20次，前<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级修正者<color=#FF9500>夜之寄生·霍德尔</color>。
若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 1,
		pool_selected_type = 0,
		exchange_id = 1180001,
		optional_groups = 0,
		optional_bgId = "",
		discount = 60,
		id = 70000,
		cost_once = {
			5,
			1
		},
		cost_ten_times = {
			5,
			10
		},
		cost_once_activity_material = {},
		cost_ten_times_activity_material = {}
	},
	[70001] = {
		name = "修正者常规探测",
		pool_type = 1,
		optional_lists = "",
		optional_detail = "",
		detail_note = [[
在修正者探测中，每<color=#FF9500>10</color>次探测必出<color=#FF9500>A</color>级或以上品质修正者，最多<color=#FF9500>70</color>次探测必出<color=#FF9500>S</color>级修正者。获得S级修正者时将会重置当前探测种类已探测的次数。
若获得重复修正者，将自动转换为一定数量的该修正者的<color=#FF9500>情报</color>。

获得S级修正者时，会同时获得100个<color=#B67FE3>共鸣辉芒</color>；获得A级修正者时，会同时获得20个<color=#B67FE3>共鸣辉芒</color>；获得B级修正者时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>；获得3星钥从时，会同时获得10个<color=#B67FE3>共鸣辉芒</color>。

<color=#9A9A9A>※每日最多可以进行15000次探测（包含全部探测种类）。</color>]],
		desc = "每10次探测必出A级或以上品质修正者\n每70次探测必出S级修正者\n首次探测前40次必出S级修正者",
		pool_change = 0,
		order = 3,
		pool_selected_type = 0,
		exchange_id = 1180001,
		optional_groups = 0,
		optional_bgId = "",
		discount = 100,
		id = 70001,
		cost_once = {
			5,
			1
		},
		cost_ten_times = {
			5,
			10
		},
		cost_once_activity_material = {
			53004,
			1
		},
		cost_ten_times_activity_material = {
			53004,
			10
		}
	},
	all = {
		10000,
		10002,
		10013,
		10001,
		10001,
		10001,
		10001,
		10001,
		10001,
		10002,
		10001,
		10001,
		10002,
		10002,
		10001,
		10002,
		10001,
		10002,
		10001,
		10002,
		10001,
		10002,
		10001,
		10002,
		10001,
		10002,
		10001,
		10002,
		10001,
		10002,
		10002,
		10001,
		10003,
		10001,
		10003,
		10000,
		10002,
		10000,
		10002,
		10000,
		10002
	}
}
