slot0 = require("protobuf")

module("p47_pb")

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
slot2.name = "base_stage_list"
slot2.full_name = ".p47.sc_47001.base_stage_list"
slot2.number = 1
slot2.index = 0
slot2.label = 3
slot2.has_default_value = false
slot2.default_value = {}
slot2.message_type = slot3
slot2.type = 11
slot2.cpp_type = 10
slot1.name = "sc_47001"
slot1.full_name = ".p47.sc_47001"
slot1.nested_types = {}
slot1.enum_types = {}
slot1.fields = {
	slot2
}
slot1.is_extendable = false
slot1.extensions = {}
slot4.name = "id"
slot4.full_name = ".p47.base_stage.id"
slot4.number = 1
slot4.index = 0
slot4.label = 2
slot4.has_default_value = false
slot4.default_value = 0
slot4.type = 13
slot4.cpp_type = 3
slot5.name = "clear_times"
slot5.full_name = ".p47.base_stage.clear_times"
slot5.number = 2
slot5.index = 1
slot5.label = 2
slot5.has_default_value = false
slot5.default_value = 0
slot5.type = 13
slot5.cpp_type = 3
slot3.name = "base_stage"
slot3.full_name = ".p47.base_stage"
slot3.nested_types = {}
slot3.enum_types = {}
slot3.fields = {
	slot4,
	slot5
}
slot3.is_extendable = false
slot3.extensions = {}
slot7.name = "hero_teaching_list"
slot7.full_name = ".p47.sc_47003.hero_teaching_list"
slot7.number = 1
slot7.index = 0
slot7.label = 3
slot7.has_default_value = false
slot7.default_value = {}
slot7.message_type = slot8
slot7.type = 11
slot7.cpp_type = 10
slot6.name = "sc_47003"
slot6.full_name = ".p47.sc_47003"
slot6.nested_types = {}
slot6.enum_types = {}
slot6.fields = {
	slot7
}
slot6.is_extendable = false
slot6.extensions = {}
slot9.name = "hero_id"
slot9.full_name = ".p47.hero_teaching.hero_id"
slot9.number = 1
slot9.index = 0
slot9.label = 2
slot9.has_default_value = false
slot9.default_value = 0
slot9.type = 13
slot9.cpp_type = 3
slot10.name = "stage_list"
slot10.full_name = ".p47.hero_teaching.stage_list"
slot10.number = 2
slot10.index = 1
slot10.label = 3
slot10.has_default_value = false
slot10.default_value = {}
slot10.message_type = slot11
slot10.type = 11
slot10.cpp_type = 10
slot8.name = "hero_teaching"
slot8.full_name = ".p47.hero_teaching"
slot8.nested_types = {}
slot8.enum_types = {}
slot8.fields = {
	slot9,
	slot10
}
slot8.is_extendable = false
slot8.extensions = {}
slot12.name = "id"
slot12.full_name = ".p47.hero_stage.id"
slot12.number = 1
slot12.index = 0
slot12.label = 2
slot12.has_default_value = false
slot12.default_value = 0
slot12.type = 13
slot12.cpp_type = 3
slot13.name = "clear_times"
slot13.full_name = ".p47.hero_stage.clear_times"
slot13.number = 2
slot13.index = 1
slot13.label = 2
slot13.has_default_value = false
slot13.default_value = 0
slot13.type = 13
slot13.cpp_type = 3
slot11.name = "hero_stage"
slot11.full_name = ".p47.hero_stage"
slot11.nested_types = {}
slot11.enum_types = {}
slot11.fields = {
	slot12,
	slot13
}
slot11.is_extendable = false
slot11.extensions = {}
base_stage = slot0.Message(slot3)
hero_stage = slot0.Message(slot11)
hero_teaching = slot0.Message(slot8)
sc_47001 = slot0.Message(slot1)
sc_47003 = slot0.Message(slot6)
