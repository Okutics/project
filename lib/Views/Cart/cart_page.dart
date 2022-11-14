
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Controllers/home_controller.dart';
import 'package:project/Helper/colors.dart';
import 'package:project/Helper/common_app_bar.dart';
import 'package:project/Helper/session.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return CommonAppBar(
          title: 'Order Summary',
          bottomBar: GestureDetector(
            onTap: () {
              if(controller.cartCount.isNotEmpty){
                controller.cartCount.clear();
                controller.cartItems.clear();
                controller.cartItemCount =0;
                controller.cartTotal =0;
                toastMsg(context, 'Order successfully placed');
                Get.offAndToNamed('home');
              }
              else{
                toastMsg(context, 'No items in your cart');
              }
            },
            child: Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: colors.darkGreen,
              ),
              child: Center(
                child: Text(
                  'Place Order',
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: colors.white),
                ),
              ),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Card(
                  margin: const EdgeInsets.all(15),
                  elevation: 5,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: colors.darkGreen,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            '${controller.cartItems.length} Dishes - ${controller.cartItemCount} Items',
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    color: colors.white,
                                    fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.cartCount.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: colors.lightWhite,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: controller.cartCount[index][1] == 2
                                            ? colors.green
                                            : colors.maroon,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.circle,
                                      size: 14,
                                      color: controller.cartCount[index][1] == 2
                                          ? colors.green
                                          : colors.maroon,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                controller.cartCount[index][2],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "INR ${controller.cartCount[index][3]}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "${controller.cartCount[index][4]} Calories",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    width: 122,
                                    decoration: BoxDecoration(
                                      color: colors.darkGreen,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.remove,
                                            color: colors.white,
                                          ),
                                          splashRadius: 15,
                                          onPressed: () {
                                            if (controller.cartItems.contains(
                                                controller.cartCount[index][0])) {
                                              for (var i = 0;
                                                  i < controller.cartCount.length;
                                                  i++) {
                                                if (controller.cartCount[i][0] ==
                                                    controller.cartCount[index]
                                                        [0]) {
                                                  if (controller.cartCount[i][4] >
                                                      0) {
                                                    controller.cartCount[i][4] -=
                                                        1;
                                                    controller.cartItemCount -= 1;
                                                    controller.cartTotal -=
                                                        controller.cartCount[i]
                                                            [3];
                                                  }
                                                  if (controller.cartCount[i]
                                                          [4] ==
                                                      0) {
                                                    controller.cartItems
                                                        .removeAt(i);
                                                    controller.cartCount
                                                        .removeAt(i);
                                                  }
                                                }
                                              }
                                            }
                                            controller.update();
                                          },
                                        ),
                                        if (controller.cartItems.contains(
                                            controller.cartCount[index][0]))
                                          for (var i = 0;
                                              i < controller.cartCount.length;
                                              i++)
                                            if (controller.cartCount[i][0] ==
                                                controller.cartCount[index][0])
                                              Text(
                                                controller.cartCount[i][4]
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3!
                                                    .copyWith(
                                                        color: colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                        if (!controller.cartItems.contains(
                                            controller.cartCount[index][0]))
                                          Text(
                                            0.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3!
                                                .copyWith(
                                                    color: colors.white,
                                                    fontWeight: FontWeight.bold),
                                          ),
                                        IconButton(
                                          icon: const Icon(Icons.add,
                                              color: colors.white),
                                          splashRadius: 15,
                                          onPressed: () {
                                            for (var i = 0;
                                                i < controller.cartCount.length;
                                                i++) {
                                              if (controller.cartCount[i][0] ==
                                                  controller.cartCount[index]
                                                      [0]) {
                                                controller.cartCount[i][4] += 1;
                                                controller.cartItemCount += 1;
                                                controller.cartTotal +=
                                                    controller.cartCount[i][3];
                                              }
                                            }
                                            controller.update();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "INR ${(controller.cartCount[index][3] * controller.cartCount[index][4]).toStringAsFixed(2)}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Amount',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'INR ${controller.cartTotal.toStringAsFixed(2)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: colors.green),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
