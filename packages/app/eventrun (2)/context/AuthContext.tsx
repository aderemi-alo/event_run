import React, { createContext, useContext, useState, useEffect } from 'react';
import { Vendor } from '../types';

interface AuthContextType {
  user: Vendor | null;
  isAuthenticated: boolean;
  hasCompletedOnboarding: boolean;
  completeOnboarding: () => void;
  login: (email: string) => void;
  signup: (data: Vendor) => void;
  logout: () => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<Vendor | null>(null);
  const [hasCompletedOnboarding, setHasCompletedOnboarding] = useState(false);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Check local storage on load
    const storedUser = localStorage.getItem('eventrun_user');
    const storedOnboarding = localStorage.getItem('eventrun_onboarding_complete');
    
    if (storedUser) {
      setUser(JSON.parse(storedUser));
    }
    
    if (storedOnboarding === 'true') {
      setHasCompletedOnboarding(true);
    }
    
    setLoading(false);
  }, []);

  const completeOnboarding = () => {
    setHasCompletedOnboarding(true);
    localStorage.setItem('eventrun_onboarding_complete', 'true');
  };

  const login = (email: string) => {
    // Mock login - in a real app this would call an API
    const mockUser: Vendor = {
      id: '1',
      businessName: 'Ola Events Solutions',
      fullName: 'Ola Adesina',
      email: email,
      phone: '+234 803 555 0123'
    };
    
    // Simulate delay
    setTimeout(() => {
      setUser(mockUser);
      localStorage.setItem('eventrun_user', JSON.stringify(mockUser));
    }, 500);
  };

  const signup = (data: Vendor) => {
    // Simulate delay
    setTimeout(() => {
      setUser(data);
      localStorage.setItem('eventrun_user', JSON.stringify(data));
      completeOnboarding(); // Ensure onboarding is marked complete on signup
    }, 500);
  };

  const logout = () => {
    setUser(null);
    localStorage.removeItem('eventrun_user');
  };

  if (loading) {
    return null; // Or a loading spinner
  }

  return (
    <AuthContext.Provider value={{ 
      user, 
      isAuthenticated: !!user, 
      hasCompletedOnboarding,
      completeOnboarding,
      login, 
      signup, 
      logout 
    }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) throw new Error('useAuth must be used within an AuthProvider');
  return context;
};