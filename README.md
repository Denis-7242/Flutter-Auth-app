# Lock In - Modern Flutter Authentication App

A modern, secure Flutter authentication application with Firebase integration, featuring a clean architecture and beautiful UI.

## 📱 Features

### Authentication
- 🔐 Email/Password authentication with Firebase
- 🔒 Strong password validation with real-time feedback
- 👁️ Password visibility toggle
- 🔄 Smooth animations and transitions
- ⚡ Loading states and error handling
- 📧 Email verification support
- 🚪 Secure logout functionality

### Home Screen
- 📊 User dashboard with statistics
- 📝 Quick actions menu
- 🎨 Modern card-based layout
- 👤 User profile section
- 🔔 Notifications (coming soon)
- 📱 Bottom navigation bar with 3 screens

### Account Screen
- 👤 User profile with avatar and initials
- 📧 Display user email and account info
- 📅 Member since and last sign-in dates
- ✅ Email verification status with action button
- 🔐 Password reset functionality
- ⚙️ Account settings (Profile, Notifications, Appearance)
- 🔒 Security settings (2FA coming soon)
- ⚠️ Danger zone (Delete account, Logout)

### Password Security Requirements
- ✅ Minimum 8 characters
- ✅ At least one uppercase letter (A-Z)
- ✅ At least one lowercase letter (a-z)
- ✅ At least one number (0-9)
- ✅ At least one special character (!@#$%^&*(),.?":{}|<>)

---

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:
- Flutter SDK (3.0.0 or higher)
- Android Studio or VS Code with Flutter extensions
- Git
- A Google account for Firebase

### Check Flutter Installation
```bash
flutter --version
flutter doctor
```

---

## 🔥 Firebase Setup (Detailed Guide)

### Step 1: Create a Firebase Project

1. **Go to Firebase Console**
   - Visit [https://console.firebase.google.com/](https://console.firebase.google.com/)
   - Sign in with your Google account

2. **Create a New Project**
   - Click "Add project" or "Create a project"
   - Enter project name: `lock-in-app` (or your preferred name)
   - Click "Continue"
   
3. **Google Analytics (Optional)**
   - Choose whether to enable Google Analytics (recommended for production)
   - If enabled, select or create an Analytics account
   - Click "Create project"
   - Wait for the project to be created (this takes ~30 seconds)

4. **Project Created**
   - Click "Continue" when setup is complete
   - You'll be redirected to the Firebase Console dashboard

---

### Step 2: Enable Email/Password Authentication

1. **Navigate to Authentication**
   - In the Firebase Console, click on "Authentication" in the left sidebar
   - If prompted, click "Get started"

2. **Enable Email/Password Sign-in**
   - Click on the "Sign-in method" tab at the top
   - Find "Email/Password" in the list of providers
   - Click on "Email/Password"
   - Toggle the first switch to "Enable" (Email/Password)
   - Leave "Email link (passwordless sign-in)" disabled for now
   - Click "Save"

3. **Verification**
   - You should now see "Email/Password" with status "Enabled"

---

### Step 3: Register Your Android App

1. **Add Android App to Firebase**
   - In the Firebase Console, click the ⚙️ (gear icon) next to "Project Overview"
   - Click "Project settings"
   - Scroll down to "Your apps" section
   - Click the Android icon (🤖) to add an Android app

2. **Register App**
   - **Android package name**: Enter your app's package name
     - Find it in: `android/app/build.gradle`
     - Look for `applicationId` (e.g., `com.example.lock_in`)
     - Copy the EXACT package name
   - **App nickname (optional)**: "Lock In Android" (or any name)
   - **Debug signing certificate SHA-1 (optional)**: Leave blank for now
   - Click "Register app"

3. **Finding Your Package Name**
   - Open `android/app/build.gradle`
   - Look for:
     ```gradle
     defaultConfig {
         applicationId "com.example.lock_in"  // This is your package name
         ...
     }
     ```

---

### Step 4: Download and Add google-services.json

1. **Download Configuration File**
   - After registering the app, Firebase will show a download button
   - Click "Download google-services.json"
   - Save the file to your computer

2. **Add to Your Project**
   - Copy `google-services.json`
   - Paste it into: `android/app/` directory
   - **CRITICAL**: The file MUST be in `android/app/`, NOT in `android/` or any other folder

3. **Verify File Location**
   ```
   your_project/
   └── android/
       └── app/
           ├── google-services.json  ← File goes here
           ├── build.gradle
           └── src/
   ```

4. **Click "Next" in Firebase Console**

---

### Step 5: Configure Android Build Files

#### 5.1 Project-level build.gradle

1. **Open** `android/build.gradle`

2. **Add Google Services Plugin**
   - Find the `dependencies` block inside `buildscript`
   - Add the Google Services classpath:

```gradle
buildscript {
    ext.kotlin_version = '1.7.10'
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:7.3.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
        // Add this line ↓
        classpath 'com.google.gms:google-services:4.4.0'
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
```

#### 5.2 App-level build.gradle

1. **Open** `android/app/build.gradle`

2. **Apply Google Services Plugin**
   - Scroll to the **very bottom** of the file
   - Add this line as the **last line**:

```gradle
apply plugin: 'com.android.application'
apply plugin: 'kotlin-android'
apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"

android {
    // ... your existing config
}

dependencies {
    // ... your existing dependencies
}

// Add this line at the very bottom ↓
apply plugin: 'com.google.gms.google-services'
```

3. **Update minSdkVersion (Important!)**
   - Find the `defaultConfig` block
   - Change `minSdkVersion` to at least 21:

```gradle
android {
    compileSdkVersion flutter.compileSdkVersion
    ndkVersion flutter.ndkVersion

    defaultConfig {
        applicationId "com.example.lock_in"
        minSdkVersion 21  // Change this from flutter.minSdkVersion to 21
        targetSdkVersion flutter.targetSdkVersion
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
        multiDexEnabled true  // Add this line
    }
}
```

#### 5.3 Enable Multidex (For API 21+)

If your app has many dependencies, add multidex support:

1. **In** `android/app/build.gradle`:
```gradle
dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
    implementation 'com.android.support:multidex:1.0.3'  // Add this
}
```

---

### Step 6: Install Firebase CLI and FlutterFire

1. **Install Firebase CLI**
   ```bash
   # Using npm (Node.js required)
   npm install -g firebase-tools
   
   # Verify installation
   firebase --version
   ```

2. **Login to Firebase**
   ```bash
   firebase login
   ```
   - This will open a browser window
   - Sign in with the same Google account you used for Firebase Console
   - Allow permissions

3. **Install FlutterFire CLI**
   ```bash
   dart pub global activate flutterfire_cli
   ```

4. **Verify Installation**
   ```bash
   flutterfire --version
   ```

---

### Step 7: Generate firebase_options.dart

1. **Run FlutterFire Configure**
   ```bash
   # Navigate to your project directory
   cd your_project_path
   
   # Run configuration
   flutterfire configure
   ```

2. **Follow the Prompts**
   - Select your Firebase project from the list
   - Select platforms to configure:
     - Use arrow keys to navigate
     - Press `Space` to select Android
     - Press `Enter` to continue
   - Choose your Android application ID (should auto-detect)

3. **Files Generated**
   - `lib/firebase_options.dart` will be created
   - This file contains your Firebase configuration
   - **DO NOT** commit this file to public repositories (add to .gitignore)

4. **Verify File Creation**
   ```
   lib/
   ├── firebase_options.dart  ← New file created
   ├── main.dart
   └── src/
   ```

---

### Step 8: Add Firebase Dependencies

1. **Open** `pubspec.yaml`

2. **Add Dependencies**
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     
     # Firebase Core (Required)
     firebase_core: ^2.24.2
     
     # Firebase Authentication
     firebase_auth: ^4.16.0
     
     # UI
     cupertino_icons: ^1.0.6
   ```

3. **Install Dependencies**
   ```bash
   flutter pub get
   ```

---

## 📦 Installation & Setup

### 1. Clone the Repository
```bash
git clone <your-repository-url>
cd lock_in
```
### 2.Updating cloned Repository
```bash
git pull origin <branch-name>
```

### 3. Install Dependencies
```bash
flutter pub get
```

### 4. Verify Firebase Setup
Check that you have:
- ✅ `google-services.json` in `android/app/`
- ✅ `lib/firebase_options.dart` exists
- ✅ Build.gradle files are configured
- ✅ Email/Password authentication is enabled in Firebase Console

### 5. Run the App
```bash
# Check connected devices
flutter devices

# Run on connected device
flutter run

# Or run in release mode
flutter run --release
```

---

## 🏗️ Project Structure

```
lib/
├── main.dart                           # App entry point & theme configuration
├── firebase_options.dart               # Firebase configuration (auto-generated)
└── src/
    ├── repositories/
    │   └── auth_repository.dart        # Firebase authentication logic
    ├── screens/
    │   ├── auth_screen.dart            # Login & Sign up screen
    │   └── home_screen.dart            # Dashboard with features
    ├── widgets/
    │   ├── password_strength_indicator.dart  # Password strength UI
    │   └── custom_text_field.dart      # Reusable text fields
    └── utils/
        └── validators.dart             # Input validation utilities

android/
├── app/
│   ├── google-services.json           # Firebase Android config
│   └── build.gradle                   # App-level Gradle config
└── build.gradle                       # Project-level Gradle config
```

---

## 🔧 Troubleshooting

### Common Issues and Solutions

#### 1. "google-services.json not found"
**Problem**: Build fails with missing google-services.json

**Solution**:
- Verify file is in `android/app/` (not `android/`)
- Check filename is exactly `google-services.json` (lowercase)
- Re-download from Firebase Console if corrupted

#### 2. "Minimum supported Gradle version is X.X"
**Problem**: Gradle version mismatch

**Solution**:
```bash
# Update Gradle wrapper
cd android
./gradlew wrapper --gradle-version=8.7
```

#### 3. "Execution failed for task ':app:processDebugGoogleServices'"
**Problem**: Package name mismatch

**Solution**:
- Open `google-services.json`
- Find `"package_name"` field
- Ensure it matches `applicationId` in `android/app/build.gradle`
- If different, download new google-services.json with correct package name

#### 4. "FirebaseException: An internal error has occurred"
**Problem**: Firebase not initialized

**Solution**:
- Ensure `Firebase.initializeApp()` is called in `main()`
- Check `firebase_options.dart` exists
- Verify internet connection

#### 5. "PlatformException: sign_in_failed"
**Problem**: Email/Password authentication not enabled

**Solution**:
- Go to Firebase Console → Authentication → Sign-in method
- Enable Email/Password provider
- Click Save

#### 6. Build fails with "Multidex" error
**Problem**: Too many methods (over 64K)

**Solution**:
Add to `android/app/build.gradle`:
```gradle
defaultConfig {
    ...
    multiDexEnabled true
}

dependencies {
    implementation 'com.android.support:multidex:1.0.3'
}
```

#### 7. "Unable to find a matching configuration"
**Problem**: Android SDK or build tools issue

**Solution**:
```bash
flutter clean
flutter pub get
cd android
./gradlew clean
cd ..
flutter run
```

---

## 🧪 Testing the App

### 1. Test Sign Up
- Launch the app
- Tap "Sign Up"
- Enter a valid email: `test@example.com`
- Create a strong password meeting all requirements
- Confirm password
- Tap "Sign Up"
- Check Firebase Console → Authentication → Users for new user

### 2. Test Sign In
- Tap "Sign In"
- Enter the email and password you just created
- Tap "Sign In"
- Verify navigation to Home Screen

### 3. Test Validation
- Try signing up with:
  - Invalid email (no @)
  - Weak password (less than 8 characters)
  - Mismatched passwords
- Verify error messages appear

### 4. Test Logout
- Tap logout icon in Home Screen
- Confirm logout dialog
- Verify return to Auth Screen

---

## 🔐 Security Best Practices

### What's Already Implemented
✅ Strong password requirements with validation
✅ Email format validation
✅ Firebase secure authentication
✅ Password visibility toggle
✅ Input sanitization (trim)
✅ Proper error handling
✅ Session management via Firebase

### Additional Recommendations
- **Never commit** `google-services.json` to public repositories
- Add `google-services.json` to `.gitignore`
- Add `firebase_options.dart` to `.gitignore`
- Use environment variables for sensitive data in production
- Enable email verification in production apps
- Implement password reset functionality
- Add rate limiting for authentication attempts
- Enable two-factor authentication for admin accounts

### .gitignore Additions
```
# Firebase
google-services.json
firebase_options.dart
GoogleService-Info.plist
```

---

## 📱 Firebase Console - Managing Users

### View Registered Users
1. Go to Firebase Console
2. Select your project
3. Click "Authentication" → "Users" tab
4. See all registered users, their emails, and UIDs

### Delete Users
1. In Users tab, click on a user
2. Click the menu (⋮) icon
3. Select "Delete account"

### Disable Users
1. In Users tab, click on a user
2. Click "Disable account"
3. User won't be able to sign in

---

## 🚀 Next Steps & Future Enhancements

### Planned Features
- [ ] Password reset via email
- [ ] Email verification flow
- [ ] Google Sign-In integration
- [ ] Apple Sign-In integration
- [ ] Biometric authentication (fingerprint/face)
- [ ] Dark mode support
- [ ] Multi-language support (i18n)
- [ ] Profile picture upload
- [ ] Two-factor authentication (2FA)
- [ ] Social media authentication (Facebook, Twitter)

### How to Add Password Reset

1. **Add method to AuthRepository**:
```dart
Future<void> resetPassword(String email) async {
  await _firebaseAuth.sendPasswordResetEmail(email: email);
}
```

2. **Add UI button** in AuthScreen:
```dart
TextButton(
  onPressed: () async {
    // Show dialog to get email
    // Call authRepository.resetPassword(email)
  },
  child: Text('Forgot Password?'),
)
```

---

## 📚 Additional Resources

### Documentation
- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase Documentation](https://firebase.google.com/docs)
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Authentication](https://firebase.google.com/docs/auth)

### Tutorials
- [Firebase Auth with Flutter](https://firebase.google.com/codelabs/firebase-auth-in-flutter-apps)
- [Material Design 3](https://m3.material.io/)

### Community
- [Flutter Community](https://flutter.dev/community)
- [FlutterFire GitHub](https://github.com/firebase/flutterfire)
- [Stack Overflow - Flutter](https://stackoverflow.com/questions/tagged/flutter)

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🆘 Support

If you encounter any issues:

1. **Check this README** - Most common issues are covered in Troubleshooting
2. **Firebase Console** - Check authentication is enabled
3. **Flutter Doctor** - Run `flutter doctor -v` to check setup
4. **Clean Build** - Try `flutter clean && flutter pub get`
5. **GitHub Issues** - Search existing issues or create a new one
6. **Stack Overflow** - Tag questions with `flutter` and `firebase`

---

## 👨‍💻 Author

**Your Name**
- GitHub: [Denis-7242](https://github.com/Denis-7242)
- Email: dexdenis3@gmail.com



---

**Built with ❤️ by Denis using Flutter and Firebase**

