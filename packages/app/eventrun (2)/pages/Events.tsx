import React, { useState } from 'react';
import { Plus, Search, Filter, MapPin, Calendar, User } from 'lucide-react';
import { EVENTS } from '../constants';
import { StatusBadge } from '../components/ui/StatusBadge';
import { Event } from '../types';

const Events: React.FC = () => {
  const [filter, setFilter] = useState<'all' | 'upcoming' | 'past'>('all');
  const [searchTerm, setSearchTerm] = useState('');

  // Filtering logic
  const filteredEvents = EVENTS.filter(event => {
    const matchesSearch = event.name.toLowerCase().includes(searchTerm.toLowerCase()) || 
                          event.location.toLowerCase().includes(searchTerm.toLowerCase());
    
    const eventDate = new Date(event.date);
    const today = new Date();
    
    if (filter === 'upcoming') return matchesSearch && eventDate >= today;
    if (filter === 'past') return matchesSearch && eventDate < today;
    return matchesSearch;
  });

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
        <div>
          <h2 className="text-2xl font-bold text-slate-900">Events</h2>
          <p className="text-slate-500 text-sm">Manage your bookings and avoid conflicts.</p>
        </div>
        <button className="bg-teal-600 hover:bg-teal-700 text-white font-medium py-2 px-4 rounded-lg flex items-center shadow-sm w-full sm:w-auto justify-center">
          <Plus className="w-4 h-4 mr-2" />
          Create Event
        </button>
      </div>

      {/* Controls */}
      <div className="bg-white p-4 rounded-xl border border-slate-200 shadow-sm flex flex-col sm:flex-row gap-4">
        <div className="relative flex-1">
          <Search className="absolute left-3 top-2.5 h-5 w-5 text-slate-400" />
          <input
            type="text"
            placeholder="Search events or locations..."
            className="w-full pl-10 pr-4 py-2 border border-slate-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-teal-500 focus:border-transparent"
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
          />
        </div>
        <div className="flex items-center gap-2 overflow-x-auto no-scrollbar pb-1 sm:pb-0">
          <button 
            onClick={() => setFilter('all')}
            className={`px-4 py-2 rounded-lg text-sm font-medium whitespace-nowrap transition-colors ${filter === 'all' ? 'bg-slate-900 text-white' : 'bg-slate-100 text-slate-600 hover:bg-slate-200'}`}
          >
            All Events
          </button>
          <button 
            onClick={() => setFilter('upcoming')}
            className={`px-4 py-2 rounded-lg text-sm font-medium whitespace-nowrap transition-colors ${filter === 'upcoming' ? 'bg-slate-900 text-white' : 'bg-slate-100 text-slate-600 hover:bg-slate-200'}`}
          >
            Upcoming
          </button>
          <button 
            onClick={() => setFilter('past')}
            className={`px-4 py-2 rounded-lg text-sm font-medium whitespace-nowrap transition-colors ${filter === 'past' ? 'bg-slate-900 text-white' : 'bg-slate-100 text-slate-600 hover:bg-slate-200'}`}
          >
            Past
          </button>
        </div>
      </div>

      {/* Events List */}
      <div className="space-y-4">
        {filteredEvents.length > 0 ? (
          filteredEvents.map((event) => (
            <div key={event.id} className="bg-white rounded-xl border border-slate-200 shadow-sm hover:border-teal-400 transition-colors group">
              <div className="p-5">
                <div className="flex justify-between items-start mb-4">
                  <div>
                    <h3 className="text-lg font-bold text-slate-900 group-hover:text-teal-700 transition-colors">{event.name}</h3>
                    <div className="flex items-center text-sm text-slate-500 mt-1">
                      <MapPin className="w-3.5 h-3.5 mr-1" />
                      {event.location}
                    </div>
                  </div>
                  <StatusBadge status={event.status} type="event" />
                </div>
                
                <div className="grid grid-cols-2 md:grid-cols-4 gap-4 pt-4 border-t border-slate-100">
                  <div className="flex items-center">
                    <div className="w-8 h-8 rounded-lg bg-teal-50 text-teal-600 flex items-center justify-center mr-3">
                      <Calendar className="w-4 h-4" />
                    </div>
                    <div>
                      <p className="text-xs text-slate-500">Date</p>
                      <p className="text-sm font-medium text-slate-900">
                        {new Date(event.date).toLocaleDateString('en-NG', { day: 'numeric', month: 'short', year: 'numeric' })}
                      </p>
                    </div>
                  </div>

                  <div className="flex items-center">
                    <div className="w-8 h-8 rounded-lg bg-blue-50 text-blue-600 flex items-center justify-center mr-3">
                      <User className="w-4 h-4" />
                    </div>
                    <div>
                      <p className="text-xs text-slate-500">Client</p>
                      <p className="text-sm font-medium text-slate-900 truncate max-w-[100px] sm:max-w-none">
                         {/* In a real app, we'd lookup client name by ID */}
                         Client #{event.clientId}
                      </p>
                    </div>
                  </div>

                  <div className="flex items-center col-span-2 md:col-span-1">
                    <div className="w-full bg-slate-100 rounded-full h-2 mr-3 relative overflow-hidden">
                       {/* Mock inventory fill percentage */}
                      <div className={`h-full rounded-full ${event.status === 'CONFLICT' ? 'bg-red-500 w-full' : 'bg-teal-500 w-3/4'}`}></div>
                    </div>
                    <span className="text-xs font-medium text-slate-600 whitespace-nowrap">{event.inventoryCount} Items</span>
                  </div>
                </div>
              </div>
            </div>
          ))
        ) : (
          <div className="text-center py-12 bg-white rounded-xl border border-slate-200 border-dashed">
            <Calendar className="w-12 h-12 text-slate-300 mx-auto mb-4" />
            <h3 className="text-lg font-medium text-slate-900">No events found</h3>
            <p className="text-slate-500 mb-6">Try adjusting your filters or create a new event.</p>
            <button className="text-teal-600 font-medium hover:text-teal-700">Clear Filters</button>
          </div>
        )}
      </div>
    </div>
  );
};

export default Events;