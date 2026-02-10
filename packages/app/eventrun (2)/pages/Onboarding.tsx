import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { CalendarX, FileText, LayoutDashboard, ArrowRight, Check } from 'lucide-react';
import { useAuth } from '../context/AuthContext';

const Onboarding: React.FC = () => {
  const [step, setStep] = useState(0);
  const navigate = useNavigate();
  const { completeOnboarding } = useAuth();

  const steps = [
    {
      title: "Prevent Double Bookings",
      description: "Never lose money or reputation again. See exactly when your equipment is available.",
      icon: CalendarX,
      color: "bg-red-100 text-red-600"
    },
    {
      title: "Professional Invoices",
      description: "Send beautiful invoices in 2 minutes. Get paid faster and look more professional.",
      icon: FileText,
      color: "bg-blue-100 text-blue-600"
    },
    {
      title: "Run Your Business",
      description: "Manage clients, track revenue, and organize events from anywhere on your phone.",
      icon: LayoutDashboard,
      color: "bg-teal-100 text-teal-600"
    }
  ];

  const handleNext = () => {
    if (step < steps.length - 1) {
      setStep(step + 1);
    } else {
      handleFinish();
    }
  };

  const handleFinish = () => {
    completeOnboarding();
    navigate('/signup');
  };

  const CurrentIcon = steps[step].icon;

  return (
    <div className="min-h-screen bg-white flex flex-col justify-between p-6 max-w-md mx-auto">
      <div className="flex justify-end pt-4">
        <button 
          onClick={handleFinish} 
          className="text-slate-500 font-medium text-sm px-4 py-2"
        >
          Skip
        </button>
      </div>

      <div className="flex-1 flex flex-col items-center justify-center text-center space-y-8 mt-[-40px]">
        <div className={`w-32 h-32 rounded-3xl flex items-center justify-center ${steps[step].color} mb-4 transition-all duration-500 ease-in-out`}>
          <CurrentIcon className="w-16 h-16" />
        </div>
        
        <div className="space-y-4 max-w-xs mx-auto">
          <h1 className="text-2xl font-bold text-slate-900 transition-opacity duration-300">
            {steps[step].title}
          </h1>
          <p className="text-slate-500 leading-relaxed transition-opacity duration-300">
            {steps[step].description}
          </p>
        </div>

        {/* Dots indicator */}
        <div className="flex space-x-2 pt-4">
          {steps.map((_, i) => (
            <div 
              key={i} 
              className={`h-2 rounded-full transition-all duration-300 ${i === step ? 'w-8 bg-teal-600' : 'w-2 bg-slate-200'}`} 
            />
          ))}
        </div>
      </div>

      <div className="pb-8">
        <button 
          onClick={handleNext}
          className="w-full bg-teal-600 hover:bg-teal-700 text-white font-bold py-4 px-6 rounded-xl shadow-lg shadow-teal-600/20 flex items-center justify-center transition-transform active:scale-[0.98]"
        >
          {step === steps.length - 1 ? (
            <>
              Get Started
              <Check className="w-5 h-5 ml-2" />
            </>
          ) : (
            <>
              Next
              <ArrowRight className="w-5 h-5 ml-2" />
            </>
          )}
        </button>
      </div>
    </div>
  );
};

export default Onboarding;