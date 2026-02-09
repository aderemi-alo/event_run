# Authentication Feature Implementation Guide

## Overview

The authentication feature handles user onboarding, login, signup, and session management using clean architecture with Riverpod for state management.

## Architecture Layers

### Domain Layer (`lib/features/auth/domain/`)

**Entities:**
- `vendor.dart`: Core Vendor entity with user properties

**Repositories (Interfaces):**
- `auth_repository.dart`: Abstract contract for auth operations

**Use Cases:**
- `login_usecase.dart`: Handle login logic
- `signup_usecase.dart`: Handle signup logic
- `logout_usecase.dart`: Handle logout logic
- `check_auth_status_usecase.dart`: Check if user is authenticated

### Data Layer (`lib/features/auth/data/`)

**Models:**
- `vendor_model.dart`: Vendor model with JSON serialization (extends Vendor entity)

**Data Sources:**
- `auth_local_datasource.dart`: Local storage operations using SharedPreferences

**Repositories (Implementation):**
- `auth_repository_impl.dart`: Implements AuthRepository interface

### Presentation Layer (`lib/features/auth/presentation/`)

**Providers:**
- `auth_provider.dart`: Riverpod providers for auth state management
- `onboarding_provider.dart`: Provider for onboarding step state

**UI - Views:**
- `onboarding_view.dart`: 3-step carousel introducing the app
- `login_view.dart`: Email/password login form
- `signup_view.dart`: Business registration form

**UI - Widgets:**
- `onboarding_step.dart`: Individual onboarding step widget
- `auth_form_field.dart`: Reusable form field with validation

---

## Implementation Details

### 1. Onboarding Flow

**3-Step Carousel:**
1. **Prevent Double Bookings** (Red theme)
   - Icon: CalendarX
   - Message: Inventory availability tracking
   
2. **Professional Invoices** (Blue theme)
   - Icon: FileText
   - Message: Quick invoice generation
   
3. **Run Your Business** (Teal theme)
   - Icon: LayoutDashboard
   - Message: Manage from mobile

**Features:**
- Swipeable carousel or next button
- Skip button to jump to signup
- Dot indicators for progress
- Marks onboarding as complete when finished

### 2. Login Screen

**Components:**
- Email text field with validation
- Password text field with obscure toggle
- Remember me checkbox (optional)
- Login button
- "Don't have an account? Sign up" link
- Forgot password link (future)

**Validation:**
- Email format using `Validators.validateEmail`
- Password minimum length using `Validators.validatePassword`

**Flow:**
1. User enters credentials
2. Form validates
3. Call `login_usecase`
4. On success, save to local storage and navigate to dashboard
5. On error, show error message

### 3. Signup Screen

**Components:**
- Business name field
- Full name field
- Email field
- Phone field (Nigerian format)
- Password field
- Confirm password field
- Terms & conditions checkbox
- Signup button
- "Already have an account? Login" link

**Validation:**
- All fields required
- Email format
- Phone format (+234 or 0)
- Password match
- Terms accepted

**Flow:**
1. User fills form
2. Validates all fields
3. Call `signup_usecase`
4. Mark onboarding complete
5. Navigate to dashboard

### 4. State Management with Riverpod

**AuthState:**
```dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(Vendor user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(String message) = _Error;
}
```

**Providers:**
- `authRepositoryProvider`: Singleton for AuthRepository
- `authStateProvider`: StateNotifier for auth state
- `currentUserProvider`: Provider for current user
- `isAuthenticatedProvider`: Boolean provider
- `hasCompletedOnboardingProvider`: Boolean provider

### 5. Navigation Flow

```
App Launch
  ↓
Check Authentication
  ↓
├─ Not Authenticated
│  ├─ Check Onboarding
│  │  ├─ Not Complete → Onboarding Screen
│  │  └─ Complete → Login Screen
│  └─ Signup Option
└─ Authenticated → Dashboard
```

**Route Guards:**
- Public routes: `/onboarding`, `/login`, `/signup`
- Protected routes: All others (redirect to login if not authenticated)
- Redirect logic: If authenticated and trying to access auth screens → Dashboard

---

## File Structure

```
lib/features/auth/
├── domain/
│   ├── entities/
│   │   └── vendor.dart ✅
│   ├── repositories/
│   │   └── auth_repository.dart ✅
│   └── usecases/
│       ├── login_usecase.dart
│       ├── signup_usecase.dart
│       ├── logout_usecase.dart
│       └── check_auth_status_usecase.dart
├── data/
│   ├── models/
│   │   ├── vendor_model.dart ✅
│   │   └── vendor_model.g.dart (generated) ✅
│   ├── datasources/
│   │   └── auth_local_datasource.dart ✅
│   └── repositories/
│       └── auth_repository_impl.dart ✅
└── presentation/
    ├── providers/
    │   ├── auth_provider.dart
    │   └── auth_state.dart
    └── ui/
        ├── views/
        │   ├── onboarding_view.dart
        │   ├── login_view.dart
        │   └── signup_view.dart
        └── widgets/
            ├── onboarding_step.dart
            └── auth_text_field.dart
```

---

## Testing Approach

### Unit Tests
- Test each use case with mock repository
- Test repository implementation with mock data source
- Test validators in isolation

### Widget Tests
- Test onboarding carousel navigation
- Test login form validation
- Test signup form validation
- Test error state display

### Integration Tests
- Full auth flow: onboarding → signup → dashboard
- Session persistence after app restart
- Logout and login again

---

## Next Steps

1. ✅ Domain entities
2. ✅ Repository interface
3. ✅ Data source
4. ✅ Model with JSON serialization
5. ✅ Repository implementation
6. 🚧 Use cases
7. 🚧 Riverpod providers
8. 🚧 Onboarding UI
9. 🚧 Login UI
10. 🚧 Signup UI
11. ⏳ Router integration
12. ⏳ Testing
