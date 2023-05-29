import 'package:flutter/material.dart';

import '../auth_services.dart';

class ScreenSignUp extends StatefulWidget {
  const ScreenSignUp({super.key});

  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emilController = TextEditingController();
  TextEditingController passwordControoller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  // bool login = false;
  // String fullname ='';
  //  String email ='';
  //   String password ='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Create User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: "Name"),
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter full name";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "Email"),
                controller: emilController,
                validator: (value) {
                  if (value!.isEmpty || !value.contains("@")) {
                    return "Please enter valid email";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "Password"),
                controller: passwordControoller,
                validator: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    return "password lenthe minimum 6";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      AuthServices.signupUser(
                          emilController.text,
                          passwordControoller.text,
                          nameController.text,
                          context);
                    }
                  },
                  child: Text("SignUp"))
            ],
          ),
        ),
      ),
    );
  }
}
