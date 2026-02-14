import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InventoryImagePicker extends StatelessWidget {
  final String? imageUrl;
  final File? imageFile;
  final ValueChanged<File> onImagePicked;

  const InventoryImagePicker({
    super.key,
    this.imageUrl,
    this.imageFile,
    required this.onImagePicked,
  });

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 80,
    );
    if (picked != null) {
      onImagePicked(File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasImage =
        imageFile != null || (imageUrl != null && imageUrl!.isNotEmpty);

    return GestureDetector(
      onTap: () => _pickImage(context),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.5,
            style: BorderStyle.solid,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: hasImage ? _buildImagePreview() : _buildPlaceholder(),
      ),
    );
  }

  Widget _buildImagePreview() {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (imageFile != null)
          Image.file(imageFile!, fit: BoxFit.cover)
        else if (imageUrl != null)
          Image.network(imageUrl!, fit: BoxFit.cover),
        Positioned(
          bottom: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.edit, size: 14, color: Colors.white),
                SizedBox(width: 4),
                Text(
                  'Change',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.cloud_upload_outlined,
          size: 36,
          color: Colors.grey.shade400,
        ),
        const SizedBox(height: 8),
        Text(
          'Tap to upload image',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'PNG, JPG (MAX. 2MB)',
          style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
        ),
      ],
    );
  }
}
