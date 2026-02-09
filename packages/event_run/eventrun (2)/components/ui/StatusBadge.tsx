import React from 'react';
import { EventStatus, InvoiceStatus } from '../../types';
import { CheckCircle2, AlertTriangle, XCircle, Clock, FileText, Send, DollarSign } from 'lucide-react';

interface Props {
  status: EventStatus | InvoiceStatus;
  type: 'event' | 'invoice';
}

export const StatusBadge: React.FC<Props> = ({ status, type }) => {
  if (type === 'event') {
    switch (status) {
      case 'COVERED':
        return (
          <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
            <CheckCircle2 className="w-3 h-3 mr-1" />
            Covered
          </span>
        );
      case 'ATTENTION':
        return (
          <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-amber-100 text-amber-800">
            <AlertTriangle className="w-3 h-3 mr-1" />
            Needs Attention
          </span>
        );
      case 'CONFLICT':
        return (
          <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
            <XCircle className="w-3 h-3 mr-1" />
            Conflict
          </span>
        );
      default:
        return null;
    }
  }

  // Invoice statuses
  switch (status) {
    case 'DRAFT':
      return (
        <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-slate-100 text-slate-800 border border-slate-200">
          <FileText className="w-3 h-3 mr-1" />
          Draft
        </span>
      );
    case 'SENT':
      return (
        <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
          <Send className="w-3 h-3 mr-1" />
          Sent
        </span>
      );
    case 'PAID':
      return (
        <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-teal-100 text-teal-800">
          <CheckCircle2 className="w-3 h-3 mr-1" />
          Paid
        </span>
      );
    case 'OVERDUE':
      return (
        <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
          <Clock className="w-3 h-3 mr-1" />
          Overdue
        </span>
      );
    default:
      return null;
  }
};