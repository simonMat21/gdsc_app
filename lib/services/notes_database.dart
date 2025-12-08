import 'package:hive_flutter/hive_flutter.dart';
import '../models/note.dart';

class NotesDatabase {
  static const String boxName = 'notes';
  late Box<Note> _notesBox;

  Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NoteAdapter());
    _notesBox = await Hive.openBox<Note>(boxName);
  }

  // CREATE
  Future<void> addNote(Note note) async {
    try {
      await _notesBox.put(note.id, note);
      print('DEBUG: Note saved with ID: ${note.id}');
      print('DEBUG: Total notes in box: ${_notesBox.length}');
    } catch (e) {
      print('ERROR in addNote: $e');
    }
  }

  // READ
  List<Note> getAllNotes() {
    try {
      final notes = _notesBox.values.toList();
      // Sort by pinned first, then by updated date (latest first)
      notes.sort((a, b) {
        if (a.isPinned != b.isPinned) {
          return a.isPinned ? -1 : 1;
        }
        return b.updatedAt.compareTo(a.updatedAt);
      });
      print('DEBUG: getAllNotes retrieved ${notes.length} notes');
      return notes;
    } catch (e) {
      print('ERROR in getAllNotes: $e');
      return [];
    }
  }

  Note? getNoteById(String id) {
    return _notesBox.get(id);
  }

  // UPDATE
  Future<void> updateNote(Note note) async {
    await _notesBox.put(note.id, note);
  }

  // DELETE
  Future<void> deleteNote(String id) async {
    await _notesBox.delete(id);
  }

  Future<void> deleteAllNotes() async {
    await _notesBox.clear();
  }

  // SEARCH
  List<Note> searchNotes(String query) {
    final allNotes = getAllNotes();
    return allNotes.where((note) {
      final titleMatch = note.title.toLowerCase().contains(query.toLowerCase());
      final contentMatch = note.content.toLowerCase().contains(
        query.toLowerCase(),
      );
      return titleMatch || contentMatch;
    }).toList();
  }

  // Get notes count
  int getNotesCount() {
    return _notesBox.length;
  }

  // Close database
  Future<void> close() async {
    await _notesBox.close();
  }
}
