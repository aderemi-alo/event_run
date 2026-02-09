import React from 'react';
import { NavLink, useLocation, useNavigate } from 'react-router-dom';
import { LayoutDashboard, CalendarDays, Users, FileText, Package, Menu, Bell, Settings, Plus } from 'lucide-react';
import { useAuth } from '../context/AuthContext';

interface LayoutProps {
  children: React.ReactNode;
}

const Layout: React.FC<LayoutProps> = ({ children }) => {
  const location = useLocation();
  const navigate = useNavigate();
  const { user } = useAuth();

  const navItems = [
    { name: 'Home', path: '/', icon: LayoutDashboard },
    { name: 'Events', path: '/events', icon: CalendarDays },
    { name: 'Clients', path: '/clients', icon: Users },
    { name: 'Invoices', path: '/invoices', icon: FileText },
    { name: 'Inventory', path: '/inventory', icon: Package },
  ];

  // If no user (should be handled by protected route, but safe guard for layout rendering)
  if (!user) return <>{children}</>;

  const initials = user.fullName
    ? user.fullName.split(' ').map(n => n[0]).join('').toUpperCase().slice(0, 2)
    : 'OA';

  return (
    <div className="min-h-screen bg-slate-50 flex flex-col md:flex-row">
      {/* Top Header - Mobile Only (mostly) */}
      <header className="bg-white border-b border-slate-200 h-16 fixed top-0 w-full z-20 flex items-center justify-between px-4 md:pl-72 shadow-sm">
        <div className="flex items-center md:hidden">
          <span className="text-xl font-bold text-teal-700 tracking-tight">EventRun</span>
        </div>
        
        {/* Desktop Title Context */}
        <div className="hidden md:block">
           <h1 className="text-lg font-semibold text-slate-800 capitalize">
             {location.pathname === '/' ? 'Dashboard' : location.pathname.substring(1)}
           </h1>
        </div>

        <div className="flex items-center space-x-4">
          <button className="relative p-2 text-slate-500 hover:bg-slate-100 rounded-full transition-colors">
            <Bell className="w-5 h-5" />
            <span className="absolute top-1.5 right-1.5 w-2 h-2 bg-red-500 rounded-full border border-white"></span>
          </button>
          
          <button 
            onClick={() => navigate('/profile')} 
            className="p-2 text-slate-500 hover:bg-slate-100 rounded-full transition-colors md:hidden"
          >
            <Settings className="w-5 h-5" />
          </button>

          {/* Desktop User Profile Link */}
          <div 
            onClick={() => navigate('/profile')}
            className="hidden md:flex items-center space-x-2 cursor-pointer hover:bg-slate-50 p-1 rounded-lg transition-colors"
          >
            <div className="w-8 h-8 rounded-full bg-teal-100 text-teal-700 flex items-center justify-center font-bold text-sm">
              {initials}
            </div>
            <span className="text-sm font-medium text-slate-700">{user.fullName}</span>
          </div>
        </div>
      </header>

      {/* Desktop Sidebar */}
      <aside className="hidden md:flex flex-col w-64 h-full fixed left-0 top-0 bg-white border-r border-slate-200 z-30">
        <div className="h-16 flex items-center px-6 border-b border-slate-200">
          <span className="text-2xl font-bold text-teal-700 tracking-tight">EventRun</span>
        </div>
        
        <div className="flex-1 py-6 overflow-y-auto">
          <div className="px-4 mb-6">
            <button className="w-full bg-teal-600 hover:bg-teal-700 text-white font-medium py-2.5 px-4 rounded-lg flex items-center justify-center transition-colors shadow-sm">
              <Plus className="w-4 h-4 mr-2" />
              Create New
            </button>
          </div>

          <nav className="space-y-1 px-3">
            {navItems.map((item) => (
              <NavLink
                key={item.name}
                to={item.path}
                className={({ isActive }) =>
                  `flex items-center px-3 py-2.5 rounded-lg text-sm font-medium transition-colors ${
                    isActive
                      ? 'bg-teal-50 text-teal-700'
                      : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900'
                  }`
                }
              >
                <item.icon className={`w-5 h-5 mr-3`} />
                {item.name}
              </NavLink>
            ))}
          </nav>
        </div>

        <div className="p-4 border-t border-slate-200">
          <button 
            onClick={() => navigate('/profile')}
            className="flex items-center w-full px-3 py-2 text-sm font-medium text-slate-600 hover:text-slate-900 transition-colors"
          >
            <Settings className="w-5 h-5 mr-3" />
            Settings
          </button>
        </div>
      </aside>

      {/* Main Content Area */}
      <main className="flex-1 pt-20 pb-24 md:pb-10 md:pl-64 px-4 md:px-8 max-w-7xl mx-auto w-full">
        {children}
      </main>

      {/* Mobile Bottom Navigation */}
      <nav className="md:hidden fixed bottom-0 left-0 w-full bg-white border-t border-slate-200 z-30 pb-safe">
        <div className="flex justify-around items-center h-16">
          {navItems.map((item) => (
            <NavLink
              key={item.name}
              to={item.path}
              className={({ isActive }) =>
                `flex flex-col items-center justify-center w-full h-full space-y-1 ${
                  isActive ? 'text-teal-600' : 'text-slate-500'
                }`
              }
            >
              <item.icon className={`w-6 h-6 ${item.name === 'Inventory' ? 'hidden' : ''} `} /> 
              {/* Hide Inventory on mobile nav to save space, maybe put under 'More' in real app */}
               {item.name === 'Inventory' && <Package className="w-6 h-6"/>}
              <span className="text-[10px] font-medium">{item.name}</span>
            </NavLink>
          ))}
        </div>
      </nav>
    </div>
  );
};

export default Layout;