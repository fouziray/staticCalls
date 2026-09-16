Extension { #name : 'CompiledMethod' }

{ #category : '*StaticCalls' }
CompiledMethod >> invokeWithReceiver: receiver withArgs: anArrayOfArgs [

	^ self valueWithReceiver: receiver arguments: anArrayOfArgs
]
