import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:event_run/core/constants/supabase_constants.dart';
import 'package:event_run/core/error/exceptions.dart';
import 'package:event_run/features/vendor/data/models/vendor_model.dart';

abstract class VendorRemoteDatasource {
  Future<VendorModel?> getVendorByOwner(String ownerId);
  Future<VendorModel> createVendor({required VendorModel vendor});
  Future<VendorModel> updateVendor({required VendorModel vendor});
  Future<void> updateBankDetails({
    required String vendorId,
    required String bankName,
    required String accountName,
    required String accountNumber,
  });
  Future<String> uploadLogo({
    required String vendorId,
    required String filePath,
  });
}

class VendorRemoteDatasourceImpl implements VendorRemoteDatasource {
  final SupabaseClient _client;

  VendorRemoteDatasourceImpl(this._client);

  @override
  Future<VendorModel?> getVendorByOwner(String ownerId) async {
    try {
      final response = await _client
          .from(SupabaseConstants.vendors)
          .select()
          .eq('owner_id', ownerId)
          .maybeSingle();

      if (response == null) return null;
      return VendorModel.fromJson(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<VendorModel> createVendor({required VendorModel vendor}) async {
    try {
      final response = await _client
          .from(SupabaseConstants.vendors)
          .insert(vendor.toJson())
          .select()
          .single();

      return VendorModel.fromJson(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<VendorModel> updateVendor({required VendorModel vendor}) async {
    try {
      final response = await _client
          .from(SupabaseConstants.vendors)
          .update(vendor.toJson())
          .eq('id', vendor.id)
          .select()
          .single();

      return VendorModel.fromJson(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> updateBankDetails({
    required String vendorId,
    required String bankName,
    required String accountName,
    required String accountNumber,
  }) async {
    try {
      await _client.from(SupabaseConstants.vendors).update({
        'bank_name': bankName,
        'account_name': accountName,
        'account_number': accountNumber,
      }).eq('id', vendorId);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadLogo({
    required String vendorId,
    required String filePath,
  }) async {
    try {
      final file = File(filePath);
      final ext = filePath.split('.').last;
      final path = '$vendorId/logo.$ext';

      await _client.storage
          .from(SupabaseConstants.vendorLogosBucket)
          .upload(path, file, fileOptions: const FileOptions(upsert: true));

      final url = _client.storage
          .from(SupabaseConstants.vendorLogosBucket)
          .getPublicUrl(path);

      await _client
          .from(SupabaseConstants.vendors)
          .update({'logo_url': url}).eq('id', vendorId);

      return url;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
