import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vms/helper/colors.dart';
import 'package:vms/screens/client/dashboard/client_dashboard_controller.dart';

class ClientDashboardScreen extends GetView<ClientDashboardController> {
  ClientDashboardScreen({Key? key}) : super(key: key);

  @override
  final controller=Get.put(ClientDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.25),
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16),bottomRight: Radius.circular(16),),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: AssetImage('assets/vms/app_logo.png'),
                            radius: 20,
                          ),
                          const SizedBox(width: 8,),
                          Column(
                            children: [
                              const SizedBox(height: 6,),
                              const Text('VMS', style: TextStyle(color: primary, fontWeight: FontWeight.w900, fontSize: 16),),
                              Transform.translate(
                                  offset: const Offset(2,-8),
                                  child: const Text('Client', style: TextStyle(color: primary, fontSize: 12),)),
                            ],
                          ),
                        ],
                      ),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.exit_to_app),)
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider('https://media.geeksforgeeks.org/wp-content/post-ads-banner/2021-12-29-16-30-50-CIP_Icon.png'),
                          radius: 25,
                          backgroundColor: Colors.grey,
                        ),
                        const SizedBox(width: 16,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Chithra", style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                            Text("I2I Software", style: TextStyle(color: Colors.black87),),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16,),
                      const Text('Monthly Analytics', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),),
                      //setGraph
                      const SizedBox(height: 60,),
                      const Text('Visitor Analytics', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),),
                      ...List.generate(3, (index) => buildNewCard({
                        "title":"Test",
                        "value":"100"
                      }, index))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildNewCard(var item, var index) {
    return GestureDetector(
      onTap: () {
        Get.focusScope?.unfocus();
        // controller.onCardClicked(item);
      },
      child: Container(
        height: 130,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            gradient: gradients[index % 3],
            boxShadow: [
              BoxShadow(
                  offset: const Offset(10, 20),
                  blurRadius: 10,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.05)),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      shape: BoxShape.circle),
                  child: CachedNetworkImage(
                    imageUrl: item['icon'] ?? index == 0
                        ? 'https://cdn-icons-png.flaticon.com/512/1747/1747119.png'
                        : index == 1
                        ? 'https://cdn-icons.flaticon.com/png/512/4514/premium/4514958.png?token=exp=1659088484~hmac=90cf6ce74e92970e1fe545672b9b5015'
                        : 'https://cdn-icons-png.flaticon.com/512/3284/3284598.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  '${item['title']}',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Text(
              '${item['value']}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }



}

