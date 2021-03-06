#
gap> test := x -> List([IsFilter, IsCategory, IsRepresentation, IsAttribute, IsProperty, IsOperation], f -> f(x));;
gap> test(IsFinite);
[ true, false, false, false, true, true ]

#
gap> test(IsMagma);
[ true, true, false, false, false, true ]

#
gap> test(IsCommutative);
[ true, false, false, false, true, true ]

#
gap> test(Size);
[ false, false, false, true, false, true ]

#
gap> test(Group);
[ false, false, false, false, false, false ]

#
gap> test((1,2,3));
[ false, false, false, false, false, false ]

#
gap> test("hello, world");
[ false, false, false, false, false, false ]

#
gap> test(Setter(IS_MUTABLE_OBJ));
[ false, false, false, false, false, true ]

#
gap> FilterByName("IsCommutative");
<Property "IsCommutative">
gap> CategoryByName("IsMagma");
<Category "IsMagma">

#
gap> ForAll([1..Length(FILTERS)], id -> id = IdOfFilter(FILTERS[id]));
true

#
gap> TypeOfOperation(IsFilter);
Error, <oper> must be an operation

#
gap> List([IsAbelian, HasIsAbelian, IsMutable, \+, Size, AbelianGroupCons, Setter(IS_MUTABLE_OBJ)], TypeOfOperation);
[ "Property", "Filter", "Category", "Operation", "Attribute", "Constructor", 
  "Setter" ]

#
