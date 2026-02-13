import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:app/core/utils/currency_formatter.dart';
import 'package:app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:app/features/invoices/domain/entities/invoice_entity.dart';
import 'package:app/features/invoices/domain/entities/invoice_item_entity.dart';
import 'package:app/features/invoices/presentation/providers/invoice_providers.dart';

class InvoiceFormScreen extends ConsumerStatefulWidget {
  final String? invoiceId;

  const InvoiceFormScreen({super.key, this.invoiceId});

  @override
  ConsumerState<InvoiceFormScreen> createState() => _InvoiceFormScreenState();
}

class _InvoiceFormScreenState extends ConsumerState<InvoiceFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _clientIdController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime _dueDate = DateTime.now().add(const Duration(days: 30));
  final List<_ItemEntry> _items = [];
  bool _isLoading = false;
  String? _loadedInvoiceVendorId;

  bool get _isEditing => widget.invoiceId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _loadInvoice();
    } else {
      _addItem();
    }
  }

  Future<void> _loadInvoice() async {
    final invoice = await ref
        .read(getInvoiceByIdProvider)
        .call(widget.invoiceId!);
    if (invoice != null && mounted) {
      setState(() {
        _loadedInvoiceVendorId = invoice.vendorId;
        _clientIdController.text = invoice.clientId;
        _notesController.text = invoice.notes ?? '';
        _dueDate = invoice.dueDate;
        _items.clear();
        for (final item in invoice.items) {
          _items.add(
            _ItemEntry(
              descriptionController: TextEditingController(
                text: item.description,
              ),
              quantityController: TextEditingController(
                text: item.quantity.toString(),
              ),
              priceController: TextEditingController(
                text: item.unitPrice.toString(),
              ),
            ),
          );
        }
      });
    }
  }

  void _addItem() {
    setState(() {
      _items.add(
        _ItemEntry(
          descriptionController: TextEditingController(),
          quantityController: TextEditingController(text: '1'),
          priceController: TextEditingController(),
        ),
      );
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items[index].dispose();
      _items.removeAt(index);
    });
  }

  num get _totalAmount {
    num total = 0;
    for (final item in _items) {
      final qty = int.tryParse(item.quantityController.text) ?? 0;
      final price = num.tryParse(item.priceController.text) ?? 0;
      total += qty * price;
    }
    return total;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_items.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Add at least one item.')));
      return;
    }

    final vendorId = _isEditing
        ? _loadedInvoiceVendorId
        : ref.read(currentVendorIdProvider);
    if (vendorId == null || vendorId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complete business setup first.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      const uuid = Uuid();
      final invoiceId = _isEditing ? widget.invoiceId! : uuid.v4();

      final invoiceNumber = _isEditing
          ? '' // Will be ignored on update
          : await ref
                .read(invoiceRepositoryProvider)
                .generateInvoiceNumber(vendorId);

      final items = _items.map((entry) {
        return InvoiceItemEntity(
          id: uuid.v4(),
          invoiceId: invoiceId,
          description: entry.descriptionController.text.trim(),
          quantity: int.parse(entry.quantityController.text),
          unitPrice: num.parse(entry.priceController.text),
        );
      }).toList();

      final invoice = InvoiceEntity(
        id: invoiceId,
        vendorId: vendorId,
        clientId: _clientIdController.text.trim(),
        invoiceNumber: invoiceNumber,
        items: items,
        totalAmount: _totalAmount,
        dateIssued: DateTime.now(),
        dueDate: _dueDate,
        status: InvoiceStatus.draft,
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        createdAt: DateTime.now(),
      );

      if (_isEditing) {
        await ref.read(updateInvoiceProvider).call(invoice: invoice);
      } else {
        await ref.read(createInvoiceProvider).call(invoice: invoice);
      }

      ref.invalidate(invoicesProvider(vendorId));
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _selectDueDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) setState(() => _dueDate = date);
  }

  @override
  void dispose() {
    _clientIdController.dispose();
    _notesController.dispose();
    for (final item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? 'Edit Invoice' : 'New Invoice')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _clientIdController,
              decoration: const InputDecoration(
                labelText: 'Client ID',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),

            // Due date
            InkWell(
              onTap: _selectDueDate,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Due Date',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  '${_dueDate.day}/${_dueDate.month}/${_dueDate.year}',
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Items section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Items',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton.icon(
                  onPressed: _addItem,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Item'),
                ),
              ],
            ),
            const SizedBox(height: 8),

            ..._items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Item ${index + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (_items.length > 1)
                            IconButton(
                              icon: const Icon(Icons.close, size: 20),
                              onPressed: () => _removeItem(index),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: item.descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: item.quantityController,
                              decoration: const InputDecoration(
                                labelText: 'Qty',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (_) => setState(() {}),
                              validator: (v) {
                                if (v == null || v.isEmpty) return 'Required';
                                if (int.tryParse(v) == null) return 'Invalid';
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: item.priceController,
                              decoration: const InputDecoration(
                                labelText: 'Unit Price',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (_) => setState(() {}),
                              validator: (v) {
                                if (v == null || v.isEmpty) return 'Required';
                                if (num.tryParse(v) == null) return 'Invalid';
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Total: ${CurrencyFormatter.formatNaira(_totalAmount)}',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            FilledButton(
              onPressed: _isLoading ? null : _submit,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(_isEditing ? 'Update Invoice' : 'Create Invoice'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemEntry {
  final TextEditingController descriptionController;
  final TextEditingController quantityController;
  final TextEditingController priceController;

  _ItemEntry({
    required this.descriptionController,
    required this.quantityController,
    required this.priceController,
  });

  void dispose() {
    descriptionController.dispose();
    quantityController.dispose();
    priceController.dispose();
  }
}
