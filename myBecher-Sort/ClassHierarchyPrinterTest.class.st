Class {
	#name : #ClassHierarchyPrinterTest,
	#superclass : #TestCase,
	#instVars : [
		'printer'
	],
	#category : #'myBecher-Sort-ForPharo'
}

{ #category : #tests }
ClassHierarchyPrinterTest >> setUp [ 
	super setUp.
	printer := ClassHierarchyPrinter new.
]

{ #category : #tests }
ClassHierarchyPrinterTest >> testOnlyRBASTNodes [

	printer 
		forClass: RBNode; 
		doNotShowState;
		doNotShowSuperclasses;
		excludedClasses: (RBNode withAllSubclasses select: [ :each | each name beginsWith: 'RBPattern' ]);
		limitedToClasses: (RBNode withAllSubclasses select: [:each | each name beginsWith: 'RB']).
	self assert: printer print equals: 
'RBNode
	RBComment
	RBProgramNode
		RBMethodNode
		RBPragmaNode
		RBReturnNode
		RBSequenceNode
		RBValueNode
			RBArrayNode
			RBAssignmentNode
			RBBlockNode
			RBCascadeNode
			RBLiteralNode
				RBLiteralArrayNode
				RBLiteralValueNode
			RBMessageNode
			RBParseErrorNode
			RBVariableNode
				RBArgumentNode
				RBGlobalNode
				RBInstanceVariableNode
				RBSelfNode
				RBSuperNode
				RBTemporaryNode
				RBThisContextNode
	RBSlotInitializationNode
'
]

{ #category : #tests }
ClassHierarchyPrinterTest >> testPrintClassNamesOnly [

	printer 
		forClass: Rectangle; 
		doNotShowState;
		doNotShowSuperclasses.
	self assert: printer print equals: 
'Rectangle
	CharacterBlock
'
]

{ #category : #tests }
ClassHierarchyPrinterTest >> testPrintHierarchyOfPoint [

	printer forClass: Point. 
	self assert: printer print equals:
'ProtoObject #()
	Object #()

		Point #(#x #y)
'
]

{ #category : #tests }
ClassHierarchyPrinterTest >> testPrintHierarchyOfPointNoState [

	printer forClass: Point ; doNotShowState.
	self assert: printer print equals:
'ProtoObject
	Object

		Point
'
]

{ #category : #tests }
ClassHierarchyPrinterTest >> testPrintHierarchyOfPointNoSuperclasses [

	printer 
		forClass: Point;
		doNotShowSuperclasses.
	self assert: printer print equals: 'Point #(#x #y)
'
]

{ #category : #tests }
ClassHierarchyPrinterTest >> testPrintHierarchyOfRectangle [

	printer forClass: Rectangle. 
	self assert: printer print equals:
'ProtoObject #()
	Object #()

		Rectangle #(#origin #corner)
			CharacterBlock #(#stringIndex #text #textLine)
'
]

{ #category : #tests }
ClassHierarchyPrinterTest >> testPrintHierarchyOfRectangleNoSuperclasses [

	printer 
		forClass: Rectangle; 
		doNotShowSuperclasses.
	self assert: printer print equals:
'Rectangle #(#origin #corner)
	CharacterBlock #(#stringIndex #text #textLine)
'
]

{ #category : #tests }
ClassHierarchyPrinterTest >> testPrintHierarchyOfRectangleWithFilteredClasses [

	printer forClass: Rectangle. 
	printer limitedToClasses: { Rectangle }.
	self assert: printer print equals: 
'ProtoObject #()
	Object #()

		Rectangle #(#origin #corner)
'
]
