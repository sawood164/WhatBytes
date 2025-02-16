# WhatBytes - Task Management App

A modern Flutter task management application with Firebase integration and beautiful UI.


## Key Features

🎯 **Task Management**
- Create and manage tasks with priorities (High, Medium, Low)
- Priority-based color coding for better visualization
- Task completion tracking
- Swipe to delete tasks

⏰ **Time Organization**
- Today's tasks view
- Tomorrow's tasks view
- Weekly task overview
- Complete task history

🔐 **Authentication**
- Email/Password signup/login
- Firebase authentication
- Persistent login state
- Secure data storage

🎨 **UI Features**
- Clean, modern interface
- Dark/Light theme support
- Priority-based task colors
- Responsive design
- Smooth animations

## Tech Stack

- Flutter SDK ^3.7.0
- Firebase (Auth, Firestore)
- Provider State Management
- Hive Local Storage
- Google Fonts
- Lottie Animations

## Dependencies
yaml
dependencies:
flutter_bloc: ^8.1.3
hive: ^2.2.3
provider: ^6.1.2
firebase_core: ^2.27.1
firebase_auth: ^4.17.9
cloud_firestore: ^4.15.9
google_fonts: ^6.1.0
lottie: ^2.4.0


## Project Structure

lib/
├── core/
│ ├── constants.dart
│ ├── theme.dart
│ └── transitions.dart
├── data/
│ ├── models/
│ └── local_storage.dart
├── presentation/
│ ├── screens/
│ └── widgets/
├── providers/
├── services/
└── main.dart


## Quick Start

1. **Clone & Install**
bash
git clone [repository-url]
cd taskmaster
flutter pub get

2. **Firebase Setup**
- Create Firebase project
- Add Android/iOS apps
- Download config files
- Enable Email auth

3. **Run App**
flutter run
