# Desktop Power

![License](https://img.shields.io/github/license/zS1L3NT/desktop-power?style=for-the-badge) ![Languages](https://img.shields.io/github/languages/count/zS1L3NT/desktop-power?style=for-the-badge) ![Top Language](https://img.shields.io/github/languages/top/zS1L3NT/desktop-power?style=for-the-badge) ![Commit Activity](https://img.shields.io/github/commit-activity/y/zS1L3NT/desktop-power?style=for-the-badge) ![Last commit](https://img.shields.io/github/last-commit/zS1L3NT/desktop-power?style=for-the-badge)

This is a monorepository consisting of an Arduino script, Express server and Flutter application. The express server is the middleman to help the Flutter app and Arduino board communicate. This project was built so that I can turn my desktop on from anywhere outside the house.

I connected two wires to the push button in my computer's power button, the connected the wires to an ESP8266 Module. The ESP8266 will provide a LOW signal to one of the wires and ground the other wire, replicating LOW voltage across the button when it is pressed. The ESP8266 Module will constantly ask the Express server if the Flutter app has requested to press the button. This is how the Flutter app is able to turn the desktop on from anywhere

## Motivation

I keep forgetting to turn my desktop on at home when I leave for school, and sometimes I need to grab some files on my desktop by AnyDesk. This project allows me to turn my desktop on from anywhere without having to disturb any of my family members anymore

## Features

-   Turn the desktop on from anywhere

## Built with

-   Arduino
    -   ESP8266 WiFi
    -   ESP8266 HTTP Client
-  TypeScript & Express
-  Flutter
