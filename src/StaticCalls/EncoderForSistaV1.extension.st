Extension { #name : 'EncoderForSistaV1' }

{ #category : '*StaticCalls' }
EncoderForSistaV1 >> genSendStatic: methodLiteralOffset [

	stream
		nextPut: 246;
		nextPut: methodLiteralOffset
]
