import React from 'react';
import { useAuth } from '../context/AuthContext';
import { User, Building2, Phone, Mail, LogOut, ChevronRight, Bell, Shield, HelpCircle } from 'lucide-react';

const Profile: React.FC = () => {
  const { user, logout } = useAuth();

  if (!user) return null;

  const initials = user.fullName
    .split(' ')
    .map(n => n[0])
    .join('')
    .toUpperCase()
    .slice(0, 2);

  return (
    <div className="space-y-6 max-w-2xl mx-auto">
      <div>
        <h2 className="text-2xl font-bold text-slate-900">Profile & Settings</h2>
        <p className="text-slate-500 text-sm">Manage your account and business preferences.</p>
      </div>

      {/* Header Card */}
      <div className="bg-white rounded-xl border border-slate-200 shadow-sm p-6 flex flex-col sm:flex-row items-center sm:items-start text-center sm:text-left gap-6">
        <div className="w-24 h-24 rounded-full bg-teal-100 text-teal-700 flex items-center justify-center text-2xl font-bold border-4 border-white shadow-sm">
          {initials}
        </div>
        <div className="flex-1 pt-2">
          <h3 className="text-xl font-bold text-slate-900">{user.businessName}</h3>
          <p className="text-slate-600 font-medium">{user.fullName}</p>
          <div className="flex flex-col sm:flex-row gap-2 sm:gap-4 mt-2 text-sm text-slate-500 justify-center sm:justify-start">
             <span className="flex items-center justify-center sm:justify-start">
               <Mail className="w-3.5 h-3.5 mr-1.5" />
               {user.email}
             </span>
             <span className="flex items-center justify-center sm:justify-start">
               <Phone className="w-3.5 h-3.5 mr-1.5" />
               {user.phone}
             </span>
          </div>
          <button className="mt-4 text-sm font-medium text-teal-600 hover:text-teal-700 border border-teal-200 hover:border-teal-300 rounded-lg px-4 py-1.5 transition-colors">
            Edit Profile
          </button>
        </div>
      </div>

      {/* Settings Sections */}
      <div className="space-y-4">
        
        {/* Account Settings */}
        <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
          <div className="px-4 py-3 bg-slate-50 border-b border-slate-100 font-medium text-slate-900 text-sm">
            Account Settings
          </div>
          <div className="divide-y divide-slate-100">
            <button className="w-full px-4 py-4 flex items-center justify-between hover:bg-slate-50 transition-colors">
              <div className="flex items-center">
                <div className="w-8 h-8 rounded-lg bg-blue-50 text-blue-600 flex items-center justify-center mr-3">
                  <User className="w-4 h-4" />
                </div>
                <span className="text-slate-700 font-medium text-sm">Personal Information</span>
              </div>
              <ChevronRight className="w-4 h-4 text-slate-400" />
            </button>
            <button className="w-full px-4 py-4 flex items-center justify-between hover:bg-slate-50 transition-colors">
              <div className="flex items-center">
                <div className="w-8 h-8 rounded-lg bg-purple-50 text-purple-600 flex items-center justify-center mr-3">
                  <Building2 className="w-4 h-4" />
                </div>
                <span className="text-slate-700 font-medium text-sm">Business Details</span>
              </div>
              <ChevronRight className="w-4 h-4 text-slate-400" />
            </button>
             <button className="w-full px-4 py-4 flex items-center justify-between hover:bg-slate-50 transition-colors">
              <div className="flex items-center">
                <div className="w-8 h-8 rounded-lg bg-amber-50 text-amber-600 flex items-center justify-center mr-3">
                  <Bell className="w-4 h-4" />
                </div>
                <span className="text-slate-700 font-medium text-sm">Notifications</span>
              </div>
              <ChevronRight className="w-4 h-4 text-slate-400" />
            </button>
          </div>
        </div>

        {/* Support & Security */}
        <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
           <div className="px-4 py-3 bg-slate-50 border-b border-slate-100 font-medium text-slate-900 text-sm">
            Support
          </div>
          <div className="divide-y divide-slate-100">
            <button className="w-full px-4 py-4 flex items-center justify-between hover:bg-slate-50 transition-colors">
              <div className="flex items-center">
                <div className="w-8 h-8 rounded-lg bg-green-50 text-green-600 flex items-center justify-center mr-3">
                  <HelpCircle className="w-4 h-4" />
                </div>
                <span className="text-slate-700 font-medium text-sm">Help & FAQ</span>
              </div>
              <ChevronRight className="w-4 h-4 text-slate-400" />
            </button>
             <button className="w-full px-4 py-4 flex items-center justify-between hover:bg-slate-50 transition-colors">
              <div className="flex items-center">
                <div className="w-8 h-8 rounded-lg bg-slate-100 text-slate-600 flex items-center justify-center mr-3">
                  <Shield className="w-4 h-4" />
                </div>
                <span className="text-slate-700 font-medium text-sm">Privacy & Security</span>
              </div>
              <ChevronRight className="w-4 h-4 text-slate-400" />
            </button>
          </div>
        </div>
      </div>

      <button 
        onClick={logout}
        className="w-full bg-red-50 hover:bg-red-100 text-red-600 font-medium py-3 px-4 rounded-xl border border-red-100 flex items-center justify-center transition-colors mt-6"
      >
        <LogOut className="w-5 h-5 mr-2" />
        Log Out
      </button>
      
      <div className="text-center text-xs text-slate-400 pb-8">
        Version 1.0.0
      </div>
    </div>
  );
};

export default Profile;