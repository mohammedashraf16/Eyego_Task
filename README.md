# EyeGo Task - Flutter Product Management App

A feature-rich Flutter application that demonstrates clean architecture, state management, and Firebase integration. The app provides user authentication and a dynamic product browsing experience with advanced filtering and search capabilities.

## 📱 Demo Video

[Insert your recorded demo video link here]

---

## 📸 Screenshots

### Authentication Screens
<div align="center">
<img width="200"  alt="Image" src="https://github.com/user-attachments/assets/24f70448-243c-42a5-9c11-023d9b03c995" />
<img width="200"  alt="Image" src="https://github.com/user-attachments/assets/9d1e847d-1d3d-4741-b19d-daf4360e4e52" />
<img width="200"  alt="Image" src="https://github.com/user-attachments/assets/532fc421-3b57-4104-b73c-436f351e6044" />
</div>

### Product Screens
<div align="center">
  <img width="200"  alt="Image" src="https://github.com/user-attachments/assets/40623416-a913-42de-ad32-bdbe3c406cd6" />
  <img width="200"  alt="Image" src="https://github.com/user-attachments/assets/08ee6ec6-3f0d-43e5-94a9-ac3ada580d89" />
</div>

### Filter & Features
<div align="center">
<img width="200" alt="Image" src="https://github.com/user-attachments/assets/8cbfb151-167d-493a-ae95-2206f67726b4" />
</div>

---

### Authentication
- ✅ Email/Password authentication via Firebase
- ✅ Google Sign-In integration
- ✅ Facebook Sign-In integration
- ✅ Persistent authentication state
- ✅ User data storage in Firestore
- ✅ Secure logout functionality

### Product Management
- ✅ Display products from DummyJSON API
- ✅ Real-time product search
- ✅ Advanced filtering by:
  - Category
  - Price range (min/max)
  - Minimum rating
  - Sort options (price, rating, name)
- ✅ Offline caching with local storage
- ✅ Skeleton loading states
- ✅ Pull-to-refresh functionality
- ✅ Beautiful UI with cached network images

---

## 🏗️ Architecture & Implementation

### Clean Architecture Pattern

The project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                      # Core utilities and shared components
│   ├── connection/           # Network connectivity checking
│   ├── database/             # API and cache management
│   ├── errors/               # Error handling and exceptions
│   ├── functions/            # Reusable utility functions
│   ├── services/             # Service locator and Firebase services
│   └── widgets/              # Shared UI components
│
├── features/                  # Feature modules
│   ├── auth/                 # Authentication feature
│   │   ├── data/            # Data layer (models, repos)
│   │   ├── domain/          # Domain layer (entities, repos)
│   │   └── presentation/    # Presentation layer (UI, Cubits)
│   │
│   └── products/             # Products feature
│       ├── data/            # Data layer
│       ├── domain/          # Domain layer
│       └── presentation/    # Presentation layer
│
└── config/                   # App configuration (routes, themes)
```

### Key Implementation Details

#### 1. **State Management - BLoC/Cubit**
- Uses `flutter_bloc` for predictable state management
- Separate Cubits for authentication and product management
- Clean separation between business logic and UI

```dart
// Example: ProductCubit manages all product-related states
class ProductCubit extends Cubit {
  - getAllProducts()
  - searchProducts(query)
  - applyFilter(filter)
  - clearFilter()
}
```

#### 2. **Dependency Injection**
- Implements `get_it` for service locator pattern
- All dependencies registered in `get_it_service.dart`
- Promotes loose coupling and testability

#### 3. **Error Handling**
- Comprehensive exception handling with custom exceptions
- Network-aware error messages
- User-friendly error dialogs

#### 4. **Offline-First Architecture**
```dart
// Data flow:
1. Check network connectivity
2. If online: Fetch from API → Cache locally
3. If offline: Serve from cache
4. Handle cache exceptions gracefully
```

#### 5. **Firebase Integration**
- Firebase Auth for authentication
- Cloud Firestore for user data persistence
- Secure credential storage with shared preferences

#### 6. **API Integration**
- RESTful API calls using Dio
- API interceptors for token management
- Proper request/response handling

---

## 📋 Prerequisites

Before running this project, ensure you have:

- Flutter SDK (3.10.1 or higher)
- Dart SDK (3.10.1 or higher)
- Android Studio / VS Code with Flutter extensions
- Firebase account
- Android SDK for Android development
- Xcode for iOS development (macOS only)

---

## 🔧 Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/eyego_task.git
cd eyego_task
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Firebase Setup

#### a. Create a Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or use an existing one
3. Add Android and/or iOS app to your Firebase project

#### b. Configure Firebase for Android
1. Download `google-services.json` from Firebase Console
2. Place it in `android/app/` directory

#### c. Configure Firebase for iOS
1. Download `GoogleService-Info.plist` from Firebase Console
2. Place it in `ios/Runner/` directory

#### d. Enable Authentication Methods
In Firebase Console:
- Go to Authentication → Sign-in method
- Enable Email/Password
- Enable Google Sign-In
- Enable Facebook Sign-In (requires Facebook App setup)

#### e. Setup Firestore Database
- Go to Firestore Database
- Create database in production or test mode
- The app will automatically create the `users` collection

### 4. Configure Facebook Login (Optional)

If you want to use Facebook authentication:

1. Create a Facebook App at [developers.facebook.com](https://developers.facebook.com)
2. Add Facebook App ID to your project:
   - Android: `android/app/src/main/res/values/strings.xml`
   - iOS: `ios/Runner/Info.plist`
3. Configure OAuth redirect in Firebase Console

### 5. Run the App

```bash
# Run on connected device/emulator
flutter run

