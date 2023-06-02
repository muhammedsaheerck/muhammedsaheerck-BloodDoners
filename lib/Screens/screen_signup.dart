import 'package:flutter/material.dart';

import '../auth_services.dart';
import '../widgets/custom_textfield.dart';

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
              CustomTextFormField(
                controller: nameController,
                hint: "Name",
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
              CustomTextFormField(
                controller: emilController,
                hint: "Email",
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
              CustomTextFormField(
                controller: passwordControoller,
                hint: "Password",
                validator: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    return "password length minimum 6";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: ElevatedButton(
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
                    child: const Text("SignUp")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
