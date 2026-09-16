Extension { #name : 'RBProgramNode' }

{ #category : '*StaticCalls' }
RBProgramNode >> hasStaticCall [

	^ (((self allChildren select: #isMessage)) select:#isStaticCall) isNotEmpty 
]
