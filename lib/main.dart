import 'package:flutter/material.dart';
import 'package:flutter_learning_1/ui/profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'models/task_model.dart';
import 'providers/task_provider.dart';
import 'ui/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>(tasksBoxName);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'ToDo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.indigo, useMaterial3: true),
      darkTheme: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.amber, useMaterial3: true),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
