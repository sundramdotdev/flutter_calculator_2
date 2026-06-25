# Flutter Calculator

A modern calculator application built with Flutter.

This project started as my very first Flutter application. Every line of the original version was written by me while learning Flutter and mobile development fundamentals. The current version is a complete redesign focused on clean architecture, premium UI/UX, smooth animations, and practical utility tools.

## Features

### Calculator

- Basic arithmetic operations
- Parentheses support
- Percentage calculations
- Decimal calculations
- Real-time expression evaluation
- Responsive display handling
- Calculation history

### Scientific Calculator

- Trigonometric functions
- Logarithmic functions
- Square root calculations
- Factorial calculations
- Mathematical constants
- Advanced operations

### GST Calculator

- GST amount calculation
- Inclusive GST mode
- Exclusive GST mode
- CGST and SGST breakdown
- Total amount calculation

### EMI Calculator

- Monthly EMI calculation
- Total interest calculation
- Total payable amount
- Loan summary

### SIP Calculator

- Monthly investment planning
- Estimated returns calculation
- Maturity value prediction
- Investment growth visualization

### Age Calculator

- Exact age calculation
- Years, months, and days
- Total days lived
- Total weeks lived
- Total months lived

### Unit Converter

- Length
- Weight
- Temperature
- Area
- Volume
- Speed
- Time
- Data Storage

## UI & UX

- Premium Industrial Minimalism design
- Material 3 design system
- Carbon & Copper color palette
- Space Grotesk typography
- Inter typography
- Smooth animations
- Adaptive layouts
- Tablet support
- Desktop support
- Dark mode
- Light mode

## Screenshots

### Calculator

Calculator

Calculator

### Tools Dashboard

Tools

Tools

### Scientific Calculator

Scientific

Scientific

### Settings

Settings

Settings

## Tech Stack

- Flutter
- Dart
- Riverpod
- GoRouter
- Isar Database
- Material 3

## Local Storage

All data is stored locally on the device.

Stored data includes:

- Calculation history
- Theme preferences
- Saved calculations
- User settings
- Recent tools

No backend services are required.

No user accounts are required.

No internet connection is required for core functionality.

## Project Structure

lib/  
├── core/  
├── features/  
│ ├── calculator/  
│ ├── scientific/  
│ ├── gst/  
│ ├── emi/  
│ ├── sip/  
│ ├── age/  
│ ├── converter/  
│ └── settings/  
├── shared/  
├── routes/  
└── main.dart

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio or VS Code

### Installation

git clone <https://github.com/your-username/flutter_calculator_2.git>  
<br/>cd flutter_calculator  
<br/>flutter pub get  
<br/>flutter run

## Build Release

### Android APK

flutter build apk --release

### Split APKs

flutter build apk --release --split-per-abi

### App Bundle

flutter build appbundle --release

## Roadmap

### Completed

- Calculator UI redesign
- Premium design system
- Responsive layouts
- Local storage integration
- History management

### Planned

- Export calculation history
- Import history
- Widget support
- Enhanced analytics
- More converter categories
- Additional financial tools

## Why This Project Matters

This repository represents my growth as a Flutter developer.

The original version was my first Flutter project. Instead of abandoning it, I chose to redesign and improve it using better architecture, cleaner code, improved UI/UX practices, local persistence, animations, and advanced utility tools.

This project serves as a record of that progression and demonstrates my commitment to continuous improvement as a developer.

## License

This project is licensed under the MIT License.
