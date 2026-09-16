Extension { #name : 'IRPrinter' }

{ #category : '*StaticCalls' }
IRPrinter >> visitStaticSend: send [

	stream nextPutAll: 'staticSend: '.
	send calledMethod selector printOn: stream
]
