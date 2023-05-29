import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScreenDonersAdd extends StatefulWidget {
  const ScreenDonersAdd({super.key});

  @override
  State<ScreenDonersAdd> createState() => _ScreenDonersAddState();
}

class _ScreenDonersAddState extends State<ScreenDonersAdd> {
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

  Future<void> addDoners() async {
    final data = {
      "Name": nameController.text,
      "Mobile": phoneController.text,
      "Group": selectedValue
    };
    await doner.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "Add Blood doners",
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
                    await addDoners();
                    Navigator.pushNamed(context, "/");
                  },
                  child: const Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }
}
