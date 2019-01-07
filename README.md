# DemoWeatherApp

This is a demo app for displaying weather forecast of next 5 days for any location using OpenWeatherMap 5 day weather forecast API. This app is developed in Swift language version 4.

## Features

I've tried to demonstrate following skills & design practices which I'm interested in:
- MVVM
- Observar pattern
- Swift Generics
- Storyboard & Autolayouts

There's a lot of things I'd like to add to this project with more time:
- Tests verifying request inputs
- Move all UI work to code
- Better tests around state changes
- Error handling
- Localization
- Accessibility

## Requirements

* Xcode 9+
* iOS 10+
* Swift 4


## How to build

For dependency manager, I have used cocoapods. 

1. Required cocoapods library ->  `SwiftyJSON` (https://github.com/SwiftyJSON/SwiftyJSON)

1. Open Terminal app.
2. Change directory to the project folder. `cd $project_dir`
3. Use `ls` to list all the file to check whether *Podfile* file is in the folder? 
4. If the *Podfile* has been found, then execute `pod install`, else use `pod init` to install the cocoapods.
5. Once complete installation, open *DemoWeatherApp.xcworkspace* file with Xcode.
6. Press *Cmd + B* to build the app.
7. Press *Cmd + R* to run the app on Simulator.


I have uploaded this code on public github repository with below url:
https://github.com/rohitgarg4989/DemoWeatherApp.git

Suggestions welcome.
