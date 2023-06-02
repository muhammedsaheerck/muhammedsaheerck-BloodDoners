import 'package:flutter/material.dart';

import '../auth_services.dart';

class ScreenSignIn extends StatefulWidget {
  const ScreenSignIn({super.key});

  @override
  State<ScreenSignIn> createState() => _ScreenSignInState();
}

class _ScreenSignInState extends State<ScreenSignIn> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emilController = TextEditingController();
  TextEditingController passwordControoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: "Email", border: InputBorder.none),
                    controller: emilController,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains("@")) {
                        return "Please enter valid email";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: "Password", border: InputBorder.none),
                    controller: passwordControoller,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return "password lenthe minimum 6";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "signup");
                      },
                      child: const Text("create account")),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        AuthServices.signinUser(emilController.text,
                            passwordControoller.text, context);
                      }
                    },
                    child: const Text("SignIn")),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("OR"),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => AuthServices().googleSignIn(context),
                    child: SizedBox(
                      child: Image.asset(
                        "asset/download.png",
                        height: 60,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  GestureDetector(
                    // onTap: () => AuthServices().googleSignIn(context),
                    child: SizedBox(
                      child: Image.asset(
                        "asset/download (1).png",
                        height: 50,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
