import 'package:chat_test_work/domain/models/info_provider.dart';
import 'package:chat_test_work/presentation/pages/chat_screen.dart';
import 'package:chat_test_work/presentation/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => InfoProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: MainScreen(),
      ),
      routes: {
        '/mainScreen': (context) => const MainScreen(),
        '/chatScreen': (context) => const ChatScreen(),
      },
    );
  }
}
