Extension { #name : 'SpPresenter' }

{ #category : '*myBecher-WindowProfile' }
SpPresenter >> initialPosition [

	^ self position
]

{ #category : '*myBecher-WindowProfile' }
SpPresenter >> initializeWindow: aWindowPresenter [
	"override this to set window values before opening. 
	 You may want to add a menu, a toolbar or a statusbar"

	"IMPORTANT: Please ovirride this method and set yourself the informations you want in your window.
	The content of this method is here to help the transition between Spec 1 and 2.
	In the next Spec version the content of this method will be removed and it will do nothing by default because the goal is to remove the management of all of those informations from Composable to put them in WindowPresenter."

	aWindowPresenter
		title: self title;
		initialExtent: (self extent ifNil: [self class preferredExtent]);
		initialPosition: self initialPosition;
		windowIcon: self windowIcon;
		whenResizingDo: [ :ann | self preferredExtent: ann newSize ].
]

{ #category : '*myBecher-WindowProfile' }
SpPresenter >> position [

	^ position
]

{ #category : '*myBecher-WindowProfile' }
SpPresenter >> position: aPoint [

	position := aPoint
]
