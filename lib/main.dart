import 'package:flutter/material.dart';

//TODO 1: Import reference to async and shred_preferences
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'User Profile'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //TODO 2: - Insert TextEditingController
  final _nameEditingCtrl = TextEditingController();
  final _emailEditingCtrl = TextEditingController();

  //TODO 3: - Insert _loadProfile() and _updateProfile() functions
  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameEditingCtrl.text = prefs.getString('name') ?? "";
      _emailEditingCtrl.text = prefs.getString('email') ?? "";
    });
  }

  Future<void> _updateProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('name', _nameEditingCtrl.text);
      prefs.setString('email', _emailEditingCtrl.text);
    });
  }

  //TODO 4:- Override initState() and dispose() functions
  @override
  void initState() {
    _loadProfile();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameEditingCtrl.dispose();
    _emailEditingCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: _nameEditingCtrl,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              const SizedBox(),
              TextField(
                controller: _emailEditingCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              Expanded(child: SizedBox()),
              ElevatedButton(
                  onPressed: (){
                    _updateProfile();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${_nameEditingCtrl.text}, your profile has been saved.'),
                      ),
                    );
                  },
                  child: const Text('Save')
              ),
            ],
          ),
        ),
      ),
    );
  }
}
