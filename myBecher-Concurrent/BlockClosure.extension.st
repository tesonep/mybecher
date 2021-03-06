Extension { #name : #BlockClosure }

{ #category : #'*myBecher-Concurrent' }
BlockClosure >> promise [
	^ self promiseAt: Processor activePriority
]

{ #category : #'*myBecher-Concurrent' }
BlockClosure >> promiseAt: aPriority [
	"Answer a promise that represents the result of the receiver execution
	at the given priority."
	| promise |
	promise := MyPromise new.
	[ promise value: self value ] forkAt: aPriority.
	^ promise
]

{ #category : #'*myBecher-Concurrent' }
BlockClosure >> promiseBlockWithErrorHandling: aPromise [
	"Answer a block that evaluates the receiver as a Promise."

	^[[[aPromise value: self value] on: UnhandledError
		do: [:ex |
			"An exception is being raised. save it so that the Promise will raise it instead of returning a value. "
			aPromise raisedException: ex parameter.
			ex return]]
		on: MyTerminateException
		do: [:ex |
			aPromise raisedException: (MyPromiseTerminateException new
						parameter: ex;
						errorString: nil).
			ex return]]
]
