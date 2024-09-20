import 'package:barcode/widgets/custom_button.dart';
import 'package:barcode/widgets/loading.dart';
import 'package:barcode/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowUser extends StatefulWidget {
  const ShowUser({Key? key}) : super(key: key);

  @override
  State<ShowUser> createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("user page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('user').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No Available data',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 5,
                          // color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "user email: ${snapshot.data!.docs[index]['email']}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        change(snapshot.data!.docs[index].id,
                                            'email');
                                      },
                                      icon: Icon(Icons.edit))
                                ],
                              ),
                              Center(
                                child: CustomTextButton(
                                    lable: 'Delete',
                                    ontap: () async {
                                      setState(() {
                                        showdilog();
                                      });
                                      try {
                                        var res = await FirebaseFirestore
                                            .instance
                                            .collection('user')
                                            .doc(snapshot.data!.docs[index].id)
                                            .delete();
                                            // FirebaseAuth.instance.
                                        setState(() {
                                          Get.back();
                                          showbar('delete user', 'subtitle',
                                              'user deleted', true);
                                        });
                                      } catch (e) {
                                        setState(() {
                                          Get.back();
                                          showbar('delete user', 'subtitle',
                                              e.toString(), false);
                                        });
                                      }
                                    },
                                    color: Colors.red),
                              )
                            ],
                          ),
                        );
                      });
                }
              }
            }),
      ),
    );
  }

  void change(String id, String field) async {
    TextEditingController change = TextEditingController();
    Get.defaultDialog(
        title: 'Edit',
        content: SingleChildScrollView(
          child: TextFormField(
            // keyboardType: TextInputType.number,
            controller: change,
            decoration: const InputDecoration(
              icon: Icon(Icons.account_circle),
              // labelText: 'Username',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "This field can be empty";
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              showdilog();
              try {
                var fielde = field == 'No' ? int.tryParse(field) : field;
                await FirebaseFirestore.instance
                    .collection('user')
                    .doc(id)
                    .update({fielde.toString(): change.text});

                change.clear();
                Get.back();
                Get.back();
                Get.snackbar('done', 'done',
                    backgroundColor: Colors.greenAccent);
              } catch (e) {
                Get.back();
                Get.back();
                Get.snackbar('Done', e.toString(), backgroundColor: Colors.red);
              }
            },
            child: const Text(
              "Edit",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          TextButton(
              onPressed: () {
                Get.back();
                change.clear();
              },
              child: const Text(
                "Exit",
                style: TextStyle(color: Colors.black, fontSize: 20),
              )),
        ]);
    // var res = await collectionReference.doc(id).update(attribute);
  }
}
