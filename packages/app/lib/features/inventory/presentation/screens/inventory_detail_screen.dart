import 'dart:io';
import 'package:app/core/utils/utils.dart';
import 'package:app/features/inventory/presentation/providers/inventory_providers_di.dart';
import 'package:app/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:app/features/inventory/domain/entities/update_inventory_item_params.dart';
import 'package:app/features/inventory/presentation/providers/inventory_state.dart';
import 'package:app/features/inventory/presentation/widgets/inventory_image_picker.dart';
import 'package:app/features/inventory/presentation/widgets/category_selector.dart';

class InventoryDetailScreen extends ConsumerStatefulWidget {
  final String itemId;
  final bool startInEditMode;

  const InventoryDetailScreen({
    super.key,
    required this.itemId,
    this.startInEditMode = false,
  });

  @override
  ConsumerState<InventoryDetailScreen> createState() =>
      _InventoryDetailScreenState();
}

class _InventoryDetailScreenState extends ConsumerState<InventoryDetailScreen> {
  late bool _isEditing;

  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();
  late String _category;
  File? _imageFile;
  bool _formInitialized = false;
  bool _fetchAttempted = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.startInEditMode;
  }

  void _initFormData(InventoryItemEntity item) {
    if (_formInitialized) return;
    _nameController.text = item.name;
    _quantityController.text = item.quantity.toString();
    _descriptionController.text = item.description ?? '';
    _category = item.category ?? '';
    _formInitialized = true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;

    final params = UpdateInventoryItemParams(
      id: widget.itemId,
      name: _nameController.text.trim(),
      quantity: int.tryParse(_quantityController.text) ?? 1,
      category: _category,
      description: _descriptionController.text.trim(),
    );

    ref.read(inventoryNotifierProvider.notifier).updateItem(params);
  }

  void _cancelEditing(InventoryItemEntity item) {
    setState(() {
      _isEditing = false;
      _nameController.text = item.name;
      _quantityController.text = item.quantity.toString();
      _descriptionController.text = item.description ?? '';
      _category = item.category ?? '';
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(inventoryNotifierProvider);

    final item = ref.watch(
      inventoryNotifierProvider.select(
        (state) => state.inventoryItems
            .where((i) => i.id == widget.itemId)
            .firstOrNull,
      ),
    );

    if (item == null) {
      if (!_fetchAttempted) {
        _fetchAttempted = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref
              .read(inventoryNotifierProvider.notifier)
              .getItemById(widget.itemId);
        });
      }
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    _initFormData(item);

    ref.listen<InventoryState>(inventoryNotifierProvider, (prev, next) {
      if (next.actionState == ActionState.success) {
        ref.read(inventoryNotifierProvider.notifier).resetAction();
        if (_isEditing) {
          setState(() => _isEditing = false);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Item updated')));
        }
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
        title: Text(_isEditing ? 'Edit Item' : 'Item Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => setState(() => _isEditing = true),
            ),
        ],
      ),
      body: _isEditing
          ? _EditModeBody(
              formKey: _formKey,
              nameController: _nameController,
              quantityController: _quantityController,
              descriptionController: _descriptionController,
              category: _category,
              categories: state.categories,
              imageFile: _imageFile,
              imageUrl: item.imageUrl,
              isLoading: isLoading,
              onCategoryChanged: (cat) => setState(() => _category = cat),
              onImagePicked: (file) => setState(() => _imageFile = file),
              onSave: _handleSave,
              onCancel: () => _cancelEditing(item),
            )
          : _ViewModeBody(item: item),
    );
  }
}

// ──────────────────────────────────────────────
// VIEW MODE
// ──────────────────────────────────────────────

class _ViewModeBody extends StatelessWidget {
  final InventoryItemEntity item;

  const _ViewModeBody({required this.item});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero image
          _ItemHeroImage(imageUrl: item.imageUrl, category: item.category),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and quantity
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _QuantityBadge(quantity: item.quantity),
                  ],
                ),
                const SizedBox(height: 24),

                // Notes section
                Text(
                  'DESCRIPTION / NOTES',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  (item.description != null && item.description!.isNotEmpty)
                      ? item.description!
                      : 'No notes available for this item.',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color:
                        (item.description != null &&
                            item.description!.isNotEmpty)
                        ? Colors.grey.shade700
                        : Colors.grey.shade400,
                    fontStyle:
                        (item.description != null &&
                            item.description!.isNotEmpty)
                        ? FontStyle.normal
                        : FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 24),

                // Metadata
                const Divider(),
                const SizedBox(height: 12),
                _MetadataRow(label: 'Item ID', value: item.id),
                const SizedBox(height: 8),
                _MetadataRow(label: 'Category', value: item.category ?? '-'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemHeroImage extends StatelessWidget {
  final String? imageUrl;
  final String? category;

  const _ItemHeroImage({this.imageUrl, this.category});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (imageUrl != null && imageUrl!.isNotEmpty)
            Image.network(imageUrl!, fit: BoxFit.cover)
          else
            Container(
              color: Colors.grey.shade100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 56,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No image provided',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
          if (category != null && category!.isNotEmpty)
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  category!.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _QuantityBadge extends StatelessWidget {
  final int quantity;

  const _QuantityBadge({required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(
            quantity.toString(),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            'IN STOCK',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade500,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetadataRow extends StatelessWidget {
  final String label;
  final String value;

  const _MetadataRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────
// EDIT MODE
// ──────────────────────────────────────────────

class _EditModeBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController quantityController;
  final TextEditingController descriptionController;
  final String category;
  final List<String> categories;
  final File? imageFile;
  final String? imageUrl;
  final bool isLoading;
  final ValueChanged<String> onCategoryChanged;
  final ValueChanged<File> onImagePicked;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const _EditModeBody({
    required this.formKey,
    required this.nameController,
    required this.quantityController,
    required this.descriptionController,
    required this.category,
    required this.categories,
    required this.imageFile,
    required this.imageUrl,
    required this.isLoading,
    required this.onCategoryChanged,
    required this.onImagePicked,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InventoryImagePicker(
              imageFile: imageFile,
              imageUrl: imageUrl,
              onImagePicked: onImagePicked,
            ),
            const SizedBox(height: 24),

            // Item name
            const Text(
              'Item Name',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: nameController,
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quantity Owned',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: quantityController,
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
                          if (qty == null || qty < 0) {
                            return 'Enter a valid quantity';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CategorySelector(
                    categories: categories,
                    selectedCategory: category,
                    onCategoryChanged: onCategoryChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Notes
            const Text(
              'Notes',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
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

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton.outlined(label: 'Cancel', onPressed: onCancel),
                const SizedBox(width: 12),
                AppButton(
                  leading: Icons.save,
                  label: 'Save Changes',
                  onPressed: onSave,
                  loading: isLoading,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
