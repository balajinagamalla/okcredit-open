import 'package:hive/hive.dart';

part 'customer.g.dart';

@HiveType(typeId: 0)
class Customer extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double balance;

  Customer({required this.name, required this.balance});
}
