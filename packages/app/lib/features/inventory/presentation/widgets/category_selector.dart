import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  final List<String> categories;
  final String? selectedCategory;
  final ValueChanged<String> onCategoryChanged;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  bool _isCustom = false;
  late TextEditingController _customController;

  @override
  void initState() {
    super.initState();
    _customController = TextEditingController();

    // If the current category isn't in the list, show custom input
    if (widget.selectedCategory != null &&
        widget.selectedCategory!.isNotEmpty &&
        !widget.categories.contains(widget.selectedCategory)) {
      _isCustom = true;
      _customController.text = widget.selectedCategory!;
    }
  }

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Category',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            if (_isCustom) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _switchToDropdown,
                child: Text(
                  'Select existing',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 6),
        _isCustom ? _buildCustomInput() : _buildDropdown(),
      ],
    );
  }

  Widget _buildDropdown() {
    // Ensure selected value is valid for the dropdown
    final effectiveValue = widget.categories.contains(widget.selectedCategory)
        ? widget.selectedCategory
        : widget.categories.firstOrNull;

    return DropdownButtonFormField<String>(
      initialValue: effectiveValue,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      items: [
        ...widget.categories.map(
          (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
        ),
        DropdownMenuItem(
          value: '__NEW__',
          child: Row(
            children: [
              Icon(
                Icons.add,
                size: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 6),
              Text(
                'Create New Category',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ],
      onChanged: (value) {
        if (value == '__NEW__') {
          setState(() {
            _isCustom = true;
            _customController.clear();
          });
        } else if (value != null) {
          widget.onCategoryChanged(value);
        }
      },
    );
  }

  Widget _buildCustomInput() {
    return TextFormField(
      controller: _customController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Type new category name...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      ),
      onChanged: widget.onCategoryChanged,
    );
  }

  void _switchToDropdown() {
    final fallback = widget.categories.firstOrNull ?? '';
    setState(() {
      _isCustom = false;
    });
    widget.onCategoryChanged(fallback);
  }
}
