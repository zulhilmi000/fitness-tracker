import 'package:hive/hive.dart';

part 'profile.g.dart';

@HiveType(typeId: 1)
class Profile extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String age;

  @HiveField(2)
  String goal;

  Profile({required this.name, required this.age, required this.goal});
}
