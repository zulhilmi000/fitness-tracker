import 'package:hive/hive.dart';

part 'activity_model.g.dart';

@HiveType(typeId: 0)
class ActivityModel extends HiveObject {
  @HiveField(0)
  String type;

  @HiveField(1)
  int duration;

  @HiveField(2)
  int calories;

  ActivityModel({
    required this.type,
    required this.duration,
    required this.calories,
  });
}
