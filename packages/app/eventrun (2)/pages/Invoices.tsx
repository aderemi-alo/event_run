import React from 'react';
import { Plus, Download, FileText } from 'lucide-react';
import { INVOICES, CLIENTS, formatNaira } from '../constants';
import { StatusBadge } from '../components/ui/StatusBadge';

const Invoices: React.FC = () => {
  return (
    <div className="space-y-6">
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
        <div>
          <h2 className="text-2xl font-bold text-slate-900">Invoices</h2>
          <p className="text-slate-500 text-sm">Track payments and manage billing.</p>
        </div>
        <button className="bg-teal-600 hover:bg-teal-700 text-white font-medium py-2 px-4 rounded-lg flex items-center shadow-sm w-full sm:w-auto justify-center">
          <Plus className="w-4 h-4 mr-2" />
          Create Invoice
        </button>
      </div>

      <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left">
            <thead className="bg-slate-50 text-slate-500 text-xs uppercase font-semibold">
              <tr>
                <th className="px-6 py-4">Invoice #</th>
                <th className="px-6 py-4">Client</th>
                <th className="px-6 py-4">Date Issued</th>
                <th className="px-6 py-4">Amount</th>
                <th className="px-6 py-4">Status</th>
                <th className="px-6 py-4 text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100">
              {INVOICES.map((invoice) => {
                const client = CLIENTS.find(c => c.id === invoice.clientId);
                return (
                  <tr key={invoice.id} className="hover:bg-slate-50 transition-colors">
                    <td className="px-6 py-4 font-medium text-slate-900">
                      {invoice.invoiceNumber}
                    </td>
                    <td className="px-6 py-4 text-slate-600">
                      {client?.name || 'Unknown Client'}
                    </td>
                    <td className="px-6 py-4 text-slate-600 text-sm">
                      {new Date(invoice.dateIssued).toLocaleDateString('en-NG')}
                    </td>
                    <td className="px-6 py-4 font-bold text-slate-900">
                      {formatNaira(invoice.amount)}
                    </td>
                    <td className="px-6 py-4">
                      <StatusBadge status={invoice.status} type="invoice" />
                    </td>
                    <td className="px-6 py-4 text-right">
                       <button className="p-2 text-slate-400 hover:text-teal-600 transition-colors" title="Download PDF">
                         <Download className="w-4 h-4" />
                       </button>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export default Invoices;