import 'package:flutter/material.dart';

class TalkBackScreen extends StatefulWidget {
  const TalkBackScreen({super.key});

  @override
  State<TalkBackScreen> createState() => _TalkBackScreenState();
}

class _TalkBackScreenState extends State<TalkBackScreen> {
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
                      'Talk Back Screen',
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
                              Text('',
                                  style: TextStyle(
                                      fontSize: screen.height * 0.025,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black)),
                            ],
                          ),
                        )))
              ],
            ),
            SizedBox(
              height: screen.height * 0.6,
              width: screen.width * 0.9,
              child: Center(
                child: Text(
                  'This page is in development mode ...',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 178, 25, 15),
                      fontSize: screen.height * 0.02,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ]),
        ));
  }
}
