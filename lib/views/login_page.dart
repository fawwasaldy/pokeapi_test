import 'package:flutter/material.dart';
import 'package:pokeapi_test/database/database_service.dart';
import 'package:pokeapi_test/views/home_page.dart';
import 'package:uuid/uuid.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("PokeAPI Test", style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () async {
                var uuid = const Uuid();
                String uId = uuid.v5(Uuid.NAMESPACE_URL, emailController.text);
                final db = await DatabaseService().database;

                final List<Map<String, Object?>> uIdCheck = await db.rawQuery('SELECT u_id, u_password FROM user WHERE u_id = ?', [uId]);

                if(uIdCheck.isEmpty || passwordController.text.compareTo(uIdCheck[0]['u_password'] as String) != 0) {
                  emailController.clear();
                  passwordController.clear();
                }
                else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(uId: uId)));
                }
              }, 
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}