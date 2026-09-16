Class {
	#name : 'CompilerStaticCallTest',
	#superclass : 'TestCase',
	#category : 'StaticCallExp-Tests',
	#package : 'StaticCallExp-Tests'
}

{ #category : 'tests - support' }
CompilerStaticCallTest >> foo [ 
	|aCol|
	aCol := OrderedCollection new.
	^ self _Object_as: CompilerStaticCallTest
]

{ #category : 'tests - support' }
CompilerStaticCallTest >> foo2 [ 
	|aCol|
	aCol := OrderedCollection new.
	^ 2 _SmallInteger_+ 2
]

{ #category : 'tests - compiler' }
CompilerStaticCallTest >> testImplicitStaticCallResolveToCorrectMethodLookup [

	| compiledMethod irMethod |
	
	compiledMethod := OpalCompiler new compile: 'foo ^ 13 _factorial'.
	
	irMethod := compiledMethod ast generateIR.
	
	self assert: irMethod allSequences first sequence second calledMethod equals: Integer >> #factorial
	
]

{ #category : 'tests - parsing' }
CompilerStaticCallTest >> testMethodContainsStaticCall [

	| ast |
	
	ast := RBParser parseMethod: 'foo ^ 13 _factorial'.
	self assert: ast children first statements first value class equals: RBStaticMessageNode 
	
]

{ #category : 'tests - compiler' }
CompilerStaticCallTest >> testParsingBinaryStaticMessage [

	| compiledMethod irMethod |

	compiledMethod := RBParser parseExpression: ' 
	|aCol|
	aCol := OrderedCollection new.
	^ 2 _SmallInteger_+ 2'.

	self assert: (compiledMethod statements second children first isKindOf: RBStaticMessageNode) .
	self assert: compiledMethod statements second children first isBinary.
	
]

{ #category : 'tests - compiler' }
CompilerStaticCallTest >> testParsingKeywordStaticMessage [

	| compiledMethod irMethod |

	compiledMethod := RBParser parseExpression: ' 
	|aCol|
	aCol := OrderedCollection new.
	^ 2 _Object_as: 2'.

	self assert: (compiledMethod statements second children first isKindOf: RBStaticMessageNode) .

	
]

{ #category : 'tests - runtime' }
CompilerStaticCallTest >> testReflectivlyInvokeSpecificMethod [
	
	| factorialResult |
	
	factorialResult := 6 factorial.
	
	SmallInteger compileSilently: 'factorial ^42'.
	
	self assert: 6 factorial equals: 42.
	self assert: (( Integer>>#factorial )  invokeWithReceiver:  6 withArgs: {} ) equals: factorialResult.
	
	SmallInteger removeSelector: #factorial.
]

{ #category : 'tests - compiler' }
CompilerStaticCallTest >> testStaticCallCompilerEmitCorrectBytecode [

	| compiledMethod |
	compiledMethod := OpalCompiler new compile: 'foo ^ 13 _factorial'.

	self assert: (compiledMethod bytecodes at: 2) equals: 246
]

{ #category : 'tests - compiler' }
CompilerStaticCallTest >> testStaticCallFalseReceiver [

self should: [ true _SmallInteger_asFloat ] raise:  Exception

]

{ #category : 'tests - compiler' }
CompilerStaticCallTest >> testStaticCallIrStaticNodeBinary [

	| compiledMethod irMethod |

	compiledMethod := CompilerStaticCallTest compile: 'foo2 
	|aCol|
	aCol := OrderedCollection new.
	^ 2 _SmallInteger_+ 2'.
	irMethod :=  (CompilerStaticCallTest>>#foo2) ast generateIR.
	self assert: irMethod allSequences first sequence seventh calledMethod equals: SmallInteger>>#+
	
]

{ #category : 'tests - compiler' }
CompilerStaticCallTest >> testStaticCallIrStaticNodeKeyword [

	| compiledMethod irMethod |

	compiledMethod := CompilerStaticCallTest compile: 'foo 
	|aCol|
	aCol := OrderedCollection new.
	^ self _Object_as: CompilerStaticCallTest'.
	
	irMethod :=  (CompilerStaticCallTest>>#foo) ast generateIR.
	self assert: irMethod allSequences first sequence seventh calledMethod equals: Object >>#as:
	
]

{ #category : 'tests - runtime' }
CompilerStaticCallTest >> testStaticCallWithExplicitMethod [

	self assert: 4 _Integer_factorial equals: 4 factorial
]

{ #category : 'tests - runtime' }
CompilerStaticCallTest >> testStaticCallWithoutAnExplicitMethod [
	"_asFloat means that a lookup is done at compile time and the looked up method is bound to this call site"
	self assert: 13 _asFloat equals: 13 asFloat
]

{ #category : 'tests - compiler' }
CompilerStaticCallTest >> testStaticMessageKeyword [

	| compiledMethod |
	compiledMethod := OpalCompiler new compile: 'foo 
	|aCol|
	
	aCol := OrderedCollection new.
	^ self _Object_appendTo: aCol'.

	self assert: (compiledMethod bytecodes at: 6) equals: 246
]

{ #category : 'tests - parsing' }
CompilerStaticCallTest >> testStaticMessageNodeCreation [

	| ast |
	
	ast := RBParser parseExpression: '13 _factorial'.
	self assert: ast class equals: RBStaticMessageNode
	
]
