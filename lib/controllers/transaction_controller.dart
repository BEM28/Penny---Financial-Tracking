import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penny/data/models/transaction_model.dart';
import 'package:penny/data/repositories/transaction_repository.dart';

class TransactionController extends GetxController {
  var transactions = <TransactionModel>[].obs;
  final TransactionRepository repository = TransactionRepository();

  RxBool isSave = false.obs;
  RxString category = 'income'.obs;
  RxInt totalAmount = 0.obs;
  RxInt income = 0.obs;
  RxInt expanse = 0.obs;

  final description = TextEditingController();
  final amount = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
  }

  @override
  void onClose() {
    super.onClose();
    transactions.clear();
    category.value = 'income';
    isSave.value = false;
    description.clear();
    amount.clear();
  }

  void loadTransactions() {
    transactions.assignAll(repository.getAllTransactions());
    _calculateAmounts();
  }

  void addTransaction() {
    try {
      isSave.value = true;
      final transaction = TransactionModel(
        id: DateTime.now().toString(),
        description: description.text,
        amount: int.parse(amount.text),
        category: category.value,
        date: DateTime.now(),
      );
      repository.saveTransaction(transaction);
      transactions.add(transaction);
      _calculateAmounts();
    } catch (e) {
      print('error $e');
    } finally {
      isSave.value = false;
      category.value = 'income';
      description.clear();
      amount.clear();
    }
  }

  void deleteTransaction(String id) {
    repository.deleteTransaction(id);
    transactions.removeWhere((transaction) => transaction.id == id);
    _calculateAmounts();
  }

  void clearTransaction() {
    repository.clearAllStorage();
    _calculateAmounts();

    transactions.clear();
    totalAmount.value = 0;
    income.value = 0;
    expanse.value = 0;
    category.value = 'income';
    isSave.value = false;
    description.clear();
    amount.clear();
  }

  void _calculateAmounts() {
    int incomeAmount = 0;
    int expanseAmount = 0;

    for (var transaction in transactions) {
      if (transaction.category == 'income') {
        incomeAmount += transaction.amount;
      } else {
        expanseAmount += transaction.amount;
      }
    }

    totalAmount.value = (incomeAmount - expanseAmount).abs();
    income.value = incomeAmount;
    expanse.value = expanseAmount;
  }
}
