import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user_firebase/model/ecom_model.dart';
import 'package:ecommerce_user_firebase/utlis/ecoom_firebasehelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          ),
          title: Text(
            "Cart Screen",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          elevation: 0,
        ),
        body: StreamBuilder(
          stream: FirebaseHelper.helper.cartReadData(),
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
              List<EcomModel> cartDataList = [];
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
                cartDataList.add(model);
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
                                '${cartDataList[index].image}',
                                height: 60,
                                width: 60,
                              ),
                              SizedBox(width: 20),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${cartDataList[index].title}",
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: Colors.black,
                                        fontSize: 20),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "${cartDataList[index].des}",
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
                                      FirebaseHelper.helper.cartDeleteProduct(cartDataList[index].id!);
                                    },
                                    child: Icon(
                                      Icons.remove_circle_outline,color: Colors.red,size: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "₹${cartDataList[index].price}",
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
                    itemCount: cartDataList.length,
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
