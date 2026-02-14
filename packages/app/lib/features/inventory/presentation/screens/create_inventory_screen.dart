import 'dart:io';
import 'package:app/core/utils/utils.dart';
import 'package:app/features/inventory/presentation/providers/inventory_providers_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/inventory/domain/entities/create_inventory_item_params.dart';
import 'package:app/features/inventory/presentation/providers/inventory_state.dart';
import 'package:app/features/inventory/presentation/widgets/inventory_image_picker.dart';
import 'package:app/features/inventory/presentation/widgets/category_selector.dart';
import 'package:go_router/go_router.dart';

class CreateInventoryScreen extends ConsumerStatefulWidget {
  const CreateInventoryScreen({super.key});

  @override
  ConsumerState<CreateInventoryScreen> createState() =>
      _CreateInventoryScreenState();
}

class _CreateInventoryScreenState extends ConsumerState<CreateInventoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _notesController = TextEditingController();

  String _category = 'Audio'; // default or first from fetched categories
  File? _imageFile;

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final params = CreateInventoryItemParams(
      name: _nameController.text.trim(),
      quantity: int.tryParse(_quantityController.text) ?? 1,
      category: _category,
      description: _notesController.text.trim(),
    );

    ref.read(inventoryNotifierProvider.notifier).createItem(params);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(inventoryNotifierProvider);

    // Listen for action result
    ref.listen<InventoryState>(inventoryNotifierProvider, (prev, next) {
      if (next.actionState == ActionState.success) {
        ref.read(inventoryNotifierProvider.notifier).resetAction();
        if (context.mounted) context.pop();
      } else if (next.actionState == ActionState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.actionError ?? 'Something went wrong')),
        );
        ref.read(inventoryNotifierProvider.notifier).resetAction();
      }
    });

    final isLoading = state.actionState == ActionState.loading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Inventory'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image picker
              InventoryImagePicker(
                imageFile: _imageFile,
                onImagePicked: (file) => setState(() => _imageFile = file),
              ),
              const SizedBox(height: 24),

              // Item name
              _buildLabel('Item Name'),
              const SizedBox(height: 6),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'e.g. JBL PartyBox 1000',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Item name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Quantity and Category row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quantity
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Quantity Owned'),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _quantityController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                          validator: (value) {
                            final qty = int.tryParse(value ?? '');
                            if (qty == null || qty < 1) {
                              return 'Enter a valid quantity';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Category
                  Expanded(
                    child: CategorySelector(
                      categories: state.categories,
                      selectedCategory: _category,
                      onCategoryChanged: (cat) {
                        setState(() => _category = cat);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Notes
              _buildLabel('Notes', optional: true),
              const SizedBox(height: 6),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Condition, serial numbers, or other details...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Submit button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton.icon(
                  onPressed: isLoading ? null : _handleSubmit,
                  icon: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.save),
                  label: Text(isLoading ? 'Saving...' : 'Save Item'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, {bool optional = false}) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        if (optional)
          Text(
            '  (Optional)',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade400,
            ),
          ),
      ],
    );
  }
}
