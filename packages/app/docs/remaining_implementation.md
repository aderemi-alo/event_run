# EventRun Flutter - Remaining Features Implementation Guide

## Overview

This document provides a comprehensive guide for implementing the remaining 6 features of the EventRun Flutter application. Each feature follows the same clean architecture pattern established in the authentication feature.

---

## Table of Contents

1. [Dashboard Feature](#1-dashboard-feature)
2. [Events Feature](#2-events-feature)
3. [Clients Feature](#3-clients-feature)
4. [Inventory Feature](#4-inventory-feature)
5. [Invoices Feature](#5-invoices-feature)
6. [Profile Feature](#6-profile-feature)
7. [Navigation Enhancement](#7-navigation-enhancement)
8. [Testing Strategy](#8-testing-strategy)
9. [Backend Integration](#9-backend-integration)

---

## Implementation Pattern

Each feature follows this structure:

```
feature_name/
├── domain/
│   ├── entities/          # Already created ✅
│   ├── repositories/      # Interface to implement
│   └── usecases/         # Business logic
├── data/
│   ├── models/           # JSON serializable models
│   ├── datasources/      # Local/remote data sources
│   └── repositories/     # Repository implementations
└── presentation/
    ├── providers/        # Riverpod providers
    └── ui/
        ├── views/        # Screen widgets
        └── widgets/      # Reusable components
```

**Implementation Steps for Each Feature:**
1. Create repository interface
2. Create use cases
3. Create models with `@JsonSerializable`
4. Create data sources (local storage)
5. Implement repository
6. Create Riverpod providers
7. Build UI screens
8. Add routes to router
9. Test

---

## 1. Dashboard Feature

**Priority:** High (Main landing page)

### Domain Layer

**Repository Interface:**
```dart
// lib/features/dashboard/domain/repositories/dashboard_repository.dart

abstract class DashboardRepository {
  Future<Map<String, dynamic>> getDashboardStats();
  Future<List<Event>> getUpcomingEvents();
  Future<List<ActivityLog>> getRecentActivities();
  Future<List<Map<String, dynamic>>> getRevenueData();
}
```

**Use Cases:**
- `get_dashboard_stats_usecase.dart` - Get revenue, event count, attention count
- `get_upcoming_events_usecase.dart` - Get next 3-5 events
- `get_recent_activities_usecase.dart` - Get last 5-10 activities
- `get_revenue_data_usecase.dart` - Get chart data for last 6 months

### Data Layer

**Models:**
```dart
// lib/features/dashboard/data/models/dashboard_stats_model.dart

@JsonSerializable()
class DashboardStatsModel {
  final double totalRevenue;
  final int totalEvents;
  final int attentionEvents;
  
  // Methods: fromJson, toJson
}

// lib/features/dashboard/data/models/revenue_data_model.dart

@JsonSerializable()
class RevenueDataModel {
  final String month;
  final double amount;
  
  // Methods: fromJson, toJson
}
```

**Data Source:**
```dart
// lib/features/dashboard/data/datasources/dashboard_local_datasource.dart

class DashboardLocalDataSource {
  // Use MockData for now
  // Calculate stats from mock events
  // Filter and sort data
}
```

**Repository Implementation:**
```dart
// lib/features/dashboard/data/repositories/dashboard_repository_impl.dart

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardLocalDataSource _dataSource;
  
  // Implement all methods
}
```

### Presentation Layer

**Providers:**
```dart
// lib/features/dashboard/presentation/providers/dashboard_provider.dart

// Data source provider
final dashboardLocalDataSourceProvider = Provider<DashboardLocalDataSource>(...);

// Repository provider
final dashboardRepositoryProvider = Provider<DashboardRepository>(...);

// Use case providers
final getDashboardStatsUseCaseProvider = Provider<GetDashboardStatsUseCase>(...);
final getUpcomingEventsUseCaseProvider = Provider<GetUpcomingEventsUseCase>(...);
final getRecentActivitiesUseCaseProvider = Provider<GetRecentActivitiesUseCase>(...);
final getRevenueDataUseCaseProvider = Provider<GetRevenueDataUseCase>(...);

// State provider
class DashboardState {
  final DashboardStatsModel? stats;
  final List<Event> upcomingEvents;
  final List<ActivityLog> recentActivities;
  final List<RevenueDataModel> revenueData;
  final bool isLoading;
  final String? error;
}

final dashboardStateProvider = StateNotifierProvider<DashboardNotifier, DashboardState>(...);
```

**UI Components:**

1. **Dashboard View** (`lib/features/dashboard/presentation/ui/views/dashboard_view.dart`)
   - AppBar with greeting and profile icon
   - Stats cards row (Revenue, Events, Attention)
   - Revenue chart section
   - Upcoming events list
   - Recent activity feed
   - Quick action buttons (floating or in bottom section)

2. **Widgets:**
   - `stat_card.dart` - Reusable stat display card
   - `revenue_chart.dart` - Line chart using fl_chart
   - `event_card.dart` - Compact event display
   - `activity_item.dart` - Activity timeline item
   - `quick_action_button.dart` - Action button

**Responsive Layout:**
- **Mobile:** Single column, stacked vertically
- **Tablet:** 2-column grid for stats, single column for rest
- **Desktop:** 3-column layout with sidebar

### Routes

```dart
// In app_router.dart, replace placeholder dashboard route:

GoRoute(
  path: '/',
  builder: (context, state) => const DashboardView(),
),
```

---

## 2. Events Feature

**Priority:** High (Core functionality)

### Domain Layer

**Repository Interface:**
```dart
// lib/features/events/domain/repositories/events_repository.dart

abstract class EventsRepository {
  Future<List<Event>> getAllEvents();
  Future<List<Event>> getEventsByStatus(EventStatus status);
  Future<List<Event>> searchEvents(String query);
  Future<Event> getEventById(String id);
  Future<Event> createEvent(Event event);
  Future<Event> updateEvent(Event event);
  Future<void> deleteEvent(String id);
}
```

**Use Cases:**
- `get_all_events_usecase.dart`
- `get_events_by_status_usecase.dart`
- `search_events_usecase.dart`
- `get_event_by_id_usecase.dart`
- `create_event_usecase.dart`
- `update_event_usecase.dart`
- `delete_event_usecase.dart`

### Data Layer

**Models:**
```dart
// lib/features/events/data/models/event_model.dart

@JsonSerializable(fieldRename: FieldRename.snake)
class EventModel extends Event {
  // Constructor
  // fromJson, toJson
  // fromEntity
}
```

**Data Source:**
```dart
// lib/features/events/data/datasources/events_local_datasource.dart

class EventsLocalDataSource {
  final SharedPreferences _prefs;
  
  // CRUD operations
  // Save/load from SharedPreferences as JSON
  // Use MockData as initial data
}
```

**Repository Implementation:**
```dart
// lib/features/events/data/repositories/events_repository_impl.dart

class EventsRepositoryImpl implements EventsRepository {
  final EventsLocalDataSource _dataSource;
  
  // Implement all methods
  // Add filtering and sorting logic
}
```

### Presentation Layer

**Providers:**
```dart
// lib/features/events/presentation/providers/events_provider.dart

// State with list of events, filters, search query
class EventsState {
  final List<Event> events;
  final EventStatus? statusFilter;
  final String searchQuery;
  final bool isLoading;
  final String? error;
}

final eventsStateProvider = StateNotifierProvider<EventsNotifier, EventsState>(...);

// Selected event provider
final selectedEventProvider = StateProvider<Event?>(...);
```

**UI Components:**

1. **Events View** (`lib/features/events/presentation/ui/views/events_view.dart`)
   - Search bar
   - Filter chips (All, Upcoming, Past, Covered, Attention, Conflict)
   - Events list/grid
   - Floating action button (Create Event)

2. **Event Detail View** (`lib/features/events/presentation/ui/views/event_detail_view.dart`)
   - Event information display
   - Edit and delete buttons
   - Client information
   - Inventory assigned
   - Revenue/cost breakdown

3. **Create/Edit Event View** (`lib/features/events/presentation/ui/views/event_form_view.dart`)
   - Event name field
   - Client selection dropdown
   - Date picker
   - Location field
   - Revenue field
   - Notes field
   - Save button

4. **Widgets:**
   - `event_list_item.dart` - Event card in list
   - `event_filter_chips.dart` - Filter buttons
   - `event_search_bar.dart` - Search input

**Routes:**
```dart
GoRoute(
  path: '/events',
  builder: (context, state) => const EventsView(),
  routes: [
    GoRoute(
      path: 'create',
      builder: (context, state) => const EventFormView(mode: FormMode.create),
    ),
    GoRoute(
      path: ':id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return EventDetailView(eventId: id);
      },
      routes: [
        GoRoute(
          path: 'edit',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return EventFormView(mode: FormMode.edit, eventId: id);
          },
        ),
      ],
    ),
  ],
),
```

---

## 3. Clients Feature

**Priority:** Medium

### Domain Layer

**Repository Interface:**
```dart
// lib/features/clients/domain/repositories/clients_repository.dart

abstract class ClientsRepository {
  Future<List<Client>> getAllClients();
  Future<List<Client>> searchClients(String query);
  Future<Client> getClientById(String id);
  Future<Client> createClient(Client client);
  Future<Client> updateClient(Client client);
  Future<void> deleteClient(String id);
  Future<List<Event>> getClientEvents(String clientId);
}
```

**Use Cases:**
- `get_all_clients_usecase.dart`
- `search_clients_usecase.dart`
- `get_client_by_id_usecase.dart`
- `create_client_usecase.dart`
- `update_client_usecase.dart`
- `delete_client_usecase.dart`
- `get_client_events_usecase.dart`

### Data Layer

**Models:**
```dart
// lib/features/clients/data/models/client_model.dart

@JsonSerializable(fieldRename: FieldRename.snake)
class ClientModel extends Client {
  // fromJson, toJson, fromEntity
}
```

**Data Source & Repository:**
Similar pattern to Events feature.

### Presentation Layer

**UI Components:**

1. **Clients View** (`lib/features/clients/presentation/ui/views/clients_view.dart`)
   - Search bar
   - Clients list
   - FAB for adding client

2. **Client Detail View** (`lib/features/clients/presentation/ui/views/client_detail_view.dart`)
   - Client info
   - Event history
   - Edit/delete buttons

3. **Client Form View** (`lib/features/clients/presentation/ui/views/client_form_view.dart`)
   - Name, phone, email, last event fields
   - Save button

**Routes:**
```dart
GoRoute(
  path: '/clients',
  builder: (context, state) => const ClientsView(),
  routes: [
    GoRoute(path: 'create', ...),
    GoRoute(path: ':id', ...),
    GoRoute(path: ':id/edit', ...),
  ],
),
```

---

## 4. Inventory Feature

**Priority:** Medium

### Domain Layer

**Repository Interface:**
```dart
// lib/features/inventory/domain/repositories/inventory_repository.dart

abstract class InventoryRepository {
  Future<List<InventoryItem>> getAllItems();
  Future<List<InventoryItem>> getItemsByCategory(String category);
  Future<List<InventoryItem>> searchItems(String query);
  Future<InventoryItem> getItemById(String id);
  Future<InventoryItem> createItem(InventoryItem item);
  Future<InventoryItem> updateItem(InventoryItem item);
  Future<void> deleteItem(String id);
  Future<void> updateQuantity(String id, int newQuantity);
}
```

**Use Cases:**
- `get_all_items_usecase.dart`
- `get_items_by_category_usecase.dart`
- `search_items_usecase.dart`
- `get_item_by_id_usecase.dart`
- `create_item_usecase.dart`
- `update_item_usecase.dart`
- `delete_item_usecase.dart`
- `update_quantity_usecase.dart`

### Data Layer

**Models:**
```dart
// lib/features/inventory/data/models/inventory_item_model.dart

@JsonSerializable(fieldRename: FieldRename.snake)
class InventoryItemModel extends InventoryItem {
  // fromJson, toJson, fromEntity
}
```

### Presentation Layer

**UI Components:**

1. **Inventory View** (`lib/features/inventory/presentation/ui/views/inventory_view.dart`)
   - Search bar
   - Category filter chips (Furniture, Decor, Catering, Audio/Visual, Lighting, Misc)
   - Inventory grid/list
   - FAB for adding item

2. **Inventory Item Detail** (`lib/features/inventory/presentation/ui/views/inventory_detail_view.dart`)
   - Item details
   - Quantity adjustment buttons
   - Edit/delete

3. **Inventory Form View** (`lib/features/inventory/presentation/ui/views/inventory_form_view.dart`)
   - Name, category, quantity fields
   - Optional: notes, image
   - Save button

**Routes:**
```dart
GoRoute(
  path: '/inventory',
  builder: (context, state) => const InventoryView(),
  routes: [...],
),
```

---

## 5. Invoices Feature

**Priority:** Medium

### Domain Layer

**Repository Interface:**
```dart
// lib/features/invoices/domain/repositories/invoices_repository.dart

abstract class InvoicesRepository {
  Future<List<Invoice>> getAllInvoices();
  Future<List<Invoice>> getInvoicesByStatus(InvoiceStatus status);
  Future<List<Invoice>> searchInvoices(String query);
  Future<Invoice> getInvoiceById(String id);
  Future<Invoice> createInvoice(Invoice invoice);
  Future<Invoice> updateInvoice(Invoice invoice);
  Future<void> deleteInvoice(String id);
  Future<Invoice> updateInvoiceStatus(String id, InvoiceStatus status);
}
```

**Use Cases:**
- `get_all_invoices_usecase.dart`
- `get_invoices_by_status_usecase.dart`
- `search_invoices_usecase.dart`
- `get_invoice_by_id_usecase.dart`
- `create_invoice_usecase.dart`
- `update_invoice_usecase.dart`
- `delete_invoice_usecase.dart`
- `update_invoice_status_usecase.dart`

### Data Layer

**Models:**
```dart
// lib/features/invoices/data/models/invoice_model.dart
// lib/features/invoices/data/models/invoice_item_model.dart

@JsonSerializable(fieldRename: FieldRename.snake)
class InvoiceModel extends Invoice {
  // fromJson, toJson, fromEntity
}

@JsonSerializable(fieldRename: FieldRename.snake)
class InvoiceItemModel extends InvoiceItem {
  // fromJson, toJson, fromEntity
}
```

### Presentation Layer

**UI Components:**

1. **Invoices View** (`lib/features/invoices/presentation/ui/views/invoices_view.dart`)
   - Search bar
   - Status filter chips (All, Draft, Sent, Paid, Overdue)
   - Invoices list
   - FAB for creating invoice

2. **Invoice Detail View** (`lib/features/invoices/presentation/ui/views/invoice_detail_view.dart`)
   - Invoice header (number, date, client)
   - Line items list
   - Total amount
   - Status badge
   - Actions: Edit, Mark as Sent/Paid, Delete

3. **Invoice Form View** (`lib/features/invoices/presentation/ui/views/invoice_form_view.dart`)
   - Client selection
   - Date picker
   - Line items (dynamic list)
     - Description, quantity, unit price
     - Add/remove items
   - Calculated total
   - Notes field
   - Save as draft / Send invoice buttons

**Routes:**
```dart
GoRoute(
  path: '/invoices',
  builder: (context, state) => const InvoicesView(),
  routes: [...],
),
```

---

## 6. Profile Feature

**Priority:** Low (Can use mock data initially)

### Domain Layer

**Repository Interface:**
```dart
// lib/features/profile/domain/repositories/profile_repository.dart

abstract class ProfileRepository {
  Future<Vendor> getProfile();
  Future<Vendor> updateProfile(Vendor vendor);
  Future<void> changePassword(String oldPassword, String newPassword);
}
```

**Use Cases:**
- `get_profile_usecase.dart`
- `update_profile_usecase.dart`
- `change_password_usecase.dart`

### Presentation Layer

**UI Components:**

1. **Profile View** (`lib/features/profile/presentation/ui/views/profile_view.dart`)
   - Profile header (business name, full name)
   - Contact information
   - Edit profile button
   - Settings section
   - Logout button

2. **Edit Profile View** (`lib/features/profile/presentation/ui/views/edit_profile_view.dart`)
   - Editable form for vendor data
   - Save button

3. **Settings View** (Optional)
   - Theme selection (Light/Dark)
   - Notifications preferences
   - About app

**Routes:**
```dart
GoRoute(
  path: '/profile',
  builder: (context, state) => const ProfileView(),
  routes: [
    GoRoute(path: 'edit', ...),
    GoRoute(path: 'settings', ...),
  ],
),
```

---

## 7. Navigation Enhancement

### Mobile Navigation

**Bottom Navigation Bar:**
```dart
// lib/core/navigation/bottom_nav_bar.dart

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Clients',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inventory_2),
          label: 'Inventory',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long),
          label: 'Invoices',
        ),
      ],
    );
  }
}
```

### Desktop Navigation

**Sidebar:**
```dart
// lib/core/navigation/app_sidebar.dart

class AppSidebar extends StatelessWidget {
  final String currentRoute;
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header with business name
          DrawerHeader(...),
          
          // Navigation items
          NavItem(icon: Icons.dashboard, label: 'Dashboard', route: '/'),
          NavItem(icon: Icons.event, label: 'Events', route: '/events'),
          NavItem(icon: Icons.people, label: 'Clients', route: '/clients'),
          NavItem(icon: Icons.inventory_2, label: 'Inventory', route: '/inventory'),
          NavItem(icon: Icons.receipt_long, label: 'Invoices', route: '/invoices'),
          
          Spacer(),
          
          // Profile at bottom
          NavItem(icon: Icons.person, label: 'Profile', route: '/profile'),
          NavItem(icon: Icons.logout, label: 'Logout', onTap: () => logout()),
        ],
      ),
    );
  }
}
```

### Main Layout Wrapper

```dart
// lib/core/layout/main_layout.dart

class MainLayout extends ConsumerWidget {
  final Widget child;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = ResponsiveBuilder.isMobile(context);
    final isDesktop = ResponsiveBuilder.isDesktop(context);
    
    if (isDesktop) {
      return Row(
        children: [
          AppSidebar(...),
          Expanded(child: child),
        ],
      );
    }
    
    // Mobile/Tablet: Use Scaffold with BottomNavigationBar
    return Scaffold(
      body: child,
      bottomNavigationBar: isMobile ? AppBottomNavigationBar(...) : null,
    );
  }
}
```

### Shell Route Pattern

```dart
// Update app_router.dart to use ShellRoute

GoRouter(
  routes: [
    // Auth routes (no shell)
    GoRoute(path: '/onboarding', ...),
    GoRoute(path: '/login', ...),
    GoRoute(path: '/signup', ...),
    
    // Main app routes (with shell/layout)
    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
      routes: [
        GoRoute(path: '/', builder: (context, state) => DashboardView()),
        GoRoute(path: '/events', builder: (context, state) => EventsView()),
        GoRoute(path: '/clients', builder: (context, state) => ClientsView()),
        GoRoute(path: '/inventory', builder: (context, state) => InventoryView()),
        GoRoute(path: '/invoices', builder: (context, state) => InvoicesView()),
        GoRoute(path: '/profile', builder: (context, state) => ProfileView()),
      ],
    ),
  ],
);
```

---

## 8. Testing Strategy

### Unit Tests

**For Each Feature:**

1. **Use Cases Tests:**
   ```dart
   // test/features/events/domain/usecases/get_all_events_usecase_test.dart
   
   void main() {
     late MockEventsRepository mockRepository;
     late GetAllEventsUseCase useCase;
     
     setUp(() {
       mockRepository = MockEventsRepository();
       useCase = GetAllEventsUseCase(mockRepository);
     });
     
     test('should get events from repository', () async {
       // Arrange
       final events = [Event(...)];
       when(mockRepository.getAllEvents()).thenAnswer((_) async => events);
       
       // Act
       final result = await useCase.execute();
       
       // Assert
       expect(result, events);
       verify(mockRepository.getAllEvents());
     });
   }
   ```

2. **Repository Tests:**
   ```dart
   // test/features/events/data/repositories/events_repository_impl_test.dart
   
   void main() {
     late MockEventsLocalDataSource mockDataSource;
     late EventsRepositoryImpl repository;
     
     // Test CRUD operations
     // Test error handling
   }
   ```

3. **Validators & Formatters Tests:**
   ```dart
   // test/core/utils/validators_test.dart
   // test/core/utils/formatters_test.dart
   ```

### Widget Tests

**For Each Screen:**
```dart
// test/features/events/presentation/ui/views/events_view_test.dart

void main() {
  testWidgets('displays events list', (tester) async {
    // Create mock providers
    final container = ProviderContainer(
      overrides: [
        eventsStateProvider.overrideWith((ref) => MockEventsNotifier()),
      ],
    );
    
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(home: EventsView()),
      ),
    );
    
    // Verify UI elements
    expect(find.byType(EventListItem), findsWidgets);
  });
  
  testWidgets('shows loading state', (tester) async { ... });
  testWidgets('shows error message', (tester) async { ... });
  testWidgets('filters events by status', (tester) async { ... });
}
```

### Integration Tests

```dart
// integration_test/app_test.dart

void main() {
  testWidgets('complete user flow: onboarding -> signup -> dashboard', (tester) async {
    await tester.pumpWidget(MyApp());
    
    // 1. Complete onboarding
    expect(find.text('Prevent Double Bookings'), findsOneWidget);
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    // ... continue through onboarding
    
    // 2. Fill signup form
    await tester.enterText(find.byKey(Key('businessName')), 'Test Business');
    // ... fill other fields
    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();
    
    // 3. Verify dashboard shows
    expect(find.text('Dashboard'), findsOneWidget);
  });
  
  testWidgets('create and view event', (tester) async { ... });
  testWidgets('create invoice for client', (tester) async { ... });
}
```

---

## 9. Backend Integration

When ready to integrate with Supabase (or another backend):

### 1. Setup

**Add Dependencies:**
```yaml
dependencies:
  supabase_flutter: ^latest_version
  dio: ^5.4.0  # For HTTP requests
```

**Initialize Supabase:**
```dart
// lib/core/config/supabase_config.dart

class SupabaseConfig {
  static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const String supabaseAnonKey = String.fromEnvironment('SUPABASE_KEY');
  
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }
}

// In main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.initialize();
  // ... rest of initialization
}
```

### 2. Create Remote Data Sources

**Example: Events Remote Data Source**
```dart
// lib/features/events/data/datasources/events_remote_datasource.dart

class EventsRemoteDataSource {
  final SupabaseClient _supabase;
  
  EventsRemoteDataSource(this._supabase);
  
  Future<List<EventModel>> getAllEvents() async {
    final response = await _supabase
        .from('events')
        .select()
        .order('date', ascending: false);
    
    return (response as List)
        .map((json) => EventModel.fromJson(json))
        .toList();
  }
  
  Future<EventModel> createEvent(EventModel event) async {
    final response = await _supabase
        .from('events')
        .insert(event.toJson())
        .select()
        .single();
    
    return EventModel.fromJson(response);
  }
  
  // ... other CRUD methods
}
```

### 3. Update Repository Implementation

**Hybrid Approach (Remote + Local Cache):**
```dart
// lib/features/events/data/repositories/events_repository_impl.dart

class EventsRepositoryImpl implements EventsRepository {
  final EventsRemoteDataSource _remoteDataSource;
  final EventsLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  
  @override
  Future<List<Event>> getAllEvents() async {
    if (await _networkInfo.isConnected) {
      try {
        // Fetch from remote
        final events = await _remoteDataSource.getAllEvents();
        
        // Cache locally
        await _localDataSource.cacheEvents(events);
        
        return events;
      } catch (e) {
        // Fallback to cache
        return await _localDataSource.getCachedEvents();
      }
    } else {
      // Offline: use cache
      return await _localDataSource.getCachedEvents();
    }
  }
  
  // ... other methods with similar pattern
}
```

### 4. Authentication with Supabase

**Update Auth Remote Data Source:**
```dart
// lib/features/auth/data/datasources/auth_remote_datasource.dart

class AuthRemoteDataSource {
  final SupabaseClient _supabase;
  
  Future<VendorModel> login(String email, String password) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    
    if (response.user == null) {
      throw Exception('Login failed');
    }
    
    // Fetch vendor profile
    final vendorData = await _supabase
        .from('vendors')
        .select()
        .eq('user_id', response.user!.id)
        .single();
    
    return VendorModel.fromJson(vendorData);
  }
  
  Future<VendorModel> signup({
    required String email,
    required String password,
    required VendorModel vendor,
  }) async {
    // 1. Create auth user
    final authResponse = await _supabase.auth.signUp(
      email: email,
      password: password,
    );
    
    if (authResponse.user == null) {
      throw Exception('Signup failed');
    }
    
    // 2. Create vendor profile
    final vendorData = await _supabase
        .from('vendors')
        .insert({
          'user_id': authResponse.user!.id,
          ...vendor.toJson(),
        })
        .select()
        .single();
    
    return VendorModel.fromJson(vendorData);
  }
  
  Future<void> logout() async {
    await _supabase.auth.signOut();
  }
}
```

### 5. Database Schema (Supabase)

**Tables to Create:**

```sql
-- Vendors table
CREATE TABLE vendors (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  business_name TEXT NOT NULL,
  full_name TEXT NOT NULL,
  email TEXT NOT NULL,
  phone TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Clients table
CREATE TABLE clients (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  vendor_id UUID REFERENCES vendors(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  phone TEXT NOT NULL,
  email TEXT,
  last_event DATE,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Events table
CREATE TABLE events (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  vendor_id UUID REFERENCES vendors(id) ON DELETE CASCADE,
  client_id UUID REFERENCES clients(id),
  name TEXT NOT NULL,
  date DATE NOT NULL,
  location TEXT NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('COVERED', 'ATTENTION', 'CONFLICT')),
  revenue NUMERIC(10, 2),
  created_at TIMESTAMP DEFAULT NOW()
);

-- Inventory table
CREATE TABLE inventory (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  vendor_id UUID REFERENCES vendors(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  category TEXT NOT NULL,
  quantity INTEGER NOT NULL DEFAULT 0,
  notes TEXT,
  image_url TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Invoices table
CREATE TABLE invoices (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  vendor_id UUID REFERENCES vendors(id) ON DELETE CASCADE,
  client_id UUID REFERENCES clients(id),
  invoice_number TEXT NOT NULL,
  issue_date DATE NOT NULL,
  due_date DATE NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('DRAFT', 'SENT', 'PAID', 'OVERDUE')),
  amount NUMERIC(10, 2) NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Invoice Items table
CREATE TABLE invoice_items (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  invoice_id UUID REFERENCES invoices(id) ON DELETE CASCADE,
  description TEXT NOT NULL,
  quantity INTEGER NOT NULL,
  unit_price NUMERIC(10, 2) NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Activity Logs table
CREATE TABLE activity_logs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  vendor_id UUID REFERENCES vendors(id) ON DELETE CASCADE,
  type TEXT NOT NULL CHECK (type IN ('EVENT_CREATED', 'INVOICE_SENT', 'PAYMENT_RECEIVED', 'CLIENT_ADDED')),
  message TEXT NOT NULL,
  timestamp TIMESTAMP DEFAULT NOW()
);
```

**Row Level Security (RLS) Policies:**

```sql
-- Enable RLS on all tables
ALTER TABLE vendors ENABLE ROW LEVEL SECURITY;
ALTER TABLE clients ENABLE ROW LEVEL SECURITY;
-- ... repeat for all tables

-- Vendors can only see their own data
CREATE POLICY vendor_select_policy ON vendors
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY vendor_update_policy ON vendors
  FOR UPDATE USING (auth.uid() = user_id);

-- Similar policies for other tables using vendor_id
CREATE POLICY client_select_policy ON clients
  FOR SELECT USING (
    vendor_id IN (SELECT id FROM vendors WHERE user_id = auth.uid())
  );

-- ... create policies for all CRUD operations on all tables
```

### 6. Environment Configuration

```dart
// lib/core/config/env_config.dart

class EnvConfig {
  static const bool isDevelopment = bool.fromEnvironment('DEV', defaultValue: true);
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000',
  );
  static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const String supabaseKey = String.fromEnvironment('SUPABASE_KEY');
}
```

**Run with environment variables:**
```bash
flutter run --dart-define=SUPABASE_URL=https://xxx.supabase.co --dart-define=SUPABASE_KEY=xxx
```

### 7. Network Info Service

```dart
// lib/core/network/network_info.dart

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;
  
  NetworkInfoImpl(this._connectivity);
  
  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}

// Provider
final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(Connectivity());
});
```

---

## 10. Additional Enhancements

### Search Functionality

**Global Search Widget:**
```dart
// lib/core/widgets/global_search.dart

class GlobalSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) { ... }
  
  @override
  Widget buildLeading(BuildContext context) { ... }
  
  @override
  Widget buildResults(BuildContext context) {
    // Search across events, clients, inventory, invoices
    // Return unified search results
  }
  
  @override
  Widget buildSuggestions(BuildContext context) {
    // Show recent searches or suggestions
  }
}
```

### Notifications

**Local Notifications for Reminders:**
```yaml
dependencies:
  flutter_local_notifications: ^latest
```

```dart
// lib/core/services/notification_service.dart

class NotificationService {
  Future<void> scheduleEventReminder(Event event) async {
    // Schedule notification 1 day before event
  }
  
  Future<void> scheduleInvoiceReminder(Invoice invoice) async {
    // Schedule notification on due date
  }
}
```

### Export/Import Data

**CSV Export for Reports:**
```dart
// lib/core/utils/csv_exporter.dart

class CsvExporter {
  Future<String> exportEvents(List<Event> events) async { ... }
  Future<String> exportInvoices(List<Invoice> invoices) async { ... }
}
```

### Dark Mode Toggle

```dart
// lib/features/profile/presentation/ui/views/settings_view.dart

class SettingsView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: themeMode == ThemeMode.dark,
            onChanged: (value) {
              ref.read(themeModeProvider.notifier).state = 
                  value ? ThemeMode.dark : ThemeMode.light;
            },
          ),
        ],
      ),
    );
  }
}

// Provider
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

// Update main.dart
MaterialApp.router(
  themeMode: ref.watch(themeModeProvider),
  ...
);
```

---

## Summary Checklist

### Features Implementation
- [ ] Dashboard Feature (Domain, Data, Presentation, UI)
- [ ] Events Feature (Domain, Data, Presentation, UI)
- [ ] Clients Feature (Domain, Data, Presentation, UI)
- [ ] Inventory Feature (Domain, Data, Presentation, UI)
- [ ] Invoices Feature (Domain, Data, Presentation, UI)
- [ ] Profile Feature (Domain, Data, Presentation, UI)

### Navigation
- [ ] Bottom navigation bar (mobile)
- [ ] Sidebar navigation (desktop)
- [ ] Main layout wrapper
- [ ] ShellRoute implementation
- [ ] All routes configured

### Testing
- [ ] Unit tests for all use cases
- [ ] Unit tests for all repositories
- [ ] Widget tests for all screens
- [ ] Integration tests for critical flows

### Backend Integration
- [ ] Supabase setup
- [ ] Remote data sources
- [ ] Updated repositories (remote + cache)
- [ ] Authentication with Supabase
- [ ] Database schema created
- [ ] RLS policies configured

### Enhancements
- [ ] Global search
- [ ] Local notifications
- [ ] Data export (CSV)
- [ ] Dark mode toggle
- [ ] Error handling & logging

---

## Estimated Timeline

- **Dashboard:** 2-3 days
- **Events:** 3-4 days
- **Clients:** 2-3 days
- **Inventory:** 2-3 days
- **Invoices:** 3-4 days
- **Profile:** 1-2 days
- **Navigation Enhancement:** 1-2 days
- **Testing:** 3-5 days
- **Backend Integration:** 3-5 days
- **Polishing & Enhancements:** 2-3 days

**Total:** ~3-4 weeks for full implementation

---

## Getting Started

1. Start with **Dashboard** (most visible, sets the tone)
2. Then **Events** (core functionality)
3. Then **Clients** → **Inventory** → **Invoices** (supporting features)
4. Finally **Profile** and **Navigation Enhancement**
5. Write tests throughout (don't leave for the end)
6. Integrate backend when all features work with mock data

Good luck! 🚀
