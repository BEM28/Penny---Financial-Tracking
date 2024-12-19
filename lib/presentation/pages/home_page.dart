import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:penny/controllers/transaction_controller.dart';
import 'package:penny/data/models/transaction_model.dart';
import 'package:penny/presentation/widgets/app_field.dart';
import 'package:penny/presentation/widgets/card_hostory.dart';
import 'package:penny/presentation/widgets/card_tracker.dart';
import 'package:penny/presentation/widgets/category_selector.dart';
import 'package:penny/utils/constants.dart';
import 'package:penny/utils/currency_formater.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionController());
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          actions: [
            Text(
              DateFormat('dd/MM/y').format(DateTime.now()),
              style: TextStyle(
                color: AppColors.secondary,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      formatRupiah(controller.totalAmount.value),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 54,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirm Deletion'),
                            content: Text(
                                'Are you sure you want to delete all data?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  controller.clearTransaction();
                                  Get.back();
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: AppColors.red),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.sync, size: 20, color: AppColors.red),
                    ),
                  ),
                ],
              ),
              Text(
                'Total Amount',
                style: TextStyle(
                  color: AppColors.secondary.withValues(alpha: .6),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 150,
                child: Row(
                  children: [
                    CardTracker(
                      title: 'Income',
                      balance: formatRupiah(controller.income.value),
                    ),
                    const SizedBox(width: 8),
                    CardTracker(
                      title: 'Expanse',
                      balance: formatRupiah(controller.expanse.value),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'This Month',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.transactions.length,
                  itemBuilder: (context, index) {
                    final data = controller.transactions[index];
                    return Column(
                      children: [
                        cardHistory(
                          data: data,
                          onDelete: () {
                            controller.deleteTransaction(data.id);
                            Get.back();
                          },
                        ),
                        if (index == controller.transactions.length - 1)
                          SizedBox(height: 100),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            Get.bottomSheet(
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      Text(
                        'Description',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      AppField(
                        controller: controller.description,
                        keyboardType: TextInputType.multiline,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Amount',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      AppField(
                        controller: controller.amount,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Category',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            categorySelectector(
                              title: 'Income',
                              selected: controller.category.value == 'income',
                              onTap: () {
                                controller.category.value = 'income';
                              },
                            ),
                            categorySelectector(
                              title: 'Expanse',
                              selected: controller.category.value == 'expanse',
                              onTap: () {
                                controller.category.value = 'expanse';
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      Center(
                        child: SizedBox(
                          width: 250,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.addTransaction();
                            },
                            child: controller.isSave.value
                                ? const CircularProgressIndicator(
                                    color: AppColors.tertiary,
                                  )
                                : Text(
                                    'Save',
                                    style: TextStyle(
                                      color: AppColors.tertiary,
                                      fontSize: 18,
                                    ),
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
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: AppColors.secondary, shape: BoxShape.circle),
            child: Icon(
              Icons.add,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
