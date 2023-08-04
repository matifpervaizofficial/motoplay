// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:blogger_api/blogger_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../utils/constanst.dart';
import '../utils/custom_drawer.dart';
import '../utils/mycolors.dart';
import 'blog_detail_screen.dart';

class Dashboard extends StatefulWidget {
  static const routeName = "/nextScreen";
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

int selectedButton = 1;

class _DashboardState extends State<Dashboard> {
  List<Map<String, String?>> posts = [];
  List<Map<String, String?>> gpList = [];
  List<Map<String, String?>> f1List = [];

  @override
  void initState() {
    super.initState();
    fetchPosts(blogIds[0], key);
  }

  Future<PostModel> getAllpost() async {
    final res = await BloggerAPI().getAllPostFromBlog(
      includeComment: true,
      blogId: blogIds[0],
      apiKey: key,
    );
    return res;
  }

  Future<Map<String, String?>?> fetchPosts(String blogId, String apiKey) async {
    String url =
        'https://www.googleapis.com/blogger/v3/blogs/$blogId/posts?key=$apiKey';
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);

      if (jsonData.containsKey('items') && jsonData['items'] is List) {
        List<dynamic> items = jsonData['items'];
        for (var item in items) {
          String? title = item['title'];
          String? content = item['content'];
          String? published = item['published'];
          String? updated = item['updated'];

          // Use the html package to parse the HTML content
          final document = htmlParser.parse(content);
          final imageElement = document.querySelector('img');
          String? imageLink = imageElement?.attributes['src'];

          Map<String, String?> post = {
            'title': title,
            'content': content,
            'published': published,
            'updated': updated,
            'imageLink': imageLink, // Add the image link to the map
          };
          setState(() {
            posts.add(post);
          });
        }
        for (var post in posts) {
          String? title = post['title'];
          if (title != null) {
            if (title.contains('GP')) {
              setState(() {
                gpList.add(post);
              });
            }
            if (title.contains('F1')) {
              setState(() {
                f1List.add(post);
              });
            }
          }
        }
        return posts[1];
      } else {
        // Handle invalid API response
        print('Invalid API response: items not found');
      }
    } else {
      // Handle HTTP request error
      print('HTTP request failed with status code: ${response.statusCode}');
    }

