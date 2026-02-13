import 'package:app/core/error/exceptions.dart';
import 'package:app/core/error/failures.dart';
import 'package:app/core/utils/result.dart';
import 'package:app/features/vendor/data/datasources/vendor_remote_datasource.dart';
import 'package:app/features/vendor/domain/entities/create_vendor_params.dart';
import 'package:app/features/vendor/domain/entities/update_vendor_params.dart';
import 'package:app/features/vendor/domain/entities/vendor_entity.dart';
import 'package:app/features/vendor/domain/repositories/vendor_repository.dart';

class VendorRepositoryImpl implements VendorRepository {
  final VendorRemoteDatasource _datasource;

  VendorRepositoryImpl(this._datasource);

  @override
  Future<Result<VendorEntity?>> getVendorByOwner(String ownerId) async {
    try {
      final vendorModel = await _datasource.getVendorByOwner(ownerId);
      return Success(vendorModel);
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Result<VendorEntity?>> getVendorById(String vendorId) async {
    try {
      final vendorModel = await _datasource.getVendorById(vendorId);
      return Success(vendorModel);
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Result<VendorEntity>> createVendor({
    required CreateVendorParams params,
  }) async {
    try {
      final vendorModel = await _datasource.createVendor(params: params);
      return Success(vendorModel);
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Result<VendorEntity>> updateVendor({
    required UpdateVendorParams params,
  }) async {
    try {
      final vendorModel = await _datasource.updateVendor(params: params);
      return Success(vendorModel);
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Result<void>> deleteVendor(String vendorId) async {
    try {
      await _datasource.deleteVendor(vendorId);
      return const Success(null);
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<void> updateBankDetails({
    required String vendorId,
    required String bankName,
    required String accountName,
    required String accountNumber,
  }) {
    return _datasource.updateBankDetails(
      vendorId: vendorId,
      bankName: bankName,
      accountName: accountName,
      accountNumber: accountNumber,
    );
  }

  @override
  Future<void> uploadLogo({
    required String vendorId,
    required String filePath,
  }) {
    return _datasource.uploadLogo(vendorId: vendorId, filePath: filePath);
  }
}
