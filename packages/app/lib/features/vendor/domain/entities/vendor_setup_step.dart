enum VendorSetupStep {
  businessInfo,
  bankInfo,
  planSelection;

  double get progress => (index + 1) / VendorSetupStep.values.length;
}
