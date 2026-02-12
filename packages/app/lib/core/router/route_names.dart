class RouteNames {
  RouteNames._();

  // Auth
  static const String login = 'login';
  static const String signup = 'signup';
  static const String forgotPassword = 'forgotPassword';
  static const String profile = 'profile';

  // Dashboard
  static const String dashboard = 'dashboard';

  // Vendor
  static const String vendorSetup = 'vendorSetup';
  static const String businessSettings = 'businessSettings';
  static const String bankDetails = 'bankDetails';
  static const String subscription = 'subscription';
  static const String authGate = 'authGate';

  // Clients
  static const String clients = 'clients';
  static const String clientDetail = 'clientDetail';

  // Events
  static const String events = 'events';
  static const String eventDetail = 'eventDetail';
  static const String eventForm = 'eventForm';
  static const String eventRequirements = 'eventRequirements';

  // Inventory
  static const String inventory = 'inventory';
  static const String inventoryForm = 'inventoryForm';

  // Invoices
  static const String invoices = 'invoices';
  static const String invoiceDetail = 'invoiceDetail';
  static const String invoiceForm = 'invoiceForm';
  static const String invoicePreview = 'invoicePreview';
  static const String recordPayment = 'recordPayment';
}

class RoutePaths {
  RoutePaths._();

  // Auth
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String profile = '/profile';

  // Dashboard
  static const String dashboard = '/';

  // Vendor
  static const String vendorSetup = '/vendor-setup';
  static const String businessSettings = '/business-settings';
  static const String bankDetails = '/bank-details';
  static const String subscription = '/subscription';
  static const String authGate = '/auth-gate';

  // Clients
  static const String clients = '/clients';
  static const String clientDetail = '/clients/:id';

  // Events
  static const String events = '/events';
  static const String eventForm = '/events/new';
  static const String eventDetail = '/events/:id';

  // Inventory
  static const String inventory = '/inventory';
  static const String inventoryForm = '/inventory/new';
  static const String inventoryEdit = '/inventory/:id/edit';

  // Invoices
  static const String invoices = '/invoices';
  static const String invoiceForm = '/invoices/new';
  static const String invoiceDetail = '/invoices/:id';
}
