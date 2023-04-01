slot0 = require("protobuf")

module("p21_pb")

slot1 = slot0.Descriptor()
slot2 = slot0.FieldDescriptor()
slot3 = slot0.Descriptor()
slot4 = slot0.FieldDescriptor()
slot5 = slot0.FieldDescriptor()
slot6 = slot0.Descriptor()
slot7 = slot0.FieldDescriptor()
slot8 = slot0.Descriptor()
slot9 = slot0.FieldDescriptor()
slot10 = slot0.FieldDescriptor()
slot11 = slot0.Descriptor()
slot12 = slot0.FieldDescriptor()
slot13 = slot0.FieldDescriptor()
slot14 = slot0.FieldDescriptor()
slot15 = slot0.FieldDescriptor()
slot16 = slot0.FieldDescriptor()
slot17 = slot0.Descriptor()
slot18 = slot0.Descriptor()
slot19 = slot0.FieldDescriptor()
slot20 = slot0.Descriptor()
slot21 = slot0.FieldDescriptor()
slot22 = slot0.Descriptor()
slot23 = slot0.FieldDescriptor()
slot24 = slot0.Descriptor()
slot25 = slot0.FieldDescriptor()
slot26 = slot0.Descriptor()
slot27 = slot0.FieldDescriptor()
slot28 = slot0.Descriptor()
slot29 = slot0.FieldDescriptor()
slot30 = slot0.Descriptor()
slot31 = slot0.FieldDescriptor()
slot2.name = "setting"
slot2.full_name = ".p21.sc_21001.setting"
slot2.number = 1
slot2.index = 0
slot2.label = 2
slot2.has_default_value = false
slot2.default_value = nil
slot2.message_type = slot3
slot2.type = 11
slot2.cpp_type = 10
slot1.name = "sc_21001"
slot1.full_name = ".p21.sc_21001"
slot1.nested_types = {}
slot1.enum_types = {}
slot1.fields = {
	slot2
}
slot1.is_extendable = false
slot1.extensions = {}
slot4.name = "sign_in_propel_switch"
slot4.full_name = ".p21.user_system_setting_net_rec.sign_in_propel_switch"
slot4.number = 1
slot4.index = 0
slot4.label = 2
slot4.has_default_value = false
slot4.default_value = 0
slot4.type = 13
slot4.cpp_type = 3
slot5.name = "month_card_propel_switch"
slot5.full_name = ".p21.user_system_setting_net_rec.month_card_propel_switch"
slot5.number = 2
slot5.index = 1
slot5.label = 2
slot5.has_default_value = false
slot5.default_value = 0
slot5.type = 13
slot5.cpp_type = 3
slot3.name = "user_system_setting_net_rec"
slot3.full_name = ".p21.user_system_setting_net_rec"
slot3.nested_types = {}
slot3.enum_types = {}
slot3.fields = {
	slot4,
	slot5
}
slot3.is_extendable = false
slot3.extensions = {}
slot7.name = "formation_list"
slot7.full_name = ".p21.sc_21101.formation_list"
slot7.number = 1
slot7.index = 0
slot7.label = 3
slot7.has_default_value = false
slot7.default_value = {}
slot7.message_type = slot11
slot7.type = 11
slot7.cpp_type = 10
slot6.name = "sc_21101"
slot6.full_name = ".p21.sc_21101"
slot6.nested_types = {}
slot6.enum_types = {}
slot6.fields = {
	slot7
}
slot6.is_extendable = false
slot6.extensions = {}
slot9.name = "mimir_id"
slot9.full_name = ".p21.mimir_net_rec.mimir_id"
slot9.number = 1
slot9.index = 0
slot9.label = 2
slot9.has_default_value = false
slot9.default_value = 0
slot9.type = 13
slot9.cpp_type = 3
slot10.name = "chip_list"
slot10.full_name = ".p21.mimir_net_rec.chip_list"
slot10.number = 2
slot10.index = 1
slot10.label = 3
slot10.has_default_value = false
slot10.default_value = {}
slot10.type = 13
slot10.cpp_type = 3
slot8.name = "mimir_net_rec"
slot8.full_name = ".p21.mimir_net_rec"
slot8.nested_types = {}
slot8.enum_types = {}
slot8.fields = {
	slot9,
	slot10
}
slot8.is_extendable = false
slot8.extensions = {}
slot12.name = "id"
slot12.full_name = ".p21.user_formation_net_rec.id"
slot12.number = 1
slot12.index = 0
slot12.label = 2
slot12.has_default_value = false
slot12.default_value = 0
slot12.type = 13
slot12.cpp_type = 3
slot13.name = "name"
slot13.full_name = ".p21.user_formation_net_rec.name"
slot13.number = 2
slot13.index = 1
slot13.label = 2
slot13.has_default_value = false
slot13.default_value = ""
slot13.type = 9
slot13.cpp_type = 9
slot14.name = "hero_list"
slot14.full_name = ".p21.user_formation_net_rec.hero_list"
slot14.number = 3
slot14.index = 2
slot14.label = 3
slot14.has_default_value = false
slot14.default_value = {}
slot14.type = 13
slot14.cpp_type = 3
slot15.name = "cooperate_unique_skill_id"
slot15.full_name = ".p21.user_formation_net_rec.cooperate_unique_skill_id"
slot15.number = 4
slot15.index = 3
slot15.label = 2
slot15.has_default_value = false
slot15.default_value = 0
slot15.type = 13
slot15.cpp_type = 3
slot16.name = "mimir_info"
slot16.full_name = ".p21.user_formation_net_rec.mimir_info"
slot16.number = 5
slot16.index = 4
slot16.label = 3
slot16.has_default_value = false
slot16.default_value = {}
slot16.message_type = slot8
slot16.type = 11
slot16.cpp_type = 10
slot11.name = "user_formation_net_rec"
slot11.full_name = ".p21.user_formation_net_rec"
slot11.nested_types = {}
slot11.enum_types = {}
slot11.fields = {
	slot12,
	slot13,
	slot14,
	slot15,
	slot16
}
slot11.is_extendable = false
slot11.extensions = {}
slot17.name = "cs_21010"
slot17.full_name = ".p21.cs_21010"
slot17.nested_types = {}
slot17.enum_types = {}
slot17.fields = {}
slot17.is_extendable = false
slot17.extensions = {}
slot19.name = "result"
slot19.full_name = ".p21.sc_21011.result"
slot19.number = 1
slot19.index = 0
slot19.label = 2
slot19.has_default_value = false
slot19.default_value = 0
slot19.type = 13
slot19.cpp_type = 3
slot18.name = "sc_21011"
slot18.full_name = ".p21.sc_21011"
slot18.nested_types = {}
slot18.enum_types = {}
slot18.fields = {
	slot19
}
slot18.is_extendable = false
slot18.extensions = {}
slot21.name = "setting"
slot21.full_name = ".p21.cs_21012.setting"
slot21.number = 1
slot21.index = 0
slot21.label = 2
slot21.has_default_value = false
slot21.default_value = nil
slot21.message_type = slot3
slot21.type = 11
slot21.cpp_type = 10
slot20.name = "cs_21012"
slot20.full_name = ".p21.cs_21012"
slot20.nested_types = {}
slot20.enum_types = {}
slot20.fields = {
	slot21
}
slot20.is_extendable = false
slot20.extensions = {}
slot23.name = "result"
slot23.full_name = ".p21.sc_21013.result"
slot23.number = 1
slot23.index = 0
slot23.label = 2
slot23.has_default_value = false
slot23.default_value = 0
slot23.type = 13
slot23.cpp_type = 3
slot22.name = "sc_21013"
slot22.full_name = ".p21.sc_21013"
slot22.nested_types = {}
slot22.enum_types = {}
slot22.fields = {
	slot23
}
slot22.is_extendable = false
slot22.extensions = {}
slot25.name = "formation_info_list"
slot25.full_name = ".p21.cs_21110.formation_info_list"
slot25.number = 1
slot25.index = 0
slot25.label = 3
slot25.has_default_value = false
slot25.default_value = {}
slot25.message_type = slot11
slot25.type = 11
slot25.cpp_type = 10
slot24.name = "cs_21110"
slot24.full_name = ".p21.cs_21110"
slot24.nested_types = {}
slot24.enum_types = {}
slot24.fields = {
	slot25
}
slot24.is_extendable = false
slot24.extensions = {}
slot27.name = "result"
slot27.full_name = ".p21.sc_21111.result"
slot27.number = 1
slot27.index = 0
slot27.label = 2
slot27.has_default_value = false
slot27.default_value = 0
slot27.type = 13
slot27.cpp_type = 3
slot26.name = "sc_21111"
slot26.full_name = ".p21.sc_21111"
slot26.nested_types = {}
slot26.enum_types = {}
slot26.fields = {
	slot27
}
slot26.is_extendable = false
slot26.extensions = {}
slot29.name = "id"
slot29.full_name = ".p21.cs_21112.id"
slot29.number = 1
slot29.index = 0
slot29.label = 2
slot29.has_default_value = false
slot29.default_value = 0
slot29.type = 13
slot29.cpp_type = 3
slot28.name = "cs_21112"
slot28.full_name = ".p21.cs_21112"
slot28.nested_types = {}
slot28.enum_types = {}
slot28.fields = {
	slot29
}
slot28.is_extendable = false
slot28.extensions = {}
slot31.name = "result"
slot31.full_name = ".p21.sc_21113.result"
slot31.number = 1
slot31.index = 0
slot31.label = 2
slot31.has_default_value = false
slot31.default_value = 0
slot31.type = 13
slot31.cpp_type = 3
slot30.name = "sc_21113"
slot30.full_name = ".p21.sc_21113"
slot30.nested_types = {}
slot30.enum_types = {}
slot30.fields = {
	slot31
}
slot30.is_extendable = false
slot30.extensions = {}
cs_21010 = slot0.Message(slot17)
cs_21012 = slot0.Message(slot20)
cs_21110 = slot0.Message(slot24)
cs_21112 = slot0.Message(slot28)
mimir_net_rec = slot0.Message(slot8)
sc_21001 = slot0.Message(slot1)
sc_21011 = slot0.Message(slot18)
sc_21013 = slot0.Message(slot22)
sc_21101 = slot0.Message(slot6)
sc_21111 = slot0.Message(slot26)
sc_21113 = slot0.Message(slot30)
user_formation_net_rec = slot0.Message(slot11)
user_system_setting_net_rec = slot0.Message(slot3)
