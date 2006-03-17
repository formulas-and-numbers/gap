#############################################################################
##
#W  grppc.gd                    GAP Library                      Frank Celler
##
#H  @(#)$Id$
##
#Y  Copyright (C)  1996,  Lehrstuhl D fuer Mathematik,  RWTH Aachen,  Germany
#Y  (C) 1998 School Math and Comp. Sci., University of St.  Andrews, Scotland
#Y  Copyright (C) 2002 The GAP Group
##
##  This file contains the operations for groups with a polycyclic collector.
##
##  IsPcgs
##    a polycyclic generating system, also behaves like a pc sequence
##
##  IsPcGroup
##    a poylcyclic group whose elements family is defined by a collector
##
##  CanEasilyComputePcgs
##    a group that knows how to compute a pcgs relatively fast
##
##  HasDefiningPcgs
##    a group whose elements family is generated by a pcgs
##
##  HasHomePcgs
##    a group that knows a pcgs of a super group
##
Revision.grppc_gd :=
    "@(#)$Id$";


#############################################################################
##
#V  InfoPcGroup
##
DeclareInfoClass("InfoPcGroup");

#############################################################################
##
#M  CanEasilysortElements
##
InstallTrueMethod( CanEasilySortElements, IsPcGroup and IsFinite );


#############################################################################
##
#M  KnowsHowToDecompose( <G> )  . . . . . . . . . . always true for pc groups
##
InstallTrueMethod( KnowsHowToDecompose, IsPcGroup );


#############################################################################
##
#M  IsGeneratorsOfMagmaWithInverses( <G> )  always true for coll. of pc elts.
##
InstallTrueMethod( IsGeneratorsOfMagmaWithInverses,
    IsMultiplicativeElementWithInverseByPolycyclicCollectorCollection );


#############################################################################
##
#A  CanonicalPcgsWrtFamilyPcgs( <grp> )	. . . . . . .  with respect to family
##
DeclareAttribute( "CanonicalPcgsWrtFamilyPcgs", IsGroup );



#############################################################################
##
#A  CanonicalPcgsWrtHomePcgs( <grp> ) . . . . . . . . .  with respect to home
##
DeclareAttribute( "CanonicalPcgsWrtHomePcgs", IsGroup );



#############################################################################
##
#A  FamilyPcgs( <grp> ) . . . . . . . . . . . . . . . . .  pcgs of the family
##
DeclareAttribute( "FamilyPcgs", IsGroup );


InstallSubsetMaintenance( FamilyPcgs, IsGroup, IsGroup );


#############################################################################
##
#A  HomePcgs( <grp> ) . . . . . . . . . . . . . . . . . . .  pcgs of the home
##
DeclareAttribute( "HomePcgs", IsGroup );


InstallSubsetMaintenance( HomePcgs, IsGroup, IsGroup );


#############################################################################
##
#A  InducedPcgsWrtFamilyPcgs( <grp> ) . . . . . . . .  with respect to family
##
DeclareAttribute( "InducedPcgsWrtFamilyPcgs", IsGroup );


#############################################################################
##
#O  InducedPcgs( <pcgs>, <grp> )
##
##  computes a pcgs for <grp> which is induced by <pcgs>. If <pcgs> has
##  a parent pcgs, then the result is induced with respect to this parent
##  pcgs.
##
##  `InducedPcgs' is a wrapper function only. Therefore, methods for computing 
##  computing an induced pcgs should be installed for the
##  operation `InducedPcgsOp'.
##
DeclareOperation( "InducedPcgs", [IsPcgs,IsGroup] );

#############################################################################
##
#O  InducedPcgsOp( <pcgs>, <grp> )
##
##  computes a pcgs for <grp> which is induced by <pcgs>. <pcgs> must not
##  be an induced pcgs. This operation should not be called directly. 
##  Instead, please use `InducedPcgs' which caches its results.
##  
DeclareOperation( "InducedPcgsOp", [IsPcgs,IsGroup] );

#############################################################################
##
#A  ComputedInducedPcgses( <grp> )
##
##  This attribute stores previously computed induced generating systems
##  of the group <grp>. It is a list of the form
##  [<ppcgs_1>, <ipcgs_1>, <ppcgs_2>, <ipcgs_2>, ...],
##  where <ppcgs_n> is a parent pcgs and <igs_n> is the corresponding
##  induced generating system.
##  
DeclareAttribute ("ComputedInducedPcgses", IsGroup, "mutable");

#############################################################################
##
#F  SetInducedPcgs( <home>,<grp>,<pcgs> )
##
##  This function sets <pcgs> to be an <home>-induced pcgs for <grp> if the
##  `HomePcgs' of <grp> equals <home> and the `ParentPcgs' of <pcgs> equals
##  <home>. (This means <pcgs> is induced by <home>.) If <grp> has no
##  `HomePcgs' yet, it is assigned to <home> before this.
##  This function should be used in algorithms if a pcgs for a new subgroup
##  is computed that by this calculation is known to be compatible with the
##  home pcgs of the calculation.
DeclareGlobalFunction( "SetInducedPcgs" );

