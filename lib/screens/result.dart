import 'package:deaf_project/model/result_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // List<String> ResultWord = [];
  List<Widget> WidgetList = [];
  bool checkWord = false;

  @override
  void initState() {
    readContent();
    super.initState();
  }

  Future<void> readContent() async {
    await Firebase.initializeApp().then((value) async {
      CollectionReference CollectionRef =
          FirebaseFirestore.instance.collection('result');
      QuerySnapshot snapshot = await CollectionRef.orderBy('time').get();

      for (var document in snapshot.docs) {
        Map<String, dynamic>? map = document.data() as Map<String, dynamic>?;
        ResultCollection ResultModel = ResultCollection.fromMap(map!);
        // ResultWord.add(ResultModel.text);
        setState(() {
          WidgetList.add(CreateWidget(ResultModel.text, document.id));
          checkWord = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(248, 253, 250, 220),
        body: SingleChildScrollView(
          child: Column(children: [
            Stack(
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      height: screen.height * 0.25,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 44, 17, 94),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(36),
                            bottomRight: Radius.circular(36)),
                      ),
                    ),
                    SizedBox(
                      height: screen.height * 0.02,
                    )
                  ],
                ),
                Positioned(
                    top: screen.height * 0.03,
                    left: screen.width * 0.03,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: screen.height * 0.05,
                        width: screen.height * 0.05,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(2, 2),
                                  blurRadius: 10,
                                  color: Colors.grey.shade800)
                            ]),
                        child: const Icon(Icons.navigate_before),
                      ),
                    )),
                Positioned(
                    top: screen.height * 0.1,
                    right: screen.width * 0.04,
                    bottom: screen.height * 0.08,
                    child: Image.asset('assets/icons/logo.PNG')),
                Positioned(
                    left: screen.width * 0.1,
                    bottom: screen.height * 0.075,
                    child: Text(
                      'Result Screen',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 233, 233, 233),
                          fontWeight: FontWeight.bold,
                          fontSize: screen.width * 0.07),
                    )),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screen.width * 0.05),
                        height: screen.height * 0.06,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 231, 231, 231),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 10),
                                  blurRadius: 50,
                                  color: Colors.grey.shade900)
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(left: screen.width * 0.06),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('the result from camera',
                                  style: TextStyle(
                                      fontSize: screen.height * 0.025,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromARGB(
                                          255, 31, 31, 31))),
                            ],
                          ),
                        )))
              ],
            ),
            SizedBox(height: screen.height * 0.05),
            if (checkWord == false)
              Center(
                child: SizedBox(
                  height: screen.height * 0.6,
                  width: screen.width * 0.9,
                  child: Center(
                    child: Text(
                      'Not Found',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 178, 25, 15),
                          fontSize: screen.height * 0.02,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ...WidgetList,
            SizedBox(height: screen.height * 0.05),
            if (checkWord)
              Center(
                child: Container(
                  height: screen.height * 0.07,
                  width: screen.width * 0.9,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 193, 3, 3),
                      borderRadius: BorderRadius.circular(screen.height * 0.1),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(2, 10),
                            spreadRadius: 1,
                            blurRadius: 20,
                            color: Colors.grey.shade700)
                      ]),
                  child: Center(
                      child: GestureDetector(
                    onTap: () {
                      FirebaseFirestore.instance
                          .collection('result')
                          .get()
                          .then((querySnapshot) {
                        for (var doc in querySnapshot.docs) {
                          doc.reference.delete();
                        }
                        Navigator.pop(context);
                      });
                    },
                    child: Text(
                      'Clear',
                      style: TextStyle(
                          color: Colors.white, fontSize: screen.height * 0.03),
                    ),
                  )),
                ),
              ),
            SizedBox(height: screen.height * 0.05),
          ]),
        ));
  }

  Widget CreateWidget(String text, String id) {
    Size screen = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          top: screen.height * 0.015, bottom: screen.height * 0.015),
      child: Stack(children: [
        Center(
          child: Container(
            height: screen.height * 0.065,
            width: screen.width * 0.9,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screen.height * 0.05),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(2, 10),
                      spreadRadius: 1,
                      blurRadius: 20,
                      color: Colors.grey.shade700)
                ]),
            child: Center(
                child: Text(
              text,
              style: TextStyle(
                  fontSize: screen.height * 0.025, fontWeight: FontWeight.w500),
            )),
          ),
        ),
        Positioned(
            top: 0,
            bottom: 0,
            right: screen.width * 0.1,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  FirebaseFirestore.instance
                      .collection('result')
                      .doc(id)
                      .delete();
                  Navigator.pop(context);
                });
              },
              child: Icon(
                Icons.close,
                size: screen.height * 0.03,
              ),
            ))
      ]),
    );
  }
}
