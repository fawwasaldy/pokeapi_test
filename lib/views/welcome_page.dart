import 'package:flutter/material.dart';
import 'package:pokeapi_test/views/login_page.dart';
import 'package:pokeapi_test/views/signup_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
            TextButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));}, 
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()));}, 
              child: const Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }
}