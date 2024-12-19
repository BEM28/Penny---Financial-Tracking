import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:penny/data/models/transaction_model.dart';
import 'package:penny/utils/constants.dart';
import 'package:penny/utils/currency_formater.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class cardHistory extends StatelessWidget {
  const cardHistory({
    super.key,
    required this.data,
    this.onDelete,
  });

  final TransactionModel data;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.5,
        motion: const DrawerMotion(),
        dragDismissible: true,
        children: [
          SlidableAction(
            onPressed: (context) async {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirm Deletion'),
                    content: Text('Are you sure you want to delete this data?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: onDelete,
                        child: Text('Yes'),
                      ),
                    ],
                  );
                },
              );
            },
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.red,
            label: 'Delete',
            padding: const EdgeInsets.only(right: 20),
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.tertiary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.secondary),
                shape: BoxShape.circle,
              ),
              child: Icon(
                  data.category == 'income'
                      ? Icons.arrow_downward_rounded
                      : Icons.arrow_upward_rounded,
                  size: 28,
                  color: AppColors.secondary),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.description,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    DateFormat('dd/MM/y').format(data.date),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.secondary.withValues(alpha: .6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  formatRupiah(data.amount),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: data.category == 'income'
                        ? AppColors.green
                        : AppColors.red,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
