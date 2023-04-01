slot0 = require("protobuf")

module("p38_pb")

slot1 = slot0.Descriptor()
slot2 = slot0.FieldDescriptor()
slot3 = slot0.FieldDescriptor()
slot4 = slot0.Descriptor()
slot5 = slot0.FieldDescriptor()
slot6 = slot0.Descriptor()
slot7 = slot0.FieldDescriptor()
slot8 = slot0.Descriptor()
slot9 = slot0.FieldDescriptor()
slot10 = slot0.Descriptor()
slot11 = slot0.FieldDescriptor()
slot12 = slot0.FieldDescriptor()
slot13 = slot0.FieldDescriptor()
slot14 = slot0.Descriptor()
slot15 = slot0.FieldDescriptor()
slot16 = slot0.Descriptor()
slot17 = slot0.FieldDescriptor()
slot18 = slot0.Descriptor()
slot19 = slot0.FieldDescriptor()
slot20 = slot0.Descriptor()
slot21 = slot0.FieldDescriptor()
slot22 = slot0.Descriptor()
slot23 = slot0.FieldDescriptor()
slot24 = slot0.FieldDescriptor()
slot25 = slot0.Descriptor()
slot26 = slot0.FieldDescriptor()
slot2.name = "op_type"
slot2.full_name = ".p38.log_ui_op.op_type"
slot2.number = 1
slot2.index = 0
slot2.label = 2
slot2.has_default_value = false
slot2.default_value = ""
slot2.type = 9
slot2.cpp_type = 9
slot3.name = "oper"
slot3.full_name = ".p38.log_ui_op.oper"
slot3.number = 2
slot3.index = 1
slot3.label = 2
slot3.has_default_value = false
slot3.default_value = ""
slot3.type = 9
slot3.cpp_type = 9
slot1.name = "log_ui_op"
slot1.full_name = ".p38.log_ui_op"
slot1.nested_types = {}
slot1.enum_types = {}
slot1.fields = {
	slot2,
	slot3
}
slot1.is_extendable = false
slot1.extensions = {}
slot5.name = "op_list"
slot5.full_name = ".p38.cs_38002.op_list"
slot5.number = 1
slot5.index = 0
slot5.label = 3
slot5.has_default_value = false
slot5.default_value = {}
slot5.message_type = slot1
slot5.type = 11
slot5.cpp_type = 10
slot4.name = "cs_38002"
slot4.full_name = ".p38.cs_38002"
slot4.nested_types = {}
slot4.enum_types = {}
slot4.fields = {
	slot5
}
slot4.is_extendable = false
slot4.extensions = {}
slot7.name = "format_data"
slot7.full_name = ".p38.cs_38004.format_data"
slot7.number = 1
slot7.index = 0
slot7.label = 2
slot7.has_default_value = false
slot7.default_value = ""
slot7.type = 9
slot7.cpp_type = 9
slot6.name = "cs_38004"
slot6.full_name = ".p38.cs_38004"
slot6.nested_types = {}
slot6.enum_types = {}
slot6.fields = {
	slot7
}
slot6.is_extendable = false
slot6.extensions = {}
slot9.name = "format_data"
slot9.full_name = ".p38.cs_38006.format_data"
slot9.number = 1
slot9.index = 0
slot9.label = 2
slot9.has_default_value = false
slot9.default_value = ""
slot9.type = 9
slot9.cpp_type = 9
slot8.name = "cs_38006"
slot8.full_name = ".p38.cs_38006"
slot8.nested_types = {}
slot8.enum_types = {}
slot8.fields = {
	slot9
}
slot8.is_extendable = false
slot8.extensions = {}
slot11.name = "battle_id"
slot11.full_name = ".p38.cs_38008.battle_id"
slot11.number = 1
slot11.index = 0
slot11.label = 2
slot11.has_default_value = false
slot11.default_value = 0
slot11.type = 4
slot11.cpp_type = 4
slot12.name = "combat_id"
slot12.full_name = ".p38.cs_38008.combat_id"
slot12.number = 2
slot12.index = 1
slot12.label = 2
slot12.has_default_value = false
slot12.default_value = 0
slot12.type = 13
slot12.cpp_type = 3
slot13.name = "before_battle_load_time"
slot13.full_name = ".p38.cs_38008.before_battle_load_time"
slot13.number = 3
slot13.index = 2
slot13.label = 2
slot13.has_default_value = false
slot13.default_value = 0
slot13.type = 13
slot13.cpp_type = 3
slot10.name = "cs_38008"
slot10.full_name = ".p38.cs_38008"
slot10.nested_types = {}
slot10.enum_types = {}
slot10.fields = {
	slot11,
	slot12,
	slot13
}
slot10.is_extendable = false
slot10.extensions = {}
slot15.name = "after_battle_load_time"
slot15.full_name = ".p38.cs_38010.after_battle_load_time"
slot15.number = 1
slot15.index = 0
slot15.label = 2
slot15.has_default_value = false
slot15.default_value = 0
slot15.type = 13
slot15.cpp_type = 3
slot14.name = "cs_38010"
slot14.full_name = ".p38.cs_38010"
slot14.nested_types = {}
slot14.enum_types = {}
slot14.fields = {
	slot15
}
slot14.is_extendable = false
slot14.extensions = {}
slot17.name = "guide_id"
slot17.full_name = ".p38.cs_38012.guide_id"
slot17.number = 1
slot17.index = 0
slot17.label = 2
slot17.has_default_value = false
slot17.default_value = 0
slot17.type = 13
slot17.cpp_type = 3
slot16.name = "cs_38012"
slot16.full_name = ".p38.cs_38012"
slot16.nested_types = {}
slot16.enum_types = {}
slot16.fields = {
	slot17
}
slot16.is_extendable = false
slot16.extensions = {}
slot19.name = "result"
slot19.full_name = ".p38.sc_38013.result"
slot19.number = 1
slot19.index = 0
slot19.label = 2
slot19.has_default_value = false
slot19.default_value = 0
slot19.type = 13
slot19.cpp_type = 3
slot18.name = "sc_38013"
slot18.full_name = ".p38.sc_38013"
slot18.nested_types = {}
slot18.enum_types = {}
slot18.fields = {
	slot19
}
slot18.is_extendable = false
slot18.extensions = {}
slot21.name = "log_list"
slot21.full_name = ".p38.cs_38014.log_list"
slot21.number = 1
slot21.index = 0
slot21.label = 3
slot21.has_default_value = false
slot21.default_value = {}
slot21.message_type = slot22
slot21.type = 11
slot21.cpp_type = 10
slot20.name = "cs_38014"
slot20.full_name = ".p38.cs_38014"
slot20.nested_types = {}
slot20.enum_types = {}
slot20.fields = {
	slot21
}
slot20.is_extendable = false
slot20.extensions = {}
slot23.name = "event_name"
slot23.full_name = ".p38.log_net_rec.event_name"
slot23.number = 1
slot23.index = 0
slot23.label = 2
slot23.has_default_value = false
slot23.default_value = ""
slot23.type = 9
slot23.cpp_type = 9
slot24.name = "attribute_json"
slot24.full_name = ".p38.log_net_rec.attribute_json"
slot24.number = 2
slot24.index = 1
slot24.label = 2
slot24.has_default_value = false
slot24.default_value = ""
slot24.type = 9
slot24.cpp_type = 9
slot22.name = "log_net_rec"
slot22.full_name = ".p38.log_net_rec"
slot22.nested_types = {}
slot22.enum_types = {}
slot22.fields = {
	slot23,
	slot24
}
slot22.is_extendable = false
slot22.extensions = {}
slot26.name = "result"
slot26.full_name = ".p38.sc_38015.result"
slot26.number = 1
slot26.index = 0
slot26.label = 2
slot26.has_default_value = false
slot26.default_value = 0
slot26.type = 13
slot26.cpp_type = 3
slot25.name = "sc_38015"
slot25.full_name = ".p38.sc_38015"
slot25.nested_types = {}
slot25.enum_types = {}
slot25.fields = {
	slot26
}
slot25.is_extendable = false
slot25.extensions = {}
cs_38002 = slot0.Message(slot4)
cs_38004 = slot0.Message(slot6)
cs_38006 = slot0.Message(slot8)
cs_38008 = slot0.Message(slot10)
cs_38010 = slot0.Message(slot14)
cs_38012 = slot0.Message(slot16)
cs_38014 = slot0.Message(slot20)
log_net_rec = slot0.Message(slot22)
log_ui_op = slot0.Message(slot1)
sc_38013 = slot0.Message(slot18)
sc_38015 = slot0.Message(slot25)
