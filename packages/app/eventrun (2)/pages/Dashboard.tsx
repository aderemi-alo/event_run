import React from 'react';
import { 
  BarChart, 
  Bar, 
  XAxis, 
  YAxis, 
  CartesianGrid, 
  Tooltip, 
  ResponsiveContainer 
} from 'recharts';
import { Calendar, AlertCircle, TrendingUp, ChevronRight, PlusCircle } from 'lucide-react';
import { Link } from 'react-router-dom';
import { EVENTS, RECENT_ACTIVITY, formatNaira } from '../constants';
import { StatusBadge } from '../components/ui/StatusBadge';

const Dashboard: React.FC = () => {
  // Mock Data for Chart
  const revenueData = [
    { name: 'Jul', amount: 450000 },
    { name: 'Aug', amount: 800000 },
    { name: 'Sep', amount: 620000 },
    { name: 'Oct', amount: 1200000 },
    { name: 'Nov', amount: 950000 },
    { name: 'Dec', amount: 1500000 },
  ];

  const upcomingEvents = EVENTS.filter(e => new Date(e.date) >= new Date('2023-11-15')).slice(0, 3);
  const eventsNeedingAttention = EVENTS.filter(e => e.status === 'ATTENTION' || e.status === 'CONFLICT');

  return (
    <div className="space-y-6">
      {/* Welcome Section */}
      <div className="flex justify-between items-end">
        <div>
          <h2 className="text-xl font-bold text-slate-900">Welcome back, Ola 👋</h2>
          <p className="text-sm text-slate-500">Here's what's happening in your business today.</p>
        </div>
        <div className="hidden md:block">
          <span className="text-sm font-medium text-slate-500">Today: {new Date().toLocaleDateString('en-NG', { weekday: 'long', day: 'numeric', month: 'long' })}</span>
        </div>
      </div>

      {/* Stats Cards - Horizontal Scroll on Mobile */}
      <div className="flex space-x-4 overflow-x-auto pb-4 no-scrollbar md:grid md:grid-cols-3 md:space-x-0 md:gap-6 md:pb-0">
        
        {/* Card 1: Revenue */}
        <div className="min-w-[280px] md:min-w-0 bg-white p-5 rounded-xl border border-slate-200 shadow-sm flex flex-col justify-between">
          <div className="flex justify-between items-start mb-4">
            <div className="p-2 bg-teal-50 rounded-lg">
              <TrendingUp className="w-5 h-5 text-teal-600" />
            </div>
            <span className="text-xs font-medium text-green-600 bg-green-50 px-2 py-1 rounded">+12% vs last month</span>
          </div>
          <div>
            <p className="text-sm text-slate-500 font-medium">Total Revenue (Nov)</p>
            <h3 className="text-2xl font-bold text-slate-900">{formatNaira(950000)}</h3>
          </div>
        </div>

        {/* Card 2: Upcoming Events */}
        <div className="min-w-[280px] md:min-w-0 bg-white p-5 rounded-xl border border-slate-200 shadow-sm flex flex-col justify-between">
          <div className="flex justify-between items-start mb-4">
            <div className="p-2 bg-blue-50 rounded-lg">
              <Calendar className="w-5 h-5 text-blue-600" />
            </div>
            <span className="text-xs font-medium text-slate-500 bg-slate-100 px-2 py-1 rounded">Next 7 days</span>
          </div>
          <div>
            <p className="text-sm text-slate-500 font-medium">Upcoming Events</p>
            <h3 className="text-2xl font-bold text-slate-900">4 Events</h3>
          </div>
        </div>

         {/* Card 3: Needs Attention */}
         <div className="min-w-[280px] md:min-w-0 bg-white p-5 rounded-xl border border-red-100 shadow-sm flex flex-col justify-between relative overflow-hidden">
          <div className="absolute right-0 top-0 w-16 h-16 bg-red-50 rounded-bl-full -mr-4 -mt-4 z-0"></div>
          <div className="flex justify-between items-start mb-4 z-10">
            <div className="p-2 bg-red-50 rounded-lg">
              <AlertCircle className="w-5 h-5 text-red-600" />
            </div>
          </div>
          <div className="z-10">
            <p className="text-sm text-slate-500 font-medium">Needs Attention</p>
            <h3 className="text-2xl font-bold text-slate-900">{eventsNeedingAttention.length} Issues</h3>
          </div>
        </div>
      </div>

      {/* Main Layout Grid */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        
        {/* Left Column (2/3 width) */}
        <div className="lg:col-span-2 space-y-6">
          
          {/* Quick Actions */}
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
            <button className="flex flex-col items-center justify-center p-4 bg-white border border-slate-200 rounded-xl hover:border-teal-500 hover:bg-teal-50 transition-all group">
              <div className="w-10 h-10 bg-teal-100 text-teal-600 rounded-full flex items-center justify-center mb-2 group-hover:bg-teal-200">
                <PlusCircle className="w-6 h-6" />
              </div>
              <span className="text-sm font-medium text-slate-700">Create Event</span>
            </button>
            <button className="flex flex-col items-center justify-center p-4 bg-white border border-slate-200 rounded-xl hover:border-teal-500 hover:bg-teal-50 transition-all group">
              <div className="w-10 h-10 bg-blue-100 text-blue-600 rounded-full flex items-center justify-center mb-2 group-hover:bg-blue-200">
                <Calendar className="w-6 h-6" />
              </div>
              <span className="text-sm font-medium text-slate-700">Calendar</span>
            </button>
             {/* More placeholders for quick actions */}
          </div>

          {/* Attention Section (if any) */}
          {eventsNeedingAttention.length > 0 && (
            <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
              <div className="px-5 py-4 border-b border-slate-100 flex justify-between items-center bg-red-50/50">
                <h3 className="font-semibold text-red-900 flex items-center">
                  <AlertCircle className="w-4 h-4 mr-2 text-red-600" />
                  Needs Your Attention
                </h3>
              </div>
              <div className="divide-y divide-slate-100">
                {eventsNeedingAttention.map(event => (
                  <Link to={`/events`} key={event.id} className="block hover:bg-slate-50 transition-colors">
                    <div className="px-5 py-4 flex items-center justify-between">
                      <div className="flex items-center space-x-3">
                         <div className="flex-shrink-0 w-12 text-center">
                            <span className="block text-xs font-bold text-slate-500 uppercase">{new Date(event.date).toLocaleDateString('en-US', { month: 'short' })}</span>
                            <span className="block text-lg font-bold text-slate-900">{new Date(event.date).getDate()}</span>
                         </div>
                         <div>
                           <p className="text-sm font-medium text-slate-900">{event.name}</p>
                           <p className="text-xs text-slate-500">{event.location}</p>
                         </div>
                      </div>
                      <StatusBadge status={event.status} type="event" />
                    </div>
                  </Link>
                ))}
              </div>
            </div>
          )}

          {/* Upcoming Events */}
          <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
             <div className="px-5 py-4 border-b border-slate-100 flex justify-between items-center">
                <h3 className="font-semibold text-slate-800">Upcoming Events</h3>
                <Link to="/events" className="text-sm text-teal-600 font-medium hover:text-teal-700">View All</Link>
             </div>
             <div className="divide-y divide-slate-100">
               {upcomingEvents.map(event => (
                  <div key={event.id} className="px-5 py-4 flex items-center justify-between hover:bg-slate-50">
                     <div className="flex items-center space-x-4">
                        <div className="w-10 h-10 rounded-full bg-slate-100 flex items-center justify-center text-slate-500">
                           <Calendar className="w-5 h-5" />
                        </div>
                        <div>
                          <p className="text-sm font-medium text-slate-900">{event.name}</p>
                          <p className="text-xs text-slate-500">{new Date(event.date).toLocaleDateString('en-NG', { weekday: 'short', day: 'numeric', month: 'short' })} • {event.location}</p>
                        </div>
                     </div>
                     <ChevronRight className="w-4 h-4 text-slate-400" />
                  </div>
               ))}
             </div>
          </div>
        </div>

        {/* Right Column (1/3 width) - Stats & Activity */}
        <div className="space-y-6">
          
          {/* Chart */}
          <div className="bg-white rounded-xl border border-slate-200 shadow-sm p-5">
            <h3 className="font-semibold text-slate-800 mb-4">Revenue Trend</h3>
            <div className="h-48 w-full text-xs">
              <ResponsiveContainer width="100%" height="100%">
                <BarChart data={revenueData}>
                  <CartesianGrid strokeDasharray="3 3" vertical={false} />
                  <XAxis dataKey="name" axisLine={false} tickLine={false} />
                  <YAxis axisLine={false} tickLine={false} tickFormatter={(value) => `₦${value/1000}k`} />
                  <Tooltip 
                    formatter={(value: number) => [formatNaira(value), 'Revenue']}
                    contentStyle={{ borderRadius: '8px', border: 'none', boxShadow: '0 4px 6px -1px rgb(0 0 0 / 0.1)' }}
                  />
                  <Bar dataKey="amount" fill="#0d9488" radius={[4, 4, 0, 0]} />
                </BarChart>
              </ResponsiveContainer>
            </div>
          </div>

          {/* Recent Activity */}
          <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
             <div className="px-5 py-4 border-b border-slate-100">
                <h3 className="font-semibold text-slate-800">Recent Activity</h3>
             </div>
             <div className="p-5 space-y-6">
               {RECENT_ACTIVITY.map(log => (
                 <div key={log.id} className="flex space-x-3 relative">
                    <div className="absolute left-[7px] top-6 bottom-[-24px] w-0.5 bg-slate-100 last:hidden"></div>
                    <div className={`w-4 h-4 rounded-full mt-1 flex-shrink-0 ${
                      log.type === 'CONFLICT_DETECTED' ? 'bg-red-500' :
                      log.type === 'PAYMENT_RECEIVED' ? 'bg-green-500' :
                      'bg-teal-500'
                    }`}></div>
                    <div>
                       <p className="text-sm text-slate-800">{log.message}</p>
                       <p className="text-xs text-slate-400 mt-0.5">{log.timestamp}</p>
                    </div>
                 </div>
               ))}
             </div>
          </div>

        </div>
      </div>
    </div>
  );
};

export default Dashboard;