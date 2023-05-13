import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:deaf_project/model/word_content_model.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  final controller = ScrollController();

  List<String> AllWord = [];
  List<String> DisplayWord = [];

  @override
  void initState() {
    readContent();
    super.initState();
  }

  Future<void> readContent() async {
    await Firebase.initializeApp().then((value) async {
      CollectionReference CollectionRef =
          FirebaseFirestore.instance.collection('content');
      QuerySnapshot snapshot = await CollectionRef.orderBy('text').get();

      for (var document in snapshot.docs) {
        Map<String, dynamic>? map = document.data() as Map<String, dynamic>?;
        ContentCollection WordModel = ContentCollection.fromMap(map!);
        AllWord.add(WordModel.text);
      }
    });
  }

  onSearch(String Search) {
    setState(() {
      Search == ''
          ? DisplayWord.clear()
          : DisplayWord = AllWord.where((element) =>
              element.toLowerCase().contains(Search.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(248, 253, 250, 220),
        body: SingleChildScrollView(
          controller: controller,
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
                      'Content Screen',
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
                            child: TextField(
                              onChanged: (value) => onSearch(value),
                              decoration: const InputDecoration(
                                hintText: 'Search',
                                prefixIcon: Icon(Icons.search),
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 59, 59, 59)),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            )))),
              ],
            ),
            SizedBox(
                height: screen.height,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: DisplayWord.length,
                    itemBuilder: (context, index) =>
                        CreateWidget(DisplayWord[index]))),
            GestureDetector(
              onDoubleTap: () {
                controller.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              },
              child: Container(
                height: screen.height * 0.05,
                width: screen.width,
                color: const Color.fromARGB(255, 44, 17, 94),
                child: Center(
                    child: Text(
                  'Double tap to go up to the top',
                  style: TextStyle(
                      color: Colors.white, fontSize: screen.height * 0.02),
                )),
              ),
            )
          ]),
        ));
  }

  Widget CreateWidget(String text) {
    Size screen = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: screen.height * 0.04),
      child: Stack(
        children: [
          Center(
            child: Container(
              height: screen.height * 0.065,
              width: screen.width * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    const BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 10,
                        color: Colors.grey)
                  ]),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: screen.height * 0.025,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          Positioned(
              top: 0,
              bottom: 0,
              right: screen.width * 0.05,
              child: const Icon(Icons.navigate_next))
        ],
      ),
    );
  }
}
