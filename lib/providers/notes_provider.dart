import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/notes_database.dart';

class NotesProvider extends ChangeNotifier {
  final NotesDatabase _database = NotesDatabase();
  List<Note> _notes = [];
  List<Note> _filteredNotes = [];
  String _searchQuery = '';
  bool _isDarkMode = false;

  // Getters
  List<Note> get notes =>
      _filteredNotes.isEmpty && _searchQuery.isEmpty ? _notes : _filteredNotes;
  List<Note> get allNotes => _notes;
  String get searchQuery => _searchQuery;
  bool get isDarkMode => _isDarkMode;

  // Initialize database and load notes
  Future<void> initialize() async {
    await _database.initialize();
    await loadNotes();
  }

  // Load all notes
  Future<void> loadNotes() async {
    print('DEBUG: loadNotes called');
    _notes = _database.getAllNotes();
    print('DEBUG: loadNotes retrieved ${_notes.length} notes');
    notifyListeners();
  }

  // Add note
  Future<void> addNote(Note note) async {
    print('DEBUG: addNote called with title: ${note.title}');
    await _database.addNote(note);
    _notes = _database.getAllNotes();
    _applySearch();
    print('DEBUG: After addNote, _notes has ${_notes.length} items');
    notifyListeners();
  }

  // Update note
  Future<void> updateNote(Note note) async {
    await _database.updateNote(note);
    _notes = _database.getAllNotes();
    _applySearch();
    notifyListeners();
  }

  // Delete note
  Future<void> deleteNote(String id) async {
    await _database.deleteNote(id);
    _notes = _database.getAllNotes();
    _applySearch();
    notifyListeners();
  }

  // Toggle pin
  Future<void> togglePin(String id) async {
    final note = _database.getNoteById(id);
    if (note != null) {
      final updatedNote = note.copyWith(isPinned: !note.isPinned);
      await _database.updateNote(updatedNote);
      _notes = _database.getAllNotes();
      _applySearch();
      notifyListeners();
    }
  }

  // Search notes
  void searchNotes(String query) {
    _searchQuery = query;
    _applySearch();
    notifyListeners();
  }

  void _applySearch() {
    if (_searchQuery.isEmpty) {
      _filteredNotes = [];
    } else {
      _filteredNotes = _database.searchNotes(_searchQuery);
    }
  }

  // Clear search
  void clearSearch() {
    _searchQuery = '';
    _filteredNotes = [];
    notifyListeners();
  }

  // Toggle dark mode
  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Get notes count
  int getNotesCount() {
    return _database.getNotesCount();
  }
}
