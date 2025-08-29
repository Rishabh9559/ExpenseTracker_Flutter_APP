import 'package:flutter/material.dart';
import 'dart:io';


class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}


class _ExpenseTrackerState extends State<ExpenseTracker> {
  // Controllers for title and amount
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  // List to store expenses
  List<Map<String, dynamic>> expenses = [];

  // Add expense
  void addExpense() {
    if (titleController.text.isEmpty || amountController.text.isEmpty) return;

    setState(() {
      expenses.add({
        "title": titleController.text,
        "amount": double.tryParse(amountController.text) ?? 0,
      });
      // clear inputs
      titleController.clear();
      amountController.clear();
    });
  }

  // Calculate total
  double get totalExpense {
    return expenses.fold(0, (sum, item) => sum + item["amount"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        leading: const Icon(Icons.menu),
        actions: [
          // IconButton(onPressed: () {}, icon: const Icon(Icons.logout))
          IconButton(
            onPressed: () {
              exit(0); // force close the app
            },
            icon: const Icon(Icons.logout),
          ),

        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Total
            Text(
              "Total Expense: ₹${totalExpense.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Input fields
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Expense title (e.g. Food, Groceries)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Enter amount",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Button
            ElevatedButton(
              onPressed: addExpense,
              child: const Text("Add Expense"),
            ),
            const SizedBox(height: 20),

            // Show expense list
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(expenses[index]["title"]),
                    trailing:
                    Text("₹${expenses[index]["amount"].toStringAsFixed(2)}"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
