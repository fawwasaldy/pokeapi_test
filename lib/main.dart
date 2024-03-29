import 'package:flutter/material.dart';
import 'package:pokeapi_test/views/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Operation().insertUser(User(id: 'abcd', email: 'cyan', password: 'cyan123'));
  // print(await Operation().users().toString());
  // await DatabaseService().deleteDatabase(await DatabaseService().fullPath);
  // var db = await DatabaseService().database;
  // var result = await db.query('sqlite_master');
  // print(result);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, fontFamily: 'WorkSans'),
          titleMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'WorkSans'),
          titleSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: 'WorkSans'),
          bodyLarge: TextStyle(fontSize: 18.0, fontFamily: 'WorkSans'),
          bodyMedium: TextStyle(fontSize: 16.0, fontFamily: 'WorkSans'),
          bodySmall: TextStyle(fontSize: 14.0, fontFamily: 'WorkSans'),
        ),
        useMaterial3: true,
      ),
      home: const WelcomePage(),
    );
  }
}

