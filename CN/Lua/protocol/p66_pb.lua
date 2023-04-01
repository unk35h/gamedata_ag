slot0 = require("protobuf")

module("p66_pb")

slot1 = slot0.Descriptor()
slot2 = slot0.FieldDescriptor()
slot3 = slot0.FieldDescriptor()
slot4 = slot0.Descriptor()
slot5 = slot0.FieldDescriptor()
slot6 = slot0.Descriptor()
slot7 = slot0.Descriptor()
slot8 = slot0.FieldDescriptor()
slot2.name = "type"
slot2.full_name = ".p66.cs_66000.type"
slot2.number = 1
slot2.index = 0
slot2.label = 2
slot2.has_default_value = false
slot2.default_value = 0
slot2.type = 13
slot2.cpp_type = 3
slot3.name = "level"
slot3.full_name = ".p66.cs_66000.level"
slot3.number = 2
slot3.index = 1
slot3.label = 1
slot3.has_default_value = false
slot3.default_value = 0
slot3.type = 13
slot3.cpp_type = 3
slot1.name = "cs_66000"
slot1.full_name = ".p66.cs_66000"
slot1.nested_types = {}
slot1.enum_types = {}
slot1.fields = {
	slot2,
	slot3
}
slot1.is_extendable = false
slot1.extensions = {}
slot5.name = "result"
slot5.full_name = ".p66.sc_66001.result"
slot5.number = 1
slot5.index = 0
slot5.label = 2
slot5.has_default_value = false
slot5.default_value = 0
slot5.type = 13
slot5.cpp_type = 3
slot4.name = "sc_66001"
slot4.full_name = ".p66.sc_66001"
slot4.nested_types = {}
slot4.enum_types = {}
slot4.fields = {
	slot5
}
slot4.is_extendable = false
slot4.extensions = {}
slot6.name = "cs_66002"
slot6.full_name = ".p66.cs_66002"
slot6.nested_types = {}
slot6.enum_types = {}
slot6.fields = {}
slot6.is_extendable = false
slot6.extensions = {}
slot8.name = "result"
slot8.full_name = ".p66.sc_66003.result"
slot8.number = 1
slot8.index = 0
slot8.label = 2
slot8.has_default_value = false
slot8.default_value = 0
slot8.type = 13
slot8.cpp_type = 3
slot7.name = "sc_66003"
slot7.full_name = ".p66.sc_66003"
slot7.nested_types = {}
slot7.enum_types = {}
slot7.fields = {
	slot8
}
slot7.is_extendable = false
slot7.extensions = {}
cs_66000 = slot0.Message(slot1)
cs_66002 = slot0.Message(slot6)
sc_66001 = slot0.Message(slot4)
sc_66003 = slot0.Message(slot7)
