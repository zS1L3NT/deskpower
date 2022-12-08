# DeskPower

![License](https://img.shields.io/github/license/zS1L3NT/deskpower?style=for-the-badge) ![Languages](https://img.shields.io/github/languages/count/zS1L3NT/deskpower?style=for-the-badge) ![Top Language](https://img.shields.io/github/languages/top/zS1L3NT/deskpower?style=for-the-badge) ![Commit Activity](https://img.shields.io/github/commit-activity/y/zS1L3NT/deskpower?style=for-the-badge) ![Last commit](https://img.shields.io/github/last-commit/zS1L3NT/deskpower?style=for-the-badge)

This is a monorepository consisting of an Arduino script, Express server and Flutter application. The express server is the middleman to help the Flutter app and Arduino board communicate. This project was built so that I can turn my desktop on from anywhere outside the house.

I connected two wires to the push button in my computer's power button, then connected the wires to an ESP8266 Module. The ESP8266 Module will provide a LOW signal to one of the wires and ground the other wire, replicating LOW voltage across the button when it is pressed normally. The ESP8266 Module will constantly ask the Express server if the Flutter app has requested to press the button. This is how the Flutter app is able to turn the desktop on from anywhere

## Motivation

I keep forgetting to turn my desktop on at home when I leave for school, and sometimes I need to grab some files on my desktop by AnyDesk. Because AnyDesk allows unattended access to my desktop, all I needed to do was to find a way to physically turn my desktop on. Furthermore, GeekOut 2022 gave us a free ESP8266 Module and I had no use for it before this project.

## Features

-   Turn the desktop on from anywhere

## Built with

-   Arduino
    -   ESP8266 WiFi
    -   ESP8266 HTTP Client
-   NodeJS
    -   TypeScript
        -   [![@types/cors](https://img.shields.io/github/package-json/dependency-version/zS1L3NT/deskpower/dev/@types/cors?style=flat-square&filename=web-express-deskpower%2Fpackage.json)](https://npmjs.com/package/@types/cors)
        -   [![@types/express](https://img.shields.io/github/package-json/dependency-version/zS1L3NT/deskpower/dev/@types/express?style=flat-square&filename=web-express-deskpower%2Fpackage.json)](https://npmjs.com/package/@types/express)
        -   [![@types/node](https://img.shields.io/github/package-json/dependency-version/zS1L3NT/deskpower/dev/@types/node?style=flat-square&filename=web-express-deskpower%2Fpackage.json)](https://npmjs.com/package/@types/node)
        -   [![ts-node](https://img.shields.io/github/package-json/dependency-version/zS1L3NT/deskpower/dev/ts-node?style=flat-square&filename=web-express-deskpower%2Fpackage.json)](https://npmjs.com/package/ts-node)
        -   [![typescript](https://img.shields.io/github/package-json/dependency-version/zS1L3NT/deskpower/dev/typescript?style=flat-square&filename=web-express-deskpower%2Fpackage.json)](https://npmjs.com/package/typescript)
    -   Express
        -   [![cors](https://img.shields.io/github/package-json/dependency-version/zS1L3NT/deskpower/cors?style=flat-square&filename=web-express-deskpower%2Fpackage.json)](https://npmjs.com/package/cors)
        -   [![dotenv](https://img.shields.io/github/package-json/dependency-version/zS1L3NT/deskpower/dotenv?style=flat-square&filename=web-express-deskpower%2Fpackage.json)](https://npmjs.com/package/dotenv)
        -   [![express](https://img.shields.io/github/package-json/dependency-version/zS1L3NT/deskpower/express?style=flat-square&filename=web-express-deskpower%2Fpackage.json)](https://npmjs.com/package/express)
-   Flutter
    -   Icon & Splash
        -   [![flutter_launcher_icons](https://img.shields.io/badge/flutter__launcher__icons-%5E0.11.0-blue?style=flat-square)](https://pub.dev/packages/flutter_launcher_icons)
        -   [![flutter_native_splash](https://img.shields.io/badge/flutter__native__splash-%5E2.2.16-blue?style=flat-square)](https://pub.dev/packages/flutter_native_splash)
    -   Miscellaneous
        -   [![http](https://img.shields.io/badge/http-%5E0.13.5-blue?style=flat-square)](https://pub.dev/packages/http)
        -   [![timeago](https://img.shields.io/badge/timeago-%5E3.3.0-blue?style=flat-square)](https://pub.dev/packages/timeago)
