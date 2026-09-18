Class {
	#name : 'CompilerStaticCallsTest',
	#superclass : 'TestCase',
	#category : 'StaticCalls-Tests',
	#package : 'StaticCalls-Tests'
}

{ #category : 'tests - compiler' }
CompilerStaticCallsTest >> testImplicitStaticCallResolveToCorrectMethodLookup [

	| compiledMethod irMethod |
	
	compiledMethod := OpalCompiler new compile: 'foo ^ 13 _factorial'.
	
	irMethod := compiledMethod ast generateIR.
	
	self assert: irMethod allSequences first sequence second calledMethod equals: Integer >> #factorial
	
]

{ #category : 'tests - parsing' }
CompilerStaticCallsTest >> testMethodContainsStaticCall [

	| ast |
	
	ast := RBParser parseMethod: 'foo ^ 13 _factorial'.
	self assert: ast children first statements first value class equals: RBStaticMessageNode 
	
]

{ #category : 'tests - compiler' }
CompilerStaticCallsTest >> testParsingBinaryStaticMessage [

	| compiledMethod |

	compiledMethod := RBParser parseExpression: ' 
	|aCol|
	aCol := OrderedCollection new.
	^ 2 _SmallInteger_+ 2'.

	self assert: (compiledMethod statements second children first isKindOf: RBStaticMessageNode) .
	self assert: compiledMethod statements second children first isBinary.
	
]

{ #category : 'tests - compiler' }
CompilerStaticCallsTest >> testParsingKeywordStaticMessage [

	| compiledMethod irMethod |

	compiledMethod := RBParser parseExpression: ' 
	|aCol|
	aCol := OrderedCollection new.
	^ 2 _Object_as: 2'.

	self assert: (compiledMethod statements second children first isKindOf: RBStaticMessageNode) .

	
]

{ #category : 'tests - runtime' }
CompilerStaticCallsTest >> testReflectivlyInvokeSpecificMethod [
	| factorialResult |
	
	factorialResult := 6 factorial.
	
	SmallInteger compileSilently: 'factorial ^42'.
	
	self assert: 6 factorial equals: 42.
	self assert: (( Integer>>#factorial )  invokeWithReceiver:  6 withArgs: {} ) equals: factorialResult
]

{ #category : 'tests - compiler' }
CompilerStaticCallsTest >> testStaticCallCompilerEmitCorrectBytecode [

	| compiledMethod |
	compiledMethod := OpalCompiler new compile: 'foo ^ 13 _factorial'.

	self assert: (compiledMethod bytecodes at: 2) equals: 246
]

{ #category : 'tests - runtime' }
CompilerStaticCallsTest >> testStaticCallFalseReceiver [
	self fail.
	"following code will crash the VM if it support static calls (bytecode 246)"
	"self should: [ true _SmallInteger_asFloat ] raise: Exception"

]

{ #category : 'tests - compiler' }
CompilerStaticCallsTest >> testStaticCallIrStaticNodeBinary [

	| compiledMethod irMethod |

	compiledMethod := CompilerStaticCallsTest compile: 'foo
	|aCol|
	aCol := OrderedCollection new.
	^ 2 _SmallInteger_+ 2'.
	irMethod :=  (CompilerStaticCallsTest>>#foo) ast generateIR.
	
	[self assert: irMethod allSequences first sequence seventh calledMethod equals: SmallInteger>>#+ ]
		ensure: [ CompilerStaticCallsTest removeSelector: #foo ]
	
]

{ #category : 'tests - compiler' }
CompilerStaticCallsTest >> testStaticCallIrStaticNodeKeyword [

	| compiledMethod irMethod |

	compiledMethod := CompilerStaticCallsTest compile: 'foo 
	|aCol|
	aCol := OrderedCollection new.
	^ self _Object_as: CompilerStaticCallsTest'.
	
	irMethod :=  (CompilerStaticCallsTest>>#foo) ast generateIR.
	
	[self assert: irMethod allSequences first sequence seventh calledMethod equals: Object >>#as:]
		ensure: [ CompilerStaticCallsTest removeSelector: #foo ]
	
	
]

{ #category : 'tests - runtime' }
CompilerStaticCallsTest >> testStaticCallWithExplicitMethod [
	| factorialResult |
	factorialResult := 6 factorial.
	
	SmallInteger compileSilently: 'factorial ^42'.
	
	self assert: 6 factorial equals: 42.	
	self assert: 6 _Integer_factorial equals: factorialResult
]

{ #category : 'tests - runtime' }
CompilerStaticCallsTest >> testStaticCallWithoutAnExplicitMethod [
	"_asFloat means that a lookup is done at compile time and the looked up method is bound to this call site"
	| factorialResult |
	
	factorialResult := 6 factorial.
	
	self assert: 6 _factorial equals: factorialResult.
	
	SmallInteger compileSilently: 'factorial ^42'.
	
	self assert: 6 _factorial equals: factorialResult.	"bound at compile time when SmallInteger>>factorial did not exist"
	

]

{ #category : 'tests - compiler' }
CompilerStaticCallsTest >> testStaticMessageKeyword [

	| compiledMethod |
	compiledMethod := OpalCompiler new compile: 'foo 
	|aCol|
	
	aCol := OrderedCollection new.
	^ self _Object_appendTo: aCol'.

	self assert: (compiledMethod bytecodes at: 6) equals: 246
]

{ #category : 'tests - parsing' }
CompilerStaticCallsTest >> testStaticMessageNodeCreation [

	| ast |
	
	ast := RBParser parseExpression: '13 _factorial'.
	self assert: ast class equals: RBStaticMessageNode
	
]
