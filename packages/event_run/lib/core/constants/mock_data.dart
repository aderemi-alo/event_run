import 'package:event_run/features/auth/domain/entities/vendor.dart';
import 'package:event_run/features/clients/domain/entities/client.dart';
import 'package:event_run/features/events/domain/entities/event.dart';
import 'package:event_run/features/inventory/domain/entities/inventory_item.dart';
import 'package:event_run/features/invoices/domain/entities/invoice.dart';
import 'package:event_run/features/invoices/domain/entities/invoice_item.dart';
import 'package:event_run/features/dashboard/domain/entities/activity_log.dart';

/// Mock data constants (will be replaced with real API data later)
class MockData {
  MockData._();

  static final List<Client> clients = [
    const Client(
      id: '1',
      name: 'Chidinma Okoye',
      phone: '+234 803 123 4567',
      email: 'chidi@gmail.com',
      lastEventDate: '2023-10-15',
    ),
    const Client(
      id: '2',
      name: 'Tunde Bakare',
      phone: '+234 812 987 6543',
      email: 'tunde.b@yahoo.com',
    ),
    const Client(
      id: '3',
      name: 'Folake Adebayo',
      phone: '+234 705 555 1212',
      lastEventDate: '2023-11-02',
    ),
    const Client(
      id: '4',
      name: 'Grand Royal Hotels',
      phone: '+234 809 000 1111',
      email: 'events@grandroyal.ng',
    ),
  ];

  static final List<InventoryItem> inventory = [
    const InventoryItem(
      id: '1',
      name: 'JBL EON615 Speakers',
      quantity: 12,
      category: 'Audio',
      imageUrl: 'https://picsum.photos/100/100',
    ),
    const InventoryItem(
      id: '2',
      name: 'Shure SM58 Microphones',
      quantity: 8,
      category: 'Audio',
    ),
    const InventoryItem(
      id: '3',
      name: 'LED Par Cans',
      quantity: 24,
      category: 'Lighting',
    ),
    const InventoryItem(
      id: '4',
      name: 'Pioneer DJ Controller',
      quantity: 2,
      category: 'Audio',
    ),
    const InventoryItem(
      id: '5',
      name: 'Chiavari Chairs (Gold)',
      quantity: 500,
      category: 'Furniture',
    ),
    const InventoryItem(
      id: '6',
      name: 'Banquet Tables (Round)',
      quantity: 50,
      category: 'Furniture',
    ),
  ];

  static final List<Event> events = [
    const Event(
      id: '1',
      name: 'Okoye Wedding Reception',
      date: '2023-11-18',
      location: 'Eko Hotels & Suites, VI',
      clientId: '1',
      status: EventStatus.covered,
      inventoryCount: 15,
      revenue: 850000,
      notes: 'Client wants extra bass.',
    ),
    const Event(
      id: '2',
      name: 'TechPoint Startup Mixer',
      date: '2023-11-20',
      location: 'Landmark Centre, Oniru',
      clientId: '4',
      status: EventStatus.attention,
      inventoryCount: 5,
      revenue: 200000,
    ),
    const Event(
      id: '3',
      name: 'Bakare Birthday Bash',
      date: '2023-11-25',
      location: 'Private Residence, Ikeja',
      clientId: '2',
      status: EventStatus.conflict,
      inventoryCount: 8,
      revenue: 150000,
    ),
    const Event(
      id: '4',
      name: 'Annual AGM',
      date: '2023-12-01',
      location: 'Sheraton Abuja',
      clientId: '4',
      status: EventStatus.covered,
      inventoryCount: 20,
      revenue: 1200000,
    ),
  ];

  static final List<Invoice> invoices = [
    Invoice(
      id: '1',
      invoiceNumber: 'INV-042',
      clientId: '1',
      eventId: '1',
      items: const [
        InvoiceItem(
          id: '1',
          description: 'Sound System Full Package',
          quantity: 1,
          unitPrice: 500000,
        ),
        InvoiceItem(
          id: '2',
          description: 'DJ Services',
          quantity: 1,
          unitPrice: 350000,
        ),
      ],
      amount: 850000,
      dateIssued: '2023-11-01',
      dueDate: '2023-11-15',
      status: InvoiceStatus.paid,
    ),
    Invoice(
      id: '2',
      invoiceNumber: 'INV-043',
      clientId: '4',
      eventId: '2',
      items: const [
        InvoiceItem(
          id: '1',
          description: 'PA System Rental',
          quantity: 1,
          unitPrice: 200000,
        ),
      ],
      amount: 200000,
      dateIssued: '2023-11-05',
      dueDate: '2023-11-19',
      status: InvoiceStatus.sent,
    ),
    Invoice(
      id: '3',
      invoiceNumber: 'INV-044',
      clientId: '2',
      eventId: '3',
      items: const [
        InvoiceItem(
          id: '1',
          description: 'Birthday Party Setup',
          quantity: 1,
          unitPrice: 150000,
        ),
      ],
      amount: 150000,
      dateIssued: '2023-11-10',
      dueDate: '2023-11-11',
      status: InvoiceStatus.overdue,
    ),
    Invoice(
      id: '4',
      invoiceNumber: 'INV-045',
      clientId: '4',
      items: const [
        InvoiceItem(
          id: '1',
          description: 'Corporate Event Lighting',
          quantity: 1,
          unitPrice: 1200000,
        ),
      ],
      amount: 1200000,
      dateIssued: '2023-11-12',
      dueDate: '2023-11-25',
      status: InvoiceStatus.draft,
    ),
  ];

  static final List<ActivityLog> recentActivity = [
    const ActivityLog(
      id: '1',
      type: ActivityType.paymentReceived,
      message: '₦850,000 received from Chidinma Okoye',
      timestamp: '2023-11-15T14:30:00',
    ),
    const ActivityLog(
      id: '2',
      type: ActivityType.conflictDetected,
      message: 'Double booking detected for Nov 25th',
      timestamp: '2023-11-15T13:00:00',
    ),
    const ActivityLog(
      id: '3',
      type: ActivityType.invoiceSent,
      message: 'Invoice INV-043 sent to Grand Royal Hotels',
      timestamp: '2023-11-15T11:00:00',
    ),
    const ActivityLog(
      id: '4',
      type: ActivityType.eventCreated,
      message: 'New event created: Annual AGM',
      timestamp: '2023-11-15T09:00:00',
    ),
    const ActivityLog(
      id: '5',
      type: ActivityType.clientAdded,
      message: 'New client added: Folake Adebayo',
      timestamp: '2023-11-14T14:30:00',
    ),
  ];

  static final Vendor mockVendor = const Vendor(
    id: '1',
    businessName: 'Ola Events Solutions',
    fullName: 'Ola Adesina',
    email: 'ola@eventssolutions.ng',
    phone: '+234 803 555 0123',
  );
}
