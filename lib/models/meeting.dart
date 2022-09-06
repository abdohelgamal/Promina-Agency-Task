import 'package:hive/hive.dart';
part 'meeting.g.dart';

//flutter packages pub run build_runner build

@HiveType(typeId: 2)
enum Category {
  @HiveField(0)
  development,
  @HiveField(1)
  research,
  @HiveField(2)
  design,
  @HiveField(3)
  backend
}

@HiveType(typeId: 1)
class Meeting {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime startTime;
  @HiveField(3)
  DateTime endTime;
  @HiveField(4)
  DateTime date;
  @HiveField(5)
  Category category;
  Meeting(
      {required this.title,
      required this.description,
      required this.category,
      required this.date,
      required this.startTime,
      required this.endTime});
  factory Meeting.fromMap(Map<String, dynamic> map) {
    // int categoryNum = map['category'];
    // Category category = Category.values[categoryNum];
    return Meeting(
        title: map['title'],
        description: map['description'],
        category: map['category'],
        date: map['date'],
        startTime: map['start'],
        endTime: map['end']);
  }
  Map<String, dynamic> toMap(Map<String, dynamic> map) {
    return {
      'title': title,
      'description': description,
     // 'category': category.index,
     'category':category,
      'date': date,
      'start': startTime,
      'end': startTime,
    };
  }
}
