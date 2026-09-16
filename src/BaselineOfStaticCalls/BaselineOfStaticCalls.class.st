Class {
	#name : 'BaselineOfStaticCalls',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfStaticCalls',
	#package : 'BaselineOfStaticCalls'
}

{ #category : 'baselines' }
BaselineOfStaticCalls >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'VMMaker' with: [
				spec repository: 'github://fouziray/pharo-vm:newMovingChange/smalltalksrc' ];
			package: 'StaticCalls';
			package: 'StaticCalls-Tests' with: [ spec requires: #( 'StaticCalls' ) ].

		spec
			group: 'default' with: #( 'StaticCalls-Tests');
			group: 'vmsupport' with: #( 'VMMaker' );
			group: 'all' with: #( 'default' 'vmsupport' )
	]
]
