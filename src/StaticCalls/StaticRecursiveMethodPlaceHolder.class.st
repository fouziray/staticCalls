Class {
	#name : 'StaticRecursiveMethodPlaceHolder',
	#superclass : 'Object',
	#instVars : [
		'selector'
	],
	#category : 'StaticCalls',
	#package : 'StaticCalls'
}

{ #category : 'accessing' }
StaticRecursiveMethodPlaceHolder >> numArgs [

	^ selector numArgs
]

{ #category : 'accessing' }
StaticRecursiveMethodPlaceHolder >> selector: aString [

	selector := aString
]
