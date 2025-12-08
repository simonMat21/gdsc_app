import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/notes_provider.dart';
import 'screens/notes_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotesProvider()..initialize()),
      ],
      child: Consumer<NotesProvider>(
        builder: (context, notesProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Notes App',
            themeMode: notesProvider.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.light,
              ),
              typography: Typography.material2021(),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
              typography: Typography.material2021(),
            ),
            home: const NotesScreen(),
          );
        },
      ),
    );
  }
}
