# Navigator
Navigator is an attempt at building something akin to the iOS coordinator pattern into a pure-SwiftUI environment.

## Example
The example project is located iside the Examples folder

## Requirements
* macOS 13+
* iOS 16+
* watchOS 9+
* tvOS 16+

## Installation

### Swift Package Manager

To integrate Navigator into your project using Swift Package Manager, add the following dependency to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/stephen-wojcik/Navigator.git", from: "1.0.0")
]
```

## Usage

* Within the factory method for your root view, `import Navigator` and create a new navigation root: `let navigator = SwiftUINavigator.makeRoot()`
* Don't forget to attach the navigator to the view via `YOUR_VIEW.root(navigator: navigator)`
* Any subsequent navigation from your view can be triggered from your ViewModel, for example:
```swift
viewModel.onNextPageTapped = {
  navigator.push(destination: NextPageViewFactory().make(navigator:))
}
```
* Subsequent views will not need to create their own navigator, nor will they need to attach it to the view - all you need to do is provide a `make` method which takes a `Navigator` and the library will handle this dance for you
* See `HomeViewFactory` within the examples project for more information




