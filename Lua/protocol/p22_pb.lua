slot0 = require("protobuf")

module("p22_pb")

slot1 = slot0.Descriptor()
slot2 = slot0.FieldDescriptor()
slot3 = slot0.Descriptor()
slot4 = slot0.FieldDescriptor()
slot5 = slot0.Descriptor()
slot6 = slot0.FieldDescriptor()
slot7 = slot0.Descriptor()
slot8 = slot0.FieldDescriptor()
slot9 = slot0.Descriptor()
slot10 = slot0.FieldDescriptor()
slot11 = slot0.FieldDescriptor()
slot12 = slot0.Descriptor()
slot13 = slot0.FieldDescriptor()
slot14 = slot0.FieldDescriptor()
slot15 = slot0.Descriptor()
slot16 = slot0.FieldDescriptor()
slot17 = slot0.Descriptor()
slot18 = slot0.FieldDescriptor()
slot2.name = "left_time"
slot2.full_name = ".p22.sc_22007.left_time"
slot2.number = 1
slot2.index = 0
slot2.label = 2
slot2.has_default_value = false
slot2.default_value = 0
slot2.type = 13
slot2.cpp_type = 3
slot1.name = "sc_22007"
slot1.full_name = ".p22.sc_22007"
slot1.nested_types = {}
slot1.enum_types = {}
slot1.fields = {
	slot2
}
slot1.is_extendable = false
slot1.extensions = {}
slot4.name = "fatigue"
slot4.full_name = ".p22.sc_22009.fatigue"
slot4.number = 1
slot4.index = 0
slot4.label = 2
slot4.has_default_value = false
slot4.default_value = 0
slot4.type = 13
slot4.cpp_type = 3
slot3.name = "sc_22009"
slot3.full_name = ".p22.sc_22009"
slot3.nested_types = {}
slot3.enum_types = {}
slot3.fields = {
	slot4
}
slot3.is_extendable = false
slot3.extensions = {}
slot6.name = "nothing"
slot6.full_name = ".p22.cs_22010.nothing"
slot6.number = 1
slot6.index = 0
slot6.label = 2
slot6.has_default_value = false
slot6.default_value = 0
slot6.type = 13
slot6.cpp_type = 3
slot5.name = "cs_22010"
slot5.full_name = ".p22.cs_22010"
slot5.nested_types = {}
slot5.enum_types = {}
slot5.fields = {
	slot6
}
slot5.is_extendable = false
slot5.extensions = {}
slot8.name = "result"
slot8.full_name = ".p22.sc_22011.result"
slot8.number = 1
slot8.index = 0
slot8.label = 2
slot8.has_default_value = false
slot8.default_value = 0
slot8.type = 13
slot8.cpp_type = 3
slot7.name = "sc_22011"
slot7.full_name = ".p22.sc_22011"
slot7.nested_types = {}
slot7.enum_types = {}
slot7.fields = {
	slot8
}
slot7.is_extendable = false
slot7.extensions = {}
slot10.name = "request"
slot10.full_name = ".p22.cs_22012.request"
slot10.number = 1
slot10.index = 0
slot10.label = 2
slot10.has_default_value = false
slot10.default_value = 0
slot10.type = 13
slot10.cpp_type = 3
slot11.name = "timestamp"
slot11.full_name = ".p22.cs_22012.timestamp"
slot11.number = 2
slot11.index = 1
slot11.label = 2
slot11.has_default_value = false
slot11.default_value = 0
slot11.type = 13
slot11.cpp_type = 3
slot9.name = "cs_22012"
slot9.full_name = ".p22.cs_22012"
slot9.nested_types = {}
slot9.enum_types = {}
slot9.fields = {
	slot10,
	slot11
}
slot9.is_extendable = false
slot9.extensions = {}
slot13.name = "timestamp"
slot13.full_name = ".p22.sc_22013.timestamp"
slot13.number = 1
slot13.index = 0
slot13.label = 2
slot13.has_default_value = false
slot13.default_value = 0
slot13.type = 13
slot13.cpp_type = 3
slot14.name = "result"
slot14.full_name = ".p22.sc_22013.result"
slot14.number = 2
slot14.index = 1
slot14.label = 2
slot14.has_default_value = false
slot14.default_value = 0
slot14.type = 13
slot14.cpp_type = 3
slot12.name = "sc_22013"
slot12.full_name = ".p22.sc_22013"
slot12.nested_types = {}
slot12.enum_types = {}
slot12.fields = {
	slot13,
	slot14
}
slot12.is_extendable = false
slot12.extensions = {}
slot16.name = "add_fatigue"
slot16.full_name = ".p22.cs_22014.add_fatigue"
slot16.number = 1
slot16.index = 0
slot16.label = 2
slot16.has_default_value = false
slot16.default_value = 0
slot16.type = 13
slot16.cpp_type = 3
slot15.name = "cs_22014"
slot15.full_name = ".p22.cs_22014"
slot15.nested_types = {}
slot15.enum_types = {}
slot15.fields = {
	slot16
}
slot15.is_extendable = false
slot15.extensions = {}
slot18.name = "result"
slot18.full_name = ".p22.sc_22015.result"
slot18.number = 1
slot18.index = 0
slot18.label = 2
slot18.has_default_value = false
slot18.default_value = 0
slot18.type = 13
slot18.cpp_type = 3
slot17.name = "sc_22015"
slot17.full_name = ".p22.sc_22015"
slot17.nested_types = {}
slot17.enum_types = {}
slot17.fields = {
	slot18
}
slot17.is_extendable = false
slot17.extensions = {}
cs_22010 = slot0.Message(slot5)
cs_22012 = slot0.Message(slot9)
cs_22014 = slot0.Message(slot15)
sc_22007 = slot0.Message(slot1)
sc_22009 = slot0.Message(slot3)
sc_22011 = slot0.Message(slot7)
sc_22013 = slot0.Message(slot12)
sc_22015 = slot0.Message(slot17)
