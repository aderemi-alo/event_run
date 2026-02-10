import React from 'react';
import { Plus, Phone, Mail, User } from 'lucide-react';
import { CLIENTS } from '../constants';

const Clients: React.FC = () => {
  return (
    <div className="space-y-6">
       <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
        <div>
          <h2 className="text-2xl font-bold text-slate-900">Clients</h2>
          <p className="text-slate-500 text-sm">Manage your customer relationships.</p>
        </div>
        <button className="bg-slate-900 hover:bg-slate-800 text-white font-medium py-2 px-4 rounded-lg flex items-center shadow-sm w-full sm:w-auto justify-center">
          <Plus className="w-4 h-4 mr-2" />
          Add Client
        </button>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {CLIENTS.map(client => (
          <div key={client.id} className="bg-white rounded-xl border border-slate-200 shadow-sm p-6 flex flex-col items-center text-center hover:border-teal-400 transition-all">
             <div className="w-20 h-20 bg-slate-100 rounded-full flex items-center justify-center text-slate-400 mb-4">
               <User className="w-10 h-10" />
             </div>
             <h3 className="text-lg font-bold text-slate-900">{client.name}</h3>
             <p className="text-sm text-slate-500 mb-6">{client.lastEventDate ? `Last event: ${new Date(client.lastEventDate).toLocaleDateString()}` : 'New Client'}</p>
             
             <div className="w-full grid grid-cols-2 gap-3 mt-auto">
               <a href={`tel:${client.phone}`} className="flex items-center justify-center py-2 px-4 rounded-lg bg-teal-50 text-teal-700 hover:bg-teal-100 transition-colors text-sm font-medium">
                 <Phone className="w-4 h-4 mr-2" />
                 Call
               </a>
               {client.email ? (
                 <a href={`mailto:${client.email}`} className="flex items-center justify-center py-2 px-4 rounded-lg bg-slate-100 text-slate-700 hover:bg-slate-200 transition-colors text-sm font-medium">
                   <Mail className="w-4 h-4 mr-2" />
                   Email
                 </a>
               ) : (
                  <button disabled className="flex items-center justify-center py-2 px-4 rounded-lg bg-slate-50 text-slate-300 cursor-not-allowed text-sm font-medium">
                   <Mail className="w-4 h-4 mr-2" />
                   Email
                 </button>
               )}
             </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default Clients;