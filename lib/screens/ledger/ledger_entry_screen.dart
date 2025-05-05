import 'package:flutter/material.dart';
import '../../models/customer.dart';

class LedgerEntryScreen extends StatefulWidget {
  @override
  _LedgerEntryScreenState createState() => _LedgerEntryScreenState();
}

class _LedgerEntryScreenState extends State<LedgerEntryScreen> {
  List<Customer> _customers = [
  Customer(name: 'Ravi Traders', balance: 1500),
  Customer(name: 'Anu Kirana', balance: -750),
  Customer(name: 'Vishal Medicals', balance: 3200),
];

  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  void _showAddEntryModal({Customer? customer, bool isCredit = true}) {
    _amountController.clear();
    _noteController.clear();
    _nameController.clear();

    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (customer == null)
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Customer Name'),
              ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(labelText: 'Note'),
            ),
            ElevatedButton(
              child: Text('Save Entry'),
              onPressed: () {
                final amount = double.tryParse(_amountController.text) ?? 0.0;
                final name = customer?.name ?? _nameController.text.trim();

                if (name.isEmpty || amount <= 0) return;

                setState(() {
                  if (customer != null) {
                    customer.balance += isCredit ? amount : -amount;
                  } else {
                    _customers.add(Customer(
                        name: name,
                        balance: isCredit ? amount : -amount));
                  }
                });

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _deleteCustomer(int index) {
    setState(() {
      _customers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ledger')),
      body: _customers.isEmpty
          ? Center(child: Text('No customers yet.'))
          : ListView.builder(
              itemCount: _customers.length,
              itemBuilder: (ctx, index) {
                final customer = _customers[index];
                return ListTile(
                  title: Text(customer.name),
                  subtitle:
                      Text('Balance: ₹${customer.balance.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.red),
                        onPressed: () => _showAddEntryModal(
                            customer: customer, isCredit: false),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.green),
                        onPressed: () => _showAddEntryModal(
                            customer: customer, isCredit: true),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.grey),
                        onPressed: () => _deleteCustomer(index),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEntryModal(),
        child: Icon(Icons.person_add),
        tooltip: 'Add New Customer',
      ),
    );
  }
}
