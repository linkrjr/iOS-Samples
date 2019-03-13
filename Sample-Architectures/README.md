# Sample-Architectures

This repo is a collection of different iOS Architectures and frameworks playing together.

It is separated into differente XCode targets for each Architecture.

### MVC

This is Apple's MVC pattern implementation

### MVP

- https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93presenter

### MVP with Moya

Same as the above but includes Moya for the network layer

### MVVM

https://www.objc.io/issues/13-architecture/mvvm/
https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel

### MVVM + Functional Reactive Programming ( with RxSwift )

Same as the above but uses FRP to bind data between the View Model and the View

### PureMVC (http://puremvc.org/)

### ReSwift (http://reswift.github.io/ReSwift/master/)

ReSwift is a Redux-like implementation of the unidirectional data flow architecture in Swift. ReSwift helps you to separate three important concerns of your app’s components:

State: in a ReSwift app the entire app state is explicitly stored in a data structure. This helps avoid complicated state management code, enables better debugging and has many, many more benefits…
Views: in a ReSwift app your views update when your state changes. Your views become simple visualizations of the current app state.
State Changes: in a ReSwift app you can only perform state changes through actions. Actions are small pieces of data that describe a state change. By drastically limiting the way state can be mutated, your app becomes easier to understand and it gets easier to work with many collaborators.

### Riblets

Riblets is Uber's architecture

- https://github.com/uber/RIBs
- https://eng.uber.com/new-rider-app/
- https://eng.uber.com/tag/ribs/

### Viper

- https://www.objc.io/issues/13-architecture/viper/

## Pipeline

Next architectures to be implemented

- ELM - https://guide.elm-lang.org/architecture/
- Clean Swift - https://clean-swift.com/
- Coodinators

Frameworks to user

- Typhoon

## Backend

The backend is a simple nodejs expressjs app, in order to run you need nodejs environment setup. ( https://developer.mozilla.org/en-US/docs/Learn/Server-side/Express_Nodejs/development_environment ) 

Once you have nodejs setup, move into the backend folder and run the following command to install all the dependencies for the backend:

```
npm install
```

Then, the following to run the backend

```
npm start
```
