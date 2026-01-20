# Fitness Tracker App

A mobile fitness tracking application built with Flutter that helps users monitor their daily fitness activities, track workouts, calculate BMI, and manage their fitness goals.

## 📱 Project Overview

This is a cross-platform mobile fitness tracking application built with Flutter. The app provides a simple and intuitive interface for users to track their fitness activities, monitor health metrics, and stay motivated towards their fitness goals.

## ✨ Features

- **Home Dashboard**: View daily fitness statistics at a glance
  - Steps taken today
  - Calories burned
  - Workout completion status

- **Activity Tracking**: Add and record workout activities
  - Activity type (running, cycling, walking, etc.)
  - Duration in minutes
  - Calories burned

- **BMI Calculator**: Calculate Body Mass Index
  - Input weight (kg) and height (cm)
  - Automatic BMI category classification
  - Categories: Underweight, Normal, Overweight, Obese

- **Profile Management**: View personal information
  - Name
  - Age
  - Fitness goals

## 🚀 Getting Started

### Prerequisites

Before running this app, ensure you have the following installed:

- **Flutter SDK** (version 3.10.4 or higher)
  - Download from [flutter.dev](https://flutter.dev/docs/get-started/install)
  - Verify installation: `flutter doctor`

- **Dart SDK** (included with Flutter)

- **IDE** (optional but recommended):
  - Android Studio / IntelliJ IDEA
  - Visual Studio Code with Flutter extension
  - Or any text editor

- **Platform-specific requirements**:
  - **Android**: Android Studio with Android SDK
  - **iOS**: Xcode (macOS only)
  - **Web**: Chrome browser
  - **Windows/Linux**: Platform-specific build tools

### Installation

1. **Clone the repository** (or download the project):
   ```bash
   git clone <repository-url>
   cd fitness_tracker
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Verify Flutter setup**:
   ```bash
   flutter doctor
   ```

### Running the App

1. **Check available devices**:
   ```bash
   flutter devices
   ```

2. **Run the app**:
   ```bash
   flutter run
   ```

   Or run on a specific device:
   ```bash
   flutter run -d <device-id>
   ```

3. **Run in debug mode** (default):
   ```bash
   flutter run --debug
   ```

4. **Run in release mode**:
   ```bash
   flutter run --release
   ```

### Building the App

- **Android APK**:
  ```bash
  flutter build apk
  ```

- **Android App Bundle**:
  ```bash
  flutter build appbundle
  ```

- **iOS** (macOS only):
  ```bash
  flutter build ios
  ```

- **Web**:
  ```bash
  flutter build web
  ```

- **Windows**:
  ```bash
  flutter build windows
  ```

## 📁 Project Structure

```
fitness_tracker/
├── lib/
│   ├── main.dart                 # App entry point and main configuration
│   └── screens/
│       ├── home_screen.dart      # Home dashboard screen
│       ├── activity_screen.dart  # Activity tracking screen
│       ├── bmi_screen.dart       # BMI calculator screen
│       └── profile_screen.dart   # User profile screen
├── android/                      # Android platform-specific files
├── ios/                          # iOS platform-specific files
├── web/                          # Web platform-specific files
├── windows/                      # Windows platform-specific files
├── linux/                        # Linux platform-specific files
├── macos/                         # macOS platform-specific files
├── test/                         # Unit and widget tests
├── pubspec.yaml                  # Project dependencies and configuration
└── README.md                     # This file
```

## 🏗️ Code Architecture

### Main Components

#### 1. **main.dart** - Application Entry Point

The main file contains three key components:

- **`main()` function**: Entry point that initializes the Flutter app
- **`FitnessTrackerApp`**: Root widget that configures the app theme and Material Design 3
- **`MainPage`**: Main navigation container with bottom navigation bar

**Key Features:**
- Material Design 3 theme with green color scheme
- Custom text themes for consistent typography
- Custom button and input field styling
- Bottom navigation bar for screen switching

#### 2. **Screen Components**

Each screen is a separate widget class:

- **`HomeScreen`** (`home_screen.dart`):
  - StatelessWidget displaying daily statistics
  - Shows steps, calories, and workout status in cards

- **`ActivityScreen`** (`activity_screen.dart`):
  - StatefulWidget with form inputs
  - Text controllers for activity type, duration, and calories
  - Form validation and success feedback

- **`BMIScreen`** (`bmi_screen.dart`):
  - StatefulWidget with BMI calculation logic
  - Input validation for weight and height
  - BMI category classification (Underweight, Normal, Overweight, Obese)

- **`ProfileScreen`** (`profile_screen.dart`):
  - StatelessWidget displaying user profile information
  - Shows name, age, and fitness goal

### State Management

The app uses Flutter's built-in state management:

- **StatefulWidget**: Used for screens that need to manage state (ActivityScreen, BMIScreen, MainPage)
- **StatelessWidget**: Used for static screens (HomeScreen, ProfileScreen)
- **setState()**: Updates UI when state changes

### Navigation

- **Bottom Navigation Bar**: Fixed navigation bar with 4 tabs
  - Home (index 0)
  - Activity (index 1)
  - BMI (index 2)
  - Profile (index 3)
- **State-based screen switching**: Uses `currentIndex` to display the active screen

## 🎨 Design System

### Theme Configuration

- **Color Scheme**: Green-based Material Design 3 theme
- **Typography**: Custom text themes with consistent font sizes
- **Components**:
  - Elevated buttons: Green background, white text, rounded corners
  - Input fields: Outlined borders, rounded corners
  - Cards: Elevated cards with rounded corners

### UI Components

- **Material Design 3**: Modern Material Design components
- **Icons**: Material Icons for visual representation
- **Cards**: Used for displaying information
- **SnackBars**: Used for user feedback and error messages

## 📦 Dependencies

The app uses the following dependencies (defined in `pubspec.yaml`):

- **flutter**: Flutter SDK
- **cupertino_icons**: iOS-style icons

### Dev Dependencies

- **flutter_test**: Testing framework
- **flutter_lints**: Linting rules for code quality

## 🧪 Testing

Run tests using:

```bash
flutter test
```

## 📱 Screen Design Explanation

### 1. Home Screen
The Home screen displays daily fitness statistics:
- **Steps Today**: Total steps taken (currently shows sample data: 8,542 steps)
- **Calories Burned**: Total calories burned (sample: 1,245 calories)
- **Workout Status**: Number of workouts completed (sample: 2 workouts)

Uses card-based layout with icons for visual clarity.

### 2. Activity Screen
Allows users to add workout activities:
- **Activity Type**: Text input for activity name
- **Duration**: Numeric input for minutes
- **Calories Burned**: Numeric input for calories

Features:
- Form validation (all fields required)
- Success message on save
- Form clearing after successful save

### 3. BMI Calculator Screen
Calculates Body Mass Index:
- **Weight Input**: In kilograms
- **Height Input**: In centimeters
- **BMI Calculation**: Formula: `weight / (height/100)²`
- **Category Display**: Shows BMI category based on result

BMI Categories:
- Underweight: BMI < 18.5
- Normal: 18.5 ≤ BMI < 25
- Overweight: 25 ≤ BMI < 30
- Obese: BMI ≥ 30

Features:
- Input validation (positive numbers required)
- Real-time result display
- Visual feedback with card display

### 4. Profile Screen
Displays user profile information:
- **Name**: User's full name (currently: "Zulhilmi")
- **Age**: User's age (currently: "20 years")
- **Fitness Goal**: User's fitness objective (currently: "Fit and code")

Uses card layout with icons for each information item.

## 🎯 Target Audience

The primary target audience includes:

- **Students and young adults** starting their fitness journey
- **Fitness beginners** needing a simple tracking tool
- **Health-conscious individuals** monitoring daily activities
- **Anyone** wanting to calculate and understand their BMI

## 🔄 Navigation Flow

The app uses a bottom navigation bar for easy access:

1. **Home Tab** (🏠): View daily statistics
2. **Activity Tab** (🏃): Add new workouts
3. **BMI Tab** (⚖️): Calculate BMI
4. **Profile Tab** (👤): View profile information

The selected tab is highlighted in green, and users can instantly switch between screens.

## 💡 User-Centered Design Principles

- **Simple Interface**: Clean, uncluttered design focusing on one task per screen
- **Easy Navigation**: Familiar bottom navigation pattern
- **Clear Feedback**: SnackBars and visual indicators for user actions
- **Consistent Design**: Uniform styling across all screens
- **Accessible**: Large touch targets and readable text

## 🛠️ Technical Details

- **Platform**: Flutter (Cross-platform)
- **Language**: Dart 3.10.4+
- **UI Framework**: Material Design 3
- **Architecture**: Widget-based component architecture
- **State Management**: Flutter's built-in StatefulWidget
- **Navigation**: Bottom Navigation Bar
- **Minimum SDK**: Android API level varies by platform

## 📝 Code Style

The code follows Flutter best practices:

- Clear variable naming
- Proper widget separation
- Resource cleanup (dispose controllers)
- Input validation
- User feedback mechanisms
- Consistent code formatting

## 🚧 Future Enhancements

Potential improvements for future versions:

- [ ] Data persistence (local storage/database)
- [ ] Step counter integration with device sensors
- [ ] Activity history tracking
- [ ] Charts and graphs for progress visualization
- [ ] User authentication
- [ ] Cloud sync capabilities
- [ ] Workout templates
- [ ] Goal setting and tracking
- [ ] Social features (sharing progress)
- [ ] Dark mode support
- [ ] Multi-language support

## 📄 License

This project is for educational purposes.

## 👥 Contributing

This is a learning project. Feel free to fork and modify for your own use.

## 📞 Support

For issues or questions, please refer to the Flutter documentation:
- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)

## 🙏 Acknowledgments

Built with Flutter and Material Design 3.

---

**Note**: This app currently uses sample/static data. For production use, implement data persistence and real-time tracking features.
