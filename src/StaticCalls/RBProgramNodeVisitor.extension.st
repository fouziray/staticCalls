Extension { #name : 'RBProgramNodeVisitor' }

{ #category : '*StaticCalls' }
RBProgramNodeVisitor >> visitStaticMessageNode: aStaticMessageNode [
	
	^ self visitMessageNode: aStaticMessageNode
]
