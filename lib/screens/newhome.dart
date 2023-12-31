import 'package:flutter/material.dart';

class NewHome extends StatelessWidget {
  const NewHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                    right: 330,
                    child: Image.asset(
                      'assets/images/bg.png',
                      height: 400,
                    )),
                Positioned(
                  left: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          print("ok");
                        },
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white,
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: const CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.white,
                              child: Text("MotoPlay"),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 60), // Adjust spacing between avatars
                      InkWell(
                        onTap: (){
                          print("ok");
                        },
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white,
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: const CircleAvatar(
                              radius: 32,
                              backgroundColor: Color(0xff005796),
                              child: Text(
                                "Hay",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 60), // Adjust spacing between avatars
                      InkWell(
                        onTap: () {
                          print('ok');
                        },
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white,
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: const CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.white,
                              child: Text("Mañana"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
