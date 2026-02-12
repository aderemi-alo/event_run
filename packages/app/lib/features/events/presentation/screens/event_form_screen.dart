import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app/core/utils/validators.dart';
import 'package:app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:app/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:app/features/events/domain/entities/event_entity.dart';
import 'package:app/features/events/presentation/providers/event_providers.dart';

class EventFormScreen extends ConsumerStatefulWidget {
  const EventFormScreen({super.key, this.eventId});

  final String? eventId;

  @override
  ConsumerState<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends ConsumerState<EventFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _revenueController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime _eventDate = DateTime.now().add(const Duration(days: 7));
  bool _loading = false;

  bool get _isEditing => widget.eventId != null;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _revenueController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _eventDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null) setState(() => _eventDate = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final vendorId = ref.read(currentVendorIdProvider);
    if (vendorId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complete business setup first.')),
      );
      return;
    }

    setState(() => _loading = true);
    try {
      final event = EventEntity(
        id: widget.eventId ?? '',
        vendorId: vendorId,
        name: _nameController.text.trim(),
        eventDate: _eventDate,
        location: _locationController.text.trim().isNotEmpty
            ? _locationController.text.trim()
            : null,
        status: EventStatus.draft,
        revenue: _revenueController.text.trim().isNotEmpty
            ? num.tryParse(_revenueController.text.trim())
            : null,
        notes: _notesController.text.trim().isNotEmpty
            ? _notesController.text.trim()
            : null,
        createdAt: DateTime.now(),
      );

      if (_isEditing) {
        await ref.read(updateEventUsecaseProvider).call(event: event);
      } else {
        await ref.read(createEventUsecaseProvider).call(event: event);
      }

      ref.invalidate(eventsProvider(vendorId));
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
        title: Text(_isEditing ? 'Edit Event' : 'New Event'),
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
                label: 'Event Name',
                hint: 'Wedding Reception',
                controller: _nameController,
                prefixIcon: Icons.event_outlined,
                textInputAction: TextInputAction.next,
                validator: (v) => Validators.validateRequired(
                  context,
                  v,
                  fieldName: 'Event name',
                ),
              ),
              const SizedBox(height: 16),
              AuthFormField(
                label: 'Description',
                hint: 'Brief description of the event',
                controller: _descriptionController,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              Text(
                'Event Date',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              InkWell(
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    '${_eventDate.day}/${_eventDate.month}/${_eventDate.year}',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AuthFormField(
                label: 'Location',
                hint: 'Venue name or address',
                controller: _locationController,
                prefixIcon: Icons.location_on_outlined,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              AuthFormField(
                label: 'Revenue',
                hint: '0.00',
                controller: _revenueController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.attach_money,
                textInputAction: TextInputAction.next,
                validator: (v) {
                  if (v != null && v.isNotEmpty) {
                    return Validators.validateNumber(context, v);
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AuthFormField(
                label: 'Notes',
                hint: 'Additional notes',
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
                    : Text(_isEditing ? 'Save Changes' : 'Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
