import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'models/customer.dart';
import 'screens/ledger/ledger_entry_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    // Only run Hive setup on mobile/desktop
    // await Hive.initFlutter();
    // Hive.registerAdapter(CustomerAdapter());
    // await Hive.openBox<Customer>('customers');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OkCredit Open',
      theme: ThemeData(primarySwatch: Colors.green),
      home: LedgerEntryScreen(),
    );
  }
}
