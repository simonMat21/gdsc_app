import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/note.dart';
import '../providers/notes_provider.dart';
import '../widgets/color_picker.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;

  const AddEditNoteScreen({super.key, this.note});

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late String _selectedColor;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(
      text: widget.note?.content ?? '',
    );
    _selectedColor = widget.note?.color ?? '#B3E8F5E9';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.note != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Note' : 'New Note'),
        elevation: 0,
        actions: [
          // Color Picker Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: GestureDetector(
                onTap: () => _showColorPicker(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getColorFromHex(_selectedColor),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[400]!, width: 2),
                  ),
                  child: const Icon(
                    Icons.palette,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          if (isEditing)
            IconButton(
              onPressed: () => _showDeleteDialog(context),
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Delete Note',
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: _getColorFromHex(_selectedColor),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Content in one box
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // Title TextField
                          TextField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              hintText: 'Title',
                              border: InputBorder.none,
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: Colors.grey[500]),
                            ),
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                            maxLines: null,
                          ),
                          // Divider
                          Divider(
                            color: Colors.grey[400],
                            thickness: 1,
                            height: 16,
                          ),
                          // Content TextField
                          TextField(
                            controller: _contentController,
                            decoration: InputDecoration(
                              hintText: 'Start typing...',
                              border: InputBorder.none,
                              hintStyle: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.grey[500]),
                            ),
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Save Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _saveNote,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    isEditing ? 'Update Note' : 'Save Note',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorFromHex(String hexColor) {
    final hex = hexColor.replaceFirst('#', '');
    return Color(int.parse('0x$hex'));
  }

  void _showColorPicker(BuildContext context) {
    final colors = [
      '#66E8F5E9', // Light green - translucent
      '#66F3E5F5', // Light purple - translucent
      '#66FFF9C4', // Light yellow - translucent
      '#66FFE0B2', // Light orange - translucent
      '#66FFCCBC', // Light orange-red - translucent
      '#66EF9A9A', // Light red - translucent
      '#66F8BBD0', // Light pink - translucent
      '#66B3E5FC', // Light blue - translucent
    ];

    final colorValues = [
      const Color(0x66E8F5E9), // Green translucent
      const Color(0x66F3E5F5), // Purple translucent
      const Color(0x66FFF9C4), // Yellow translucent
      const Color(0x66FFE0B2), // Orange translucent
      const Color(0x66FFCCBC), // Orange-red translucent
      const Color(0x66EF9A9A), // Red translucent
      const Color(0x66F8BBD0), // Pink translucent
      const Color(0x66B3E5FC), // Blue translucent
    ];

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose a color',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(
                colorValues.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = colors[index];
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: colorValues[index],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _selectedColor == colors[index]
                            ? Colors.black
                            : Colors.grey[300]!,
                        width: _selectedColor == colors[index] ? 3 : 1,
                      ),
                    ),
                    child: _selectedColor == colors[index]
                        ? const Icon(Icons.check)
                        : null,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _saveNote() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a title'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (_contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter some content'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final now = DateTime.now();
    final note =
        widget.note?.copyWith(
          title: _titleController.text,
          content: _contentController.text,
          color: _selectedColor,
          updatedAt: now,
        ) ??
        Note(
          id: const Uuid().v4(),
          title: _titleController.text,
          content: _contentController.text,
          createdAt: now,
          updatedAt: now,
          color: _selectedColor,
        );

    if (widget.note != null) {
      context.read<NotesProvider>().updateNote(note);
    } else {
      context.read<NotesProvider>().addNote(note);
    }

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.note != null ? 'Note updated' : 'Note saved'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<NotesProvider>().deleteNote(widget.note!.id);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to notes screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Note deleted'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
