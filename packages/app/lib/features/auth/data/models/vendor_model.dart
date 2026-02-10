import 'package:json_annotation/json_annotation.dart';
import 'package:event_run/features/auth/domain/entities/vendor.dart';

part 'vendor_model.g.dart';

/// Vendor model for JSON serialization
@JsonSerializable()
class VendorModel extends Vendor {
  const VendorModel({
    required super.id,
    required super.businessName,
    required super.fullName,
    required super.email,
    required super.phone,
  });

  /// From JSON
  factory VendorModel.fromJson(Map<String, dynamic> json) =>
      _$VendorModelFromJson(json);

  /// To JSON
  Map<String, dynamic> toJson() => _$VendorModelToJson(this);

  /// From entity
  factory VendorModel.fromEntity(Vendor vendor) {
    return VendorModel(
      id: vendor.id,
      businessName: vendor.businessName,
      fullName: vendor.fullName,
      email: vendor.email,
      phone: vendor.phone,
    );
  }
}