    // Return null in case of an error
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    // Adjust font size based on screen width and text scale factor
    //final fontSize = screenWidth * 0.14 * textScaleFactor;
    //final subheading = screenWidth * 0.07 * textScaleFactor;
    final heading = screenWidth * 0.14 * textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            SizedBox(
              height: 150,
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/newbox.png')),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 40,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      CircleAvatar(
                        radius: 40,
                      ),
                    ],
                  ),
                )
              ]),
            ),
            SizedBox(
              height: 300,
              width: 500,
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: Stack(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text(
                              "Indycar Por NodoSports",
                              style: TextStyle(fontSize: 29, color: gradBlue),
                            ),
                            Container(
                              height: 100,
                              width: screenWidth * 0.8,
                              decoration: BoxDecoration(
                                  color: gradBlue,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                "assets/images/gun.png",
                                                height: 30,
                                              ),
                                              const Text(
                                                "Carrera",
                                                style: TextStyle(
                                                    fontSize: 21,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 1, // The thickness of the line
                                          color: Colors
                                              .white, // The color of the line
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                "assets/images/f1.png",
                                                height: 30,
                                              ),
                                              const Text(
                                                "GB Hungria",
                                                style: TextStyle(
                                                    fontSize: 21,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 1, // The thickness of the line
                                          color: Colors
                                              .white, // The color of the line
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Image.asset(
                                                "assets/images/txt.png",
                                                color: gradOrange,
                                              ),
                                              const SizedBox(height: 10),
                                              const Text(
                                                "Finalizado",
                                                style: TextStyle(
                                                    fontSize: 21,
                                                    color: Colors.white),
                                              )
                                            ],
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
                      ),
                      Positioned(
                        top: 130,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Card(
                              elevation: 10,
                              child: Container(
                                height: 120,
                                width: screenWidth * 0.20,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Card(
                              elevation: 10,
                              child: Container(
                                height: 120,
                                width: screenWidth * 0.20,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Card(
                              elevation: 10,
                              child: Container(
                                height: 120,
                                width: screenWidth * 0.20,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: [],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      )
                    ]),
                  )
                ],
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     decoration: BoxDecoration(
            //         color: Colors.blue.shade100,
            //         borderRadius: BorderRadius.circular(5)),
            //     width: double.infinity,
            //     height: screenHeight / 3.5,
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Column(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.symmetric(
            //                   vertical: 15.0, horizontal: 25),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   SizedBox(
            //                     height: 70,
            //                     child: Column(
            //                       mainAxisAlignment:
            //                           MainAxisAlignment.spaceBetween,
            //                       children: [
            //                         Image.asset("assets/images/f1.png"),
            //                         const Text(
            //                           "GB Hungria",
            //                           style: TextStyle(fontSize: 21),
            //                         )
            //                       ],
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     height: 70,
            //                     child: Column(
            //                       mainAxisAlignment: MainAxisAlignment.end,
            //                       children: [
            //                         Image.asset("assets/images/txt.png"),
            //                         const SizedBox(height: 10),
            //                         const Text(
            //                           "Finalizado",
            //                           style: TextStyle(fontSize: 21),
            //                         )
            //                       ],
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     height: 70,
            //                     child: Column(
            //                       mainAxisAlignment:
            //                           MainAxisAlignment.spaceBetween,
            //                       children: [
            //                         Image.asset("assets/images/gun.png"),
            //                         const Text(
            //                           "Carrera",
            //                           style: TextStyle(fontSize: 21),
            //                         )
            //                       ],
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   SizedBox(
            //                       height: screenHeight / 6.9,
            //                       width: screenWidth / 3.3,
            //                       child: Card(
            //                         color: Colors.blue.shade300,
            //                         child: Column(
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.center,
            //                             children: [
            //                               Image.asset("assets/images/cup.png"),
            //                               const Text(
            //                                 "Formula 1",
            //                                 style: TextStyle(fontSize: 18),
            //                               )
            //                             ]),
            //                       )),
            //                   SizedBox(
            //                       height: screenHeight / 6.9,
            //                       width: screenWidth / 3.3,
            //                       child: Card(
            //                         color: Colors.blue.shade300,
            //                         child: Column(
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.center,
            //                             children: [
            //                               Image.asset(
            //                                   "assets/images/handle.png"),
            //                               const Text(
            //                                 "ENV VIVO",
            //                                 style: TextStyle(fontSize: 18),
            //                               )
            //                             ]),
            //                       )),
            //                   SizedBox(
            //                       height: screenHeight / 6.9,
            //                       width: screenWidth / 3.3,
            //                       child: Card(
            //                         color: Colors.blue.shade300,
            //                         child: Column(
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.center,
            //                             children: [
            //                               Image.asset("assets/images/cal.png"),
            //                               Text(
            //                                 " ${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
            //                                 style:
            //                                     const TextStyle(fontSize: 18),
            //                               )
            //                             ]),
            //                       )),
            //                 ])
            //           ]),
            //     ),
            //   ),
            // ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Latest Updates",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            blogListWidget(screenWidth, posts),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Moto GP",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            blogListWidget(screenWidth, gpList),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "F1 (R)",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            blogListWidget(screenWidth, f1List),
            //   SizedBox(
            //   height: 300,
            //   width: screenWidth-20,
            //   child: ListView.builder(
            //     //physics: const NeverScrollableScrollPhysics(),
            //     scrollDirection: Axis.horizontal,
            //     itemCount: f1List.length,
            //     itemBuilder: (context, index) {
            //       Map post = f1List[index];
            //       return Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: FutureBuilder(
            //            future:getAllpost(),
            //           builder: ((context, snapshot){
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const Padding(
            //           padding: EdgeInsets.all(8.0),
            //           child: Center(
            //             child: CircularProgressIndicator(),
            //           ),
            //         );
            //       }
            //       if (snapshot.hasError) {
            //         return const Padding(
            //           padding: EdgeInsets.all(8.0),
            //           child: Center(
            //             child: Text('Try Again'),
            //           ),
            //         );
            //       } else {
            //         return InkWell(
            //             onTap: () {
            //                         Navigator.push(
            //                           context,
            //                           MaterialPageRoute(
            //                               builder: (context) => HTMLVIew(
            //                                     data: snapshot.data!.items![index],
            //                                   )),
            //                         );
            //                       },
            //             child: Container(
            //               height: 300,
            //               width: screenWidth-10,
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10)
            //               ),
            //               child: Stack(
            //                 children: [
            //                   Positioned(
            //                     top: 0,
            //                     child: SizedBox(
            //                       height: 300,
            //                       width: screenWidth,
            //                       child: Image.network(post["imageLink"],fit: BoxFit.cover, )),
            //                   ),
            //                   Positioned(
            //                     bottom: 0,
            //                     child: Container(
            //                     width: screenWidth,
            //                     height: 60,
            //                     color: Colors.black.withOpacity(0.5),
            //                     child: Center(child: Text(post["title"], textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 20),)) ))
            //                 ],
            //               ),
            //             ),
            //           );
            //       }
            //           }),
            //         ),
            //       );
            //       }),
            // )
          ]),
        ),
      ),
    );
  }

  Widget blogListWidget(double screenWidth, List<Map<String, String?>> blogs) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [gradBlue, gradOrange]),
      ),
      height: 500,
      width: screenWidth - 5,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          Map<String, String?> post =
              blogs[index]; // Explicitly cast to Map<String, String?>
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 8),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogDetailsScreen(post: post),
                  ),
                );
              },
              child: Container(
                //height: 400,
                width: screenWidth / 1.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        height: 450,
                        //width: ,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: CachedNetworkImage(
                            imageUrl: post["imageLink"] ?? '',
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: screenWidth / 1.5,
                        height: 60,
                        color: Colors.black.withOpacity(0.5),
                        child: Center(
                          child: Text(
                            post["title"] ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
