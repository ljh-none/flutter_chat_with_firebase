import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

const String CHAT_ROOM_URL = '/flutter_chat_demo_2/chat_room_list/pat_mat';
const String USER = "test user";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController txtcontrollor = TextEditingController();
  //firestore객체 생성
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("chat")),
      body: StreamBuilder(
        stream: _firestore
            .collection(CHAT_ROOM_URL)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: buildChatList,
      ),
      bottomNavigationBar: Row(children: [
        Expanded(
            child: TextField(
          controller: txtcontrollor,
          decoration: const InputDecoration(
            labelText: "input",
            border: OutlineInputBorder(),
          ),
        )),
        ElevatedButton(onPressed: sendMessage, child: const Text("send"))
      ]),
    );
  }

  Future<void> sendMessage() async {
    Timestamp timestamp = Timestamp.now();
    String temp = txtcontrollor.text;
    await _firestore
        .collection(CHAT_ROOM_URL)
        .add({'content': temp, 'sender': USER, 'timestamp': timestamp});
  }

  Widget buildChatList(context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasError) {
      return const Text("err!");
    }
    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return const Text("no data");
    }

    return ListView.builder(
      itemCount: snapshot.data!.docs.length,
      reverse: true,
      itemBuilder: (context, index) {
        var doc = snapshot.data!.docs[index];
        var data = doc.data() as Map<String, dynamic>;
        return ListTile(
          title: Text(data['content']),
          subtitle: Text(data['sender']),
        );
      },
    );
  }
}
