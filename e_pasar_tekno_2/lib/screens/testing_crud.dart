import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestingCRUD extends StatefulWidget {
  const TestingCRUD({super.key});

  @override
  State<TestingCRUD> createState() => _TestingCRUDState();
}

class _TestingCRUDState extends State<TestingCRUD> {
  final textController = TextEditingController();
  bool readMultipleData = true;
  String buttonText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(controller: textController),
        actions: [
          IconButton(
            onPressed: () {
              final name = textController.text;

              createUser(name: name);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Builder(builder: (context) {
        Widget content;

        if (readMultipleData) {
          // Read multiple data
          buttonText = "Read multiple data";
          content = StreamBuilder<List<User>>(
            stream: readUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final users = snapshot.data!;

                return ListView(
                  children: users.map(buildUser).toList(),
                );
              } else if (snapshot.hasError) {
                return Text('Something went wrong! ${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        } else {
          // Read a single data
          buttonText = "Read a single data";
          content = FutureBuilder<User?>(
            future: readUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final user = snapshot.data;

                return user == null
                    ? const Center(child: Text('No User'))
                    : buildUser(user);
              } else if (snapshot.hasError) {
                return Text('Something went wrong! ${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        }

        return Column(
          children: [
            Expanded(child: content),
            ElevatedButton(
                onPressed: () {
                  final docUser = FirebaseFirestore.instance
                      .collection('testing_users')
                      .doc('9ZRodDOwOSlJc4X1BsFn');

                  // Update specific fields
                  docUser.update({
                    'name': 'Emma',
                  });
                },
                child: const Text("Update")),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    readMultipleData = !readMultipleData;
                  });
                },
                child: Text(buttonText)),
          ],
        );
      }),
    );
  }

  Widget buildUser(User user) => ListTile(
        leading: CircleAvatar(child: Text('${user.age}')),
        title: Text(user.name),
        subtitle: Text(user.birthday.toIso8601String()),
      );

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('testing_users')
      .snapshots()
      .map((event) =>
          event.docs.map((doc) => User.fromJson(doc.data())).toList());

  Future<User?> readUser() async {
    final docUser = FirebaseFirestore.instance
        .collection('testing_users')
        .doc('9ZRodDOwOSlJc4X1BsFn');
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }

  Future createUser({required String name}) async {
    final docUser =
        FirebaseFirestore.instance.collection('testing_users').doc();

    /* Jika langsung menggunakan Json murni */
    // final json = {
    //   'name': name,
    //   'age': 21,
    //   'birthday': DateTime(2001, 7, 28),
    // };
    // await docUser.set(json);

    /* Jika menggunakan Model Object */
    final user = User(
      id: docUser.id,
      name: name,
      age: 21,
      birthday: DateTime(2001, 7, 28),
    );
    await docUser.set(user.toJson());
  }
}

class User {
  String id;
  final String name;
  final int age;
  final DateTime birthday;

  User({
    this.id = '',
    required this.name,
    required this.age,
    required this.birthday,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'birthday': birthday,
      };

  static User fromJson(Map<String, dynamic> json) => User(
      name: json['name'],
      age: json['age'],
      birthday: (json['birthday'] as Timestamp).toDate());
}

/*
Useful Resources:
- https://youtu.be/ErP_xomHKTw
- https://youtu.be/rWamixHIKmQ
*/
