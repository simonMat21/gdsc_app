import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onPin;

  const NoteCard({
    super.key,
    required this.note,
    required this.onEdit,
    required this.onDelete,
    required this.onPin,
  });

  Color _getColorFromHex(String hexColor) {
    // Remove the '#' and convert
    final hex = hexColor.replaceFirst('#', '');
    return Color(int.parse('0x$hex'));
  }

  Color _getOpaqueColorFromHex(String hexColor) {
    // Get the same color but with full opacity
    final hex = hexColor
        .replaceFirst('#', '')
        .substring(2); // Remove alpha, keep RGB
    return Color(int.parse('0xFF$hex'));
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = _getColorFromHex(note.color);
    final formattedDate = DateFormat('MMM dd, yyyy').format(note.updatedAt);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Text colors that adapt to theme
    final titleColor = isDarkMode
        ? Colors.white.withValues(alpha: 0.87)
        : Colors.black.withValues(alpha: 0.87);
    final contentColor = isDarkMode
        ? Colors.white.withValues(alpha: 0.70)
        : Colors.black.withValues(alpha: 0.54);
    final dateColor = isDarkMode
        ? Colors.white.withValues(alpha: 0.54)
        : Colors.black.withValues(alpha: 0.45);
    final iconColor = isDarkMode
        ? Colors.white.withValues(alpha: 0.70)
        : Colors.black.withValues(alpha: 0.54);

    return GestureDetector(
      onTap: onEdit,
      child: Card(
        color: cardColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: _getOpaqueColorFromHex(note.color), width: 3),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    note.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: titleColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Content preview
                  Expanded(
                    child: Text(
                      note.content,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: contentColor),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Date
                  Text(
                    formattedDate,
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(color: dateColor),
                  ),
                ],
              ),
            ),

            // Pin button
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: onPin,
                child: Icon(
                  note.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                  color: iconColor,
                  size: 20,
                ),
              ),
            ),

            // Delete button
            Positioned(
              bottom: 8,
              right: 8,
              child: GestureDetector(
                onTap: onDelete,
                child: Icon(Icons.delete_outline, color: iconColor, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
