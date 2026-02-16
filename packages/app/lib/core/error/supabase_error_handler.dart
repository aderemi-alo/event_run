import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/core/error/failures.dart'; // Import your base Failure class

class SupabaseErrorHandler {
  static Failure map(Object error) {
    // 1. Handle Network/Connection Errors explicitly
    if (error is SocketException) {
      return const NetworkFailure();
    }

    // 2. Handle Database Errors (Postgrest)
    if (error is PostgrestException) {
      return _handlePostgrestError(error);
    }

    // 3. Handle Authentication Errors
    if (error is AuthException) {
      return _handleAuthError(error);
    }

    // 4. Fallback for unexpected errors
    return ServerFailure('An unexpected error occurred}');
  }

  static Failure _handlePostgrestError(PostgrestException error) {
    // Postgres Error Codes: https://www.postgresql.org/docs/current/errcodes-appendix.html
    switch (error.code) {
      case '23505': // unique_violation
        if (error.message.contains('email')) {
          return const ServerFailure('This email is already registered.');
        } else if (error.message.contains('phone')) {
          return const ServerFailure('This phone number is already in use.');
        } else {
          return const ServerFailure(
            'A record with these details already exists.',
          );
        }
      case '23503': // foreign_key_violation
        return const ServerFailure('Operation failed: Linked data is missing.');
      case '42501': // insufficient_privilege (RLS)
        return const ServerFailure(
          'You do not have permission to perform this action.',
        );
      case 'PGRST116': // data not found (Supabase specific)
        return const ServerFailure('The requested data could not be found.');
      default:
        return ServerFailure(error.message); // Fallback to Supabase's message
    }
  }

  static Failure _handleAuthError(AuthException error) {
    // Auth errors usually have descriptive messages, but we can sanitize them
    if (error.message.contains('Invalid login credentials')) {
      return const ServerFailure('Invalid email or password.');
    }
    if (error.message.contains('User not found')) {
      return const ServerFailure('No user found with these details.');
    }
    return ServerFailure(error.message);
  }
}
