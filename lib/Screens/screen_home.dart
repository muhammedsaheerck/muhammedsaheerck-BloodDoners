import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testfire/Screens/screen_doners_add.dart';
import 'package:testfire/Screens/screen_signin.dart';
import 'package:testfire/auth_services.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final CollectionReference doner =
      FirebaseFirestore.instance.collection("doners");

  Future<void> deleteDoner(String id) async {
    doner.doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: Colors.red,
        title: const Text(
          "Blood doners",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                AuthServices.logOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => ScreenSignIn(),
                    ),
                    (route) => false);
              },
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ))
        ],
      ),
      body: StreamBuilder(
        stream: doner.snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot donerData = snapshot.data!.docs[index];
                return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                        title: Text(donerData['Name'].toString()),
                        subtitle: Text(donerData['Mobile'].toString()),
                        leading: Text(donerData['Group'].toString()),
                        trailing: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed("update", arguments: {
                                  'Name': donerData['Name'],
                                  'Mobile': donerData['Mobile'].toString(),
                                  'Group': donerData['Group'],
                                  'id': donerData.id
                                });
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () => deleteDoner(donerData.id),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        )));
              },
              separatorBuilder: (context, index) => const SizedBox(
                width: 5,
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ScreenDonersAdd(),
            ));
          },
          child: const Icon(Icons.add)),
    );
  }
}
