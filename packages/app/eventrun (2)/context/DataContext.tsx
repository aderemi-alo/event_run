import React, { createContext, useContext, useState, useEffect } from 'react';
import { Event, Client, InventoryItem, Invoice, ActivityLog } from '../types';
import { EVENTS, CLIENTS, INVENTORY, INVOICES, RECENT_ACTIVITY } from '../constants';

interface DataContextType {
  events: Event[];
  clients: Client[];
  inventory: InventoryItem[];
  invoices: Invoice[];
  activityLogs: ActivityLog[];
  
  // Event Actions
  addEvent: (event: Event) => void;
  updateEvent: (event: Event) => void;
  deleteEvent: (id: string) => void;
  getEvent: (id: string) => Event | undefined;

  // Inventory Actions
  addInventoryItem: (item: InventoryItem) => void;
  updateInventoryItem: (item: InventoryItem) => void;
  deleteInventoryItem: (id: string) => void;
  getInventoryItem: (id: string) => InventoryItem | undefined;

  // Invoice Actions
  addInvoice: (invoice: Invoice) => void;
  updateInvoice: (invoice: Invoice) => void;
  deleteInvoice: (id: string) => void;
  getInvoice: (id: string) => Invoice | undefined;
  getInvoiceForEvent: (eventId: string) => Invoice | undefined;
  
  // Client Actions
  getClient: (id: string) => Client | undefined;
}

const DataContext = createContext<DataContextType | undefined>(undefined);

export const DataProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [events, setEvents] = useState<Event[]>(EVENTS);
  const [clients, setClients] = useState<Client[]>(CLIENTS);
  const [inventory, setInventory] = useState<InventoryItem[]>(INVENTORY);
  const [invoices, setInvoices] = useState<Invoice[]>(INVOICES);
  const [activityLogs, setActivityLogs] = useState<ActivityLog[]>(RECENT_ACTIVITY);

  // --- Events ---
  const addEvent = (event: Event) => {
    setEvents(prev => [...prev, event]);
    addLog('EVENT_CREATED', `New event created: ${event.name}`);
  };

  const updateEvent = (updatedEvent: Event) => {
    setEvents(prev => prev.map(e => e.id === updatedEvent.id ? updatedEvent : e));
  };

  const deleteEvent = (id: string) => {
    setEvents(prev => prev.filter(e => e.id !== id));
  };

  const getEvent = (id: string) => events.find(e => e.id === id);

  // --- Inventory ---
  const addInventoryItem = (item: InventoryItem) => {