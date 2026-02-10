import { Client, Event, InventoryItem, Invoice, ActivityLog } from './types';

export const CLIENTS: Client[] = [
  { id: '1', name: 'Chidinma Okoye', phone: '+234 803 123 4567', email: 'chidi@gmail.com', lastEventDate: '2023-10-15' },
  { id: '2', name: 'Tunde Bakare', phone: '+234 812 987 6543', email: 'tunde.b@yahoo.com' },
  { id: '3', name: 'Folake Adebayo', phone: '+234 705 555 1212', lastEventDate: '2023-11-02' },
  { id: '4', name: 'Grand Royal Hotels', phone: '+234 809 000 1111', email: 'events@grandroyal.ng' },
];

export const INVENTORY: InventoryItem[] = [
  { id: '1', name: 'JBL EON615 Speakers', quantity: 12, category: 'Audio', imageUrl: 'https://picsum.photos/100/100' },
  { id: '2', name: 'Shure SM58 Microphones', quantity: 8, category: 'Audio' },
  { id: '3', name: 'LED Par Cans', quantity: 24, category: 'Lighting' },
  { id: '4', name: 'Pioneer DJ Controller', quantity: 2, category: 'Audio' },
  { id: '5', name: 'Chiavari Chairs (Gold)', quantity: 500, category: 'Furniture' },
  { id: '6', name: 'Banquet Tables (Round)', quantity: 50, category: 'Furniture' },
];

export const EVENTS: Event[] = [
  { id: '1', name: 'Okoye Wedding Reception', date: '2023-11-18', location: 'Eko Hotels & Suites, VI', clientId: '1', status: 'COVERED', inventoryCount: 15, revenue: 850000, notes: 'Client wants extra bass.' },
  { id: '2', name: 'TechPoint Startup Mixer', date: '2023-11-20', location: 'Landmark Centre, Oniru', clientId: '4', status: 'ATTENTION', inventoryCount: 5, revenue: 200000 },
  { id: '3', name: 'Bakare Birthday Bash', date: '2023-11-25', location: 'Private Residence, Ikeja', clientId: '2', status: 'CONFLICT', inventoryCount: 8, revenue: 150000 },
  { id: '4', name: 'Annual AGM', date: '2023-12-01', location: 'Sheraton Abuja', clientId: '4', status: 'COVERED', inventoryCount: 20, revenue: 1200000 },
];

export const INVOICES: Invoice[] = [
  { 
    id: '1', 
    invoiceNumber: 'INV-042', 
    clientId: '1', 
    eventId: '1', 
    items: [
      { id: '1', description: 'Sound System Full Package', quantity: 1, unitPrice: 500000 },
      { id: '2', description: 'DJ Services', quantity: 1, unitPrice: 350000 }
    ],
    amount: 850000, 
    dateIssued: '2023-11-01', 
    dueDate: '2023-11-15', 
    status: 'PAID' 
  },
  { 
    id: '2', 
    invoiceNumber: 'INV-043', 
    clientId: '4', 
    eventId: '2', 
    items: [
       { id: '1', description: 'PA System Rental', quantity: 1, unitPrice: 200000 }
    ],
    amount: 200000, 
    dateIssued: '2023-11-05', 
    dueDate: '2023-11-19', 
    status: 'SENT' 
  },
  { 
    id: '3', 
    invoiceNumber: 'INV-044', 
    clientId: '2', 
    eventId: '3', 
    items: [
       { id: '1', description: 'Birthday Party Setup', quantity: 1, unitPrice: 150000 }
    ],
    amount: 150000, 
    dateIssued: '2023-11-10', 
    dueDate: '2023-11-11', 
    status: 'OVERDUE' 
  },
  { 
    id: '4', 
    invoiceNumber: 'INV-045', 
    clientId: '4', 
    items: [
       { id: '1', description: 'Corporate Event Lighting', quantity: 1, unitPrice: 1200000 }
    ],
    amount: 1200000, 
    dateIssued: '2023-11-12', 
    dueDate: '2023-11-25', 
    status: 'DRAFT' 
  },
];

export const RECENT_ACTIVITY: ActivityLog[] = [
  { id: '1', type: 'PAYMENT_RECEIVED', message: '₦850,000 received from Chidinma Okoye', timestamp: '2 mins ago' },
  { id: '2', type: 'CONFLICT_DETECTED', message: 'Double booking detected for Nov 25th', timestamp: '1 hour ago' },
  { id: '3', type: 'INVOICE_SENT', message: 'Invoice INV-043 sent to Grand Royal Hotels', timestamp: '3 hours ago' },
  { id: '4', type: 'EVENT_CREATED', message: 'New event created: Annual AGM', timestamp: '5 hours ago' },
  { id: '5', type: 'CLIENT_ADDED', message: 'New client added: Folake Adebayo', timestamp: '1 day ago' },
];

// Helper to format currency
export const formatNaira = (amount: number) => {
  return new Intl.NumberFormat('en-NG', {
    style: 'currency',
    currency: 'NGN',
    minimumFractionDigits: 0,
    maximumFractionDigits: 0,
  }).format(amount);
};