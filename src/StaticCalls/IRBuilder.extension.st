Extension { #name : 'IRBuilder' }

{ #category : '*StaticCalls' }
IRBuilder >> sendStatic: aMethod [

	^ self add: (IRSendStatic sendStatic: aMethod)
]
