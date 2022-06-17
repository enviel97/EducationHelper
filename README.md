Figma: https://www.figma.com/file/sBxdCDdGreDiYii1GJhpWI/Helper-Education

## Getting Start
This is an app that allows teachers to assign and grade assignments for ios and android

## Enviroment:

- Flutter: 2.13

## Technology:

- Firebase: get media file
- Cubit/ Bloc: state management
- Dio: request api
- Google

## Setup:

(note: local setup)

- Install Visual Studio Code (if don't have):
  - Download on: https://code.visualstudio.com
  - Install and use guild: https://code.visualstudio.com/docs/getstarted/introvideos
- Install Flutter (if don't have):
  - Install guild: https://docs.flutter.dev/get-started/install
  - Setup to vs-code: https://docs.flutter.dev/development/tools/vs-code#:~:text=Click%20Run%20%3E%20Start%20Without%20Debugging,%2C%20or%20press%20Ctrl%20%2B%20F5%20

## Run:

- Run with virtual device
  (note: required Android Studio or XCode)

  - On Dev mode: F5 -> chose simulator / emulator
  - On Build mode: Ctrl + F5 -> chose simulator / emulator

- Run with real device

  - Open dev mode
    (Each device will have a different way to enter Dev mode,
    keyword: os version + turn on dev mode)
  - Build
    - On Dev mode: F5
    - On Build mode: Ctrl + F5
  - (option) on multi device or don't show device:
    - Chose device with device name

## Structure

### constants:

- app_theme: default apptheme
- colors: color collections use in color schema
- constants: text use in all app
- typing: Spacing, textStyle, ...

### helpers:

- extensions: extentsion properties
- modules: add modules like read pdf, csv, ...
- stream: streams controll used in app
- ultils: helper functions, validation functions, widgets config functions...
- widgets: widgets like error ui, file error ui, animation on navigator ui, ...

### models:

mapping json to object with some helper method

### roots: default app config

- bloc: global Bloc, use toast/ loading/ get current user, ...
- miragate (middleware): default configuration to use defined feature on External Feature
- app_root.dart: define root

### views:

Each feature is file in views with root dir:

- parent view:

  - have multi children views
  - routes.dart: MaterialApp define

- children views

  - adapter/ adapters:

    - extends IAdapter
    - inject to roots/app_root.dart -> \_configRouteApp();
    - Have way to connect feature like:
      - layout: Required and have new current widget
      - function navigator (options)

  - bloc/ blocs:

    - Request to api
    - use Cubit/ Bloc to state managerment

  - pages (options):

    - options 1: have child views
    - options 2: have ui in views

  - widgets (options): have widgets use in views like text, button, ...

  - dialogs (options): dialog use in views

  - placeholder (options): loading widgets

  - {view-file-name}.dart

### main.dart:

where all begin
