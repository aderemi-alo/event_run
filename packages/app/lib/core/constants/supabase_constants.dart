class SupabaseConstants {
  SupabaseConstants._();

  // Tables
  static const String profilesTable = 'profiles';
  static const String vendorsTable = 'vendors';
  static const String clientsTable = 'clients';
  static const String eventsTable = 'events';
  static const String eventRequirementsTable = 'event_requirements';
  static const String inventoryItemsTable = 'inventory_items';
  static const String invoicesTable = 'invoices';
  static const String invoiceItemsTable = 'invoice_items';
  static const String paymentsTable = 'payments';
  static const String subscriptionEventsTable = 'subscription_events';

  // Buckets
  static const String vendorLogosBucket = 'vendor-logos';
  static const String inventoryImagesBucket = 'inventory-images';
}
