export type EventStatus = 'COVERED' | 'ATTENTION' | 'CONFLICT';

export type InvoiceStatus = 'DRAFT' | 'SENT' | 'PAID' | 'OVERDUE';

export interface Vendor {
  id: string;
  businessName: string;
  fullName: string;
  email: string;
  phone: string;
}

export interface Client {
  id: string;
  name: string;
  phone: string;
  email?: string;
  lastEventDate?: string;
}

export interface InventoryItem {
  id: string;
  name: string;
  quantity: number;
  category: string;
  notes?: string;
  imageUrl?: string;
}

export interface Event {
  id: string;
  name: string;
  date: string; // ISO string
  location: string;
  clientId: string;
  status: EventStatus;
  inventoryCount: number;
  revenue: number;
  notes?: string;
}

export interface InvoiceItem {
  id: string;
  description: string;
  quantity: number;
  unitPrice: number;
}

export interface Invoice {
  id: string;
  invoiceNumber: string;
  clientId: string;
  eventId?: string;
  items: InvoiceItem[];
  amount: number; // Derived from items usually, but kept for cache
  dateIssued: string;
  dueDate: string;
  status: InvoiceStatus;
  notes?: string;
}

export interface ActivityLog {
  id: string;
  type: 'EVENT_CREATED' | 'INVOICE_SENT' | 'PAYMENT_RECEIVED' | 'CLIENT_ADDED' | 'CONFLICT_DETECTED';
  message: string;
  timestamp: string;
}