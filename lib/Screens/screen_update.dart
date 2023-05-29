import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScreenUpdateDoner extends StatefulWidget {
  const ScreenUpdateDoner({super.key});

  @override
  State<ScreenUpdateDoner> createState() => _ScreenUpdateDonerState();
}

class _ScreenUpdateDonerState extends State<ScreenUpdateDoner> {
  List<DropdownMenuItem<String>> dropdownItems = const [
    DropdownMenuItem(
      value: 'A+',
      child: Text('A+'),
    ),
    DropdownMenuItem(
      value: 'AB+',
      child: Text('AB+'),
    ),
    DropdownMenuItem(
      value: 'A-',
      child: Text('A-'),
    ),
  ];
  String? selectedValue;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final CollectionReference doner =
      FirebaseFirestore.instance.collection("doners");

  Future<void> updateDoner(String id) async {
    try {
      final data = {
        "Name": nameController.text,
        "Mobile": phoneController.text,
        "Group": selectedValue
      };
      await doner.doc(id).update(data);
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    nameController.text = args['Name'];
    phoneController.text = args['Mobile'];
    selectedValue = args['Group'];
    final docId = args['id'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "Update Blood doner",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  hintText: "Mobile number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
                keyboardType: TextInputType.number,
                maxLength: 10,
              ),
              DropdownButtonFormField<String>(
                hint: const Text("Choose Blood Group"),
                value: selectedValue,
                items: dropdownItems,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    print(args);
                    await updateDoner(docId);
                    Navigator.of(context).pushNamed("/");
                  },
                  child: const Text("Update")),
            ],
          ),
        ),
      ),
    );
  }
}
