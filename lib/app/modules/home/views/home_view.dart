import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await controller.signout();
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: controller.phoneDirectoryStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data =
                  snapshot.data!.docs[index].data()! as Map<String, dynamic>;

              return ListTile(
                title: Text(data["name"]),
                subtitle: Text(data["phone"]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        Map<String, dynamic> phoneBook = {
                          "name": "updated Abc Xyzafdasd",
                          "phone": "9700000080"
                        };
                        String docId = snapshot.data!.docs[index].id;

                        await controller.updatePhoneDirectory(phoneBook, docId);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () async {
                        String docId = snapshot.data!.docs[index].id;
                        await controller.deletePhoneDirectory(docId);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, dynamic> phoneBook = {
            "name": "Abc Xyzafdasd",
            "phone": "9800000080"
          };
          await controller.addPhoneDirectory(phoneBook);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
