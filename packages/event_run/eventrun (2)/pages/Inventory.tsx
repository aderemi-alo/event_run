import React from 'react';
import { Package, Plus, Search, Edit2 } from 'lucide-react';
import { INVENTORY } from '../constants';

const Inventory: React.FC = () => {
  return (
    <div className="space-y-6">
       <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
        <div>
          <h2 className="text-2xl font-bold text-slate-900">Inventory</h2>
          <p className="text-slate-500 text-sm">Track your equipment and avoid shortages.</p>
        </div>
        <button className="bg-slate-900 hover:bg-slate-800 text-white font-medium py-2 px-4 rounded-lg flex items-center shadow-sm w-full sm:w-auto justify-center">
          <Plus className="w-4 h-4 mr-2" />
          Add Item
        </button>
      </div>

      <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
        <div className="p-4 border-b border-slate-200 flex flex-col sm:flex-row gap-4 items-center justify-between">
           <div className="relative w-full sm:w-96">
            <Search className="absolute left-3 top-2.5 h-5 w-5 text-slate-400" />
            <input
              type="text"
              placeholder="Search inventory..."
              className="w-full pl-10 pr-4 py-2 border border-slate-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-teal-500 focus:border-transparent"
            />
          </div>
          <div className="flex gap-2">
             <span className="text-xs font-medium bg-slate-100 text-slate-600 px-3 py-1.5 rounded-full">Total Items: {INVENTORY.reduce((acc, item) => acc + item.quantity, 0)}</span>
          </div>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left">
            <thead className="bg-slate-50 text-slate-500 text-xs uppercase font-semibold">
              <tr>
                <th className="px-6 py-4">Item Name</th>
                <th className="px-6 py-4">Category</th>
                <th className="px-6 py-4 text-center">Quantity Owned</th>
                <th className="px-6 py-4 text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100">
              {INVENTORY.map((item) => (
                <tr key={item.id} className="hover:bg-slate-50 transition-colors">
                  <td className="px-6 py-4">
                    <div className="flex items-center">
                      <div className="h-10 w-10 flex-shrink-0 rounded-lg bg-slate-100 flex items-center justify-center text-slate-400 mr-4">
                        {item.imageUrl ? (
                           <img src={item.imageUrl} alt={item.name} className="h-10 w-10 rounded-lg object-cover" />
                        ) : (
                           <Package className="w-5 h-5" />
                        )}
                      </div>
                      <div>
                        <div className="font-medium text-slate-900">{item.name}</div>
                        {item.quantity < 5 && <div className="text-xs text-red-500 font-medium">Low Stock</div>}
                      </div>
                    </div>
                  </td>
                  <td className="px-6 py-4">
                    <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-slate-100 text-slate-800">
                      {item.category}
                    </span>
                  </td>
                  <td className="px-6 py-4 text-center">
                    <span className="font-bold text-slate-900">{item.quantity}</span>
                  </td>
                  <td className="px-6 py-4 text-right">
                    <button className="text-slate-400 hover:text-teal-600 transition-colors">
                      <Edit2 className="w-4 h-4" />
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export default Inventory;