# Run on specific device
flutter devices  # List available devices
flutter run -d 

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release
```

---

## 📦 Dependencies

### Core Dependencies
```yaml
flutter_bloc: ^9.1.1              # State management
dio: ^5.9.0                       # HTTP client
get_it: ^9.2.0                    # Dependency injection
dartz: ^0.10.1                    # Functional programming
shared_preferences: ^2.5.4        # Local storage
```

### Firebase
```yaml
firebase_core: ^4.3.0
firebase_auth: ^6.1.3
cloud_firestore: ^6.1.1
google_sign_in: ^6.2.1
flutter_facebook_auth: ^7.1.2
```

### UI & UX
```yaml
flutter_screenutil: ^5.9.3        # Responsive design
cached_network_image: ^3.4.1      # Image caching
skeletonizer: ^2.1.2              # Loading skeletons
awesome_dialog: ^3.3.0            # Beautiful dialogs
fluttertoast: ^9.0.0              # Toast messages
modal_progress_hud_nsn: ^0.5.1    # Loading indicators
```

---

## 🎯 Usage Guide

### Login/Registration
1. Launch the app
2. Create a new account or login with existing credentials
3. Or use Google/Facebook sign-in buttons

### Browse Products
1. After login, you'll see the products list
2. Use the search icon to search for specific products
3. Use the filter icon to apply advanced filters
4. Pull down to refresh the product list

### Filtering Products
1. Tap the filter icon in the app bar
2. Select category, price range, rating, or sort option
3. Tap "Apply Filters"
4. Clear filters anytime with "Clear All"

### Logout
- Tap the floating logout button in the bottom-right corner

---

## 🏃 Implementation Approach

### 1. Project Setup
- Initialized Flutter project with clean architecture structure
- Configured Firebase for authentication
- Set up dependency injection with GetIt

### 2. Authentication Flow
- Implemented Firebase Authentication with email/password
- Added social login providers (Google, Facebook)
- Created AuthWrapper to handle initial authentication state
- Implemented persistent login with shared preferences

### 3. Products Feature
- Integrated DummyJSON API for product data
- Implemented offline-first caching strategy
- Created ProductCubit for state management
- Built responsive UI with flutter_screenutil

### 4. Advanced Features
- Implemented search functionality with debouncing
- Created comprehensive filtering system
- Added skeleton loading for better UX
- Implemented pull-to-refresh

### 5. Error Handling
- Created custom exception classes
- Implemented network connectivity checking
- Added user-friendly error dialogs
- Handled edge cases (offline mode, no data)

### 6. UI/UX Polish
- Responsive design for multiple screen sizes
- Smooth transitions and animations
- Loading states and skeleton screens
- Toast notifications for user feedback

---

## 🔑 Key Technical Decisions

### Why Clean Architecture?
- **Testability**: Easy to unit test business logic
- **Maintainability**: Clear separation of concerns
- **Scalability**: Easy to add new features
- **Independence**: UI, database, and business logic are independent

### Why BLoC/Cubit?
- **Predictable state management**: Easy to debug
- **Separation of concerns**: UI and business logic separated
- **Testable**: Business logic can be tested independently
- **Reactive**: Responds to state changes automatically

### Why Offline-First?
- **Better UX**: App works without internet
- **Performance**: Faster loading from cache
- **Reliability**: Handles network failures gracefully

---

## 🐛 Troubleshooting

### Common Issues

**Issue: Firebase not initialized**
```bash
Solution: Make sure google-services.json (Android) or GoogleService-Info.plist (iOS) 
is in the correct location
```

**Issue: Build fails on iOS**
```bash
Solution: Run these commands:
cd ios
pod install
cd ..
flutter clean
flutter run
```

**Issue: No products showing**
```bash
Solution: Check internet connectivity. If offline, products should load from cache.
```

---

## 📝 Project Structure Explained

```
- core/
  - connection/      → Network connectivity handling
  - database/        → API consumer and cache helper
  - errors/          → Custom exceptions and error models
  - services/        → Firebase and dependency injection
  - widgets/         → Reusable UI components

- features/auth/
  - data/            → UserModel, AuthRepoImpl
  - domain/          → UserEntity, AuthRepo interface
  - presentation/    → Login/Register screens, Cubits

- features/products/
  - data/            → ProductModel, API/Cache data sources
  - domain/          → Use cases, Repository interface
  - presentation/    → Home screen, Product widgets, ProductCubit

- config/
  - router/          → Route generation and navigation
```

---

## 👨‍💻 Developer

**Your Name**
- GitHub: [@mohammedashraf16](https://github.com/mohammedashraf16)
- Email: mohammedashraf1692003@gmail.com

---

## 🙏 Acknowledgments

- DummyJSON API for test data
- Firebase for authentication and database
- Flutter community for amazing packages
