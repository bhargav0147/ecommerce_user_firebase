import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user_firebase/controller/ecom_controller.dart';
import 'package:ecommerce_user_firebase/model/ecom_model.dart';
import 'package:ecommerce_user_firebase/utlis/ecoom_firebasehelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  EcomController controller = EcomController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.amber,
              title: Text(
                "Ecommerce",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              elevation: 0,
              actions: [
                InkWell(
                  onTap: () {
                    Get.toNamed('/cart');
                  },
                  child: Icon(
                    Icons.shopping_cart,color: Colors.black,size: 25,
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            body: StreamBuilder(
              stream: FirebaseHelper.helper.readData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.black,
                      size: 30,
                    ),
                  );
                } else if (snapshot.hasData) {
                  List<EcomModel> dataList = [];
                  QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;
                  for (var x in data!.docs) {
                    String pid = x.id;
                    Map m1 = x.data();
                    EcomModel model = EcomModel(
                      id: pid,
                        title: m1['title'],
                        des: m1['description'],
                        price: m1['price'],
                        category: m1['category'],
                        image: m1['image']);
                    dataList.add(model);
                  }

                  return Center(
                      child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Row(
                            children: [
                              Image.network(
                                '${dataList[index].image}',
                                height: 60,
                                width: 60,
                              ),
                              SizedBox(width: 20),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${dataList[index].title}",
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: Colors.black,
                                        fontSize: 20),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "${dataList[index].des}",
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: Colors.black,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                    FirebaseHelper.helper.addNotes(dataList[index]);
                                    },
                                    child: Icon(
                                      Icons.add_shopping_cart,color: Colors.amber,size: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "₹${dataList[index].price}",
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: Colors.black,
                                        fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10)
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: dataList.length,
                  ));
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              },
            )));
  }
}
