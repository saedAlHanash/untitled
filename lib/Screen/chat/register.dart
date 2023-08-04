import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import '../../Utils/storage_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _storageController = StorageController();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      user = user;
    });
  }

  User? user;

  void _register() async {
    FocusScope.of(context).unfocus();

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: '_${_storageController.id}@fitnes.com',
        password: '98898${_storageController.id}!@qweDSAFCA',
      );

      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: _storageController.user,
          id: credential.user!.uid,
          lastName: '_lastName',
        ),
      );
    } catch (e) {}
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: const Text('Register'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 80, left: 24, right: 24),
          ),
        ),
      );
}
