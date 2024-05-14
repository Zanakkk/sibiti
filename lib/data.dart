import 'package:hive/hive.dart';
part 'data.g.dart';

@HiveType(typeId: 1)
class Data {
  Data({required this.userId, required this.email});
  @HiveField(0)
  String userId;

  @HiveField(1)
  String email;
}