#############################################################################
##
#A  InducedPcgsWrtHomePcgs( <grp> ) . . . . . . . . . .  with respect to home
##
##  returns an induced pcgs for <grp> with respect to the home pcgs.
DeclareAttribute(
    "InducedPcgsWrtHomePcgs",
    IsGroup );



#############################################################################
##
#A  Pcgs( <G> ) . . . . . . . . . . . . . . . . . . . . . . pcgs of a group
##
##  returns a pcgs for the group <G>. 
##  If <grp> is not polycyclic it returns `fail' *and this result is not 
##  stored as attribute value*, in particular in this case the filter
##  `HasPcgs' is *not* set for <G>!
DeclareAttribute( "Pcgs", IsGroup );

#############################################################################
##
#A  GeneralizedPcgs( <G> )  . . . . . . . . . . . . . . . . . pcgs of a group
##
##  returns a generalized pcgs for the group <G>.
DeclareAttribute( "GeneralizedPcgs", IsGroup );

#############################################################################
##
#F  CanEasilyComputePcgs( <grp> ) . . . . .  group is willing to compute pcgs
##
##  This filter indicates whether it is possible to compute a pcgs for <grp>
##  cheaply. Clearly, <grp> must be polycyclic in this case. However, not
##  for every polycyclic group there is a method to compute a pcgs at low
##  costs. This filter is used in the method selection mainly.
##  Note that this filter may change its value from false to true. 
##
DeclareFilter( "CanEasilyComputePcgs" );

# to satisfy method installation requirements
InstallTrueMethod(IsGroup,CanEasilyComputePcgs);


#############################################################################
##
#O  SubgroupByPcgs( <G>, <pcgs> )
##
DeclareOperation( "SubgroupByPcgs", [IsGroup, IsPcgs] );


#############################################################################
##
#O  AffineOperation( <gens>, <basisvectors>, <linear>, <transl> )
#O  AffineAction( <gens>, <basisvectors>, <linear>, <transl> )
##
##  return a list of matrices, one for each element of <gens>, which
##  corresponds to the affine action of the elements in <gens> on the
##  basis <basisvectors> via <linear> with translation <transl>.
DeclareOperation( "AffineAction", 
    [ IsList, IsMatrix, IsFunction, IsFunction ] );
DeclareSynonym( "AffineOperation", AffineAction );


#############################################################################
##
#O  LinearOperation( <gens>, <basisvectors>, <linear> )
#O  LinearAction( <gens>, <basisvectors>, <linear> )
##
##  returns a list of matrices, one for each element of <gens>, which
##  corresponds to the matrix action of the elements in <gens> on the
##  basis <basisvectors> via <linear>.
DeclareOperation( "LinearAction", [ IsList, IsMatrix, IsFunction ] );
DeclareSynonym( "LinearOperation",LinearAction);


#############################################################################
##
#M  IsSolvableGroup
##
InstallTrueMethod(
    IsSolvableGroup,
    IsPcGroup );


#############################################################################
##
#F  AffineOperationLayer( <G>, <gens>, <pcgs>, <transl> )
#F  AffineActionLayer( <G>, <gens>, <pcgs>, <transl> )
##
##  returns a list of matrices, one for each element of <gens>, which
##  corresponds to the affine action of <G> on the vector space corresponding
##  to the modulo pcgs <pcgs> with translation <transl>.
DeclareGlobalFunction( "AffineActionLayer" );
DeclareSynonym( "AffineOperationLayer",AffineActionLayer );


#############################################################################
##
#F  GeneratorsCentrePGroup( <G> )
#F  GeneratorsCenterPGroup( <G> )
##
DeclareGlobalFunction( "GeneratorsCentrePGroup" );

DeclareSynonym( "GeneratorsCenterPGroup", GeneratorsCentrePGroup );


#############################################################################
##
#F  LinearOperationLayer( <G>, <gens>, <pcgs> )
#F  LinearActionLayer( <G>, <gens>, <pcgs> )
##
##  returns a list of matrices, one for each element of <gens>, which
##  corresponds to the matrix action of <G> on the vector space corresponding
##  to the modulo pcgs <pcgs>.
DeclareGlobalFunction( "LinearActionLayer" );
DeclareSynonym( "LinearOperationLayer",LinearActionLayer );


#############################################################################
##
#F  VectorSpaceByPcgsOfElementaryAbelianGroup( <mpcgs>, <fld> )
##
##  returns the vector space over <fld> corresponding to the modulo pcgs
##  <mpcgs>. Note that <mpcgs> has to define an elementary abelian $p$-group
##  where $p$ is the characteristic of <fld>.
DeclareGlobalFunction(
    "VectorSpaceByPcgsOfElementaryAbelianGroup" );

#############################################################################
##
#F  GapInputPcGroup( <grp>, <string> )
##
DeclareGlobalFunction( "GapInputPcGroup" );

#############################################################################
##
#O  CanonicalSubgroupRepresentativePcGroup( <G>, <U> )
##
DeclareGlobalFunction( "CanonicalSubgroupRepresentativePcGroup" );

#############################################################################
##
#F  CentrePcGroup( <grp> )
##
DeclareGlobalFunction( "CentrePcGroup" );

#############################################################################
##
#A  OmegaSeries( G )
##
DeclareAttribute( "OmegaSeries", IsGroup );

#############################################################################
##
#E  grppc.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
##
