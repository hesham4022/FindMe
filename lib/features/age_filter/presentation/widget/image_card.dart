import 'dart:io';
import 'package:flutter/material.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';

class AgeFilterImageCard extends StatelessWidget {
  const AgeFilterImageCard({
    super.key,
    required this.imagePath,
    required this.isLoading,
    required this.onChooseImage,
    required this.onApplyFilter,
    required this.onRemoveImage,
  });

  final String? imagePath;
  final bool isLoading;
  final VoidCallback onChooseImage;
  final VoidCallback onApplyFilter;
  final VoidCallback onRemoveImage;

  @override
  Widget build(BuildContext context) {
    final bool hasImage = imagePath != null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4F6BFF), Color(0xFF6A7DFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4F6BFF).withOpacity(0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white24,
                child: Icon(
                  Icons.face_retouching_natural_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Age Filter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Upload a photo and see how the person looks at a different age.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (!hasImage)
            OutlinedButton.icon(
              onPressed: onChooseImage,
              icon: const Icon(Icons.upload_rounded),
              label: Text('chooseImage'.ts),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white38),
                backgroundColor: Colors.white.withOpacity(0.08),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          if (hasImage) ...[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.file(
                  File(imagePath!),
                  height: 210,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isLoading ? null : onApplyFilter,
                    icon: isLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.auto_awesome_rounded),
                    label: Text(isLoading ? 'Processing...' : 'Apply Filter'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF4F6BFF),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isLoading ? null : onRemoveImage,
                    icon: const Icon(Icons.delete_outline_rounded),
                    label: Text('remove'.ts),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white38),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
