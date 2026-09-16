Extension { #name : 'IRTranslator' }

{ #category : '*StaticCalls' }
IRTranslator >> visitStaticSend: anIRStaticSend [

	gen sendStatic: anIRStaticSend calledMethod
]
