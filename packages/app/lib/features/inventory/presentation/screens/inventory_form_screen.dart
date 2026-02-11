import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app/core/utils/validators.dart';
import 'package:app/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:app/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:app/features/inventory/presentation/providers/inventory_providers.dart';

class InventoryFormScreen extends ConsumerStatefulWidget {
  const InventoryFormScreen({super.key, this.itemId});

  final String? itemId;

  @override
  ConsumerState<InventoryFormScreen> createState() =>
      _InventoryFormScreenState();
}

class _InventoryFormScreenState extends ConsumerState<InventoryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _categoryController = TextEditingController();
  final _notesController = TextEditingController();
  bool _loading = false;

  bool get _isEditing => widget.itemId != null;

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _categoryController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    try {
      final item = InventoryItemEntity(
        id: widget.itemId ?? '',
        vendorId: '',
        name: _nameController.text.trim(),
        quantity: int.parse(_quantityController.text.trim()),
        category: _categoryController.text.trim().isNotEmpty
            ? _categoryController.text.trim()
            : null,
        notes: _notesController.text.trim().isNotEmpty
            ? _notesController.text.trim()
            : null,
        createdAt: DateTime.now(),
      );

      if (_isEditing) {
        await ref.read(updateItemUsecaseProvider).call(item: item);
      } else {
        await ref.read(createItemUsecaseProvider).call(item: item);
      }

      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Item' : 'New Item'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthFormField(
                label: 'Item Name',
                hint: 'Sound System',
                controller: _nameController,
                prefixIcon: Icons.inventory_2_outlined,
                textInputAction: TextInputAction.next,
                validator: (v) => Validators.validateRequired(
                  context,
                  v,
                  fieldName: 'Item name',
                ),
              ),
              const SizedBox(height: 16),
              AuthFormField(
                label: 'Quantity',
                hint: '1',
                controller: _quantityController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.numbers,
                textInputAction: TextInputAction.next,
                validator: (v) => Validators.validatePositiveNumber(context, v),
              ),
              const SizedBox(height: 16),
              AuthFormField(
                label: 'Category',
                hint: 'Audio Equipment',
                controller: _categoryController,
                prefixIcon: Icons.category_outlined,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              AuthFormField(
                label: 'Notes',
                hint: 'Additional details',
                controller: _notesController,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _loading ? null : _submit,
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(_isEditing ? 'Save Changes' : 'Add Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
