import 'dart:convert';

class TaskModel {
  int? id;
  String name;
  String description;
  bool isCompleted;
  DateTime taskData;
  String startTime;
  String endTime;
  TaskModel(
    this.id,
    this.name,
    this.description,
    this.isCompleted,
    this.taskData,
    this.startTime,
    this.endTime,
  );

  TaskModel copyWith({
    int? id,
    String? name,
    String? description,
    bool? isCompleted,
    DateTime? taskData,
    String? startTime,
    String? endTime,
  }) {
    return TaskModel(
      id ?? this.id,
      name ?? this.name,
      description ?? this.description,
      isCompleted ?? this.isCompleted,
      taskData ?? this.taskData,
      startTime ?? this.startTime,
      endTime ?? this.endTime,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    if (id != null) result.addAll({'id': id});

    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'isCompleted': isCompleted ? 1 : 0});
    result.addAll({'taskData': taskData.toIso8601String()});
    result.addAll({'startTime': startTime});
    result.addAll({'endTime': endTime});
    result.addAll({'updatedDate': DateTime.now().toIso8601String()});

    return result;
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      map['id'] ?? 0,
      map['name'] ?? '',
      map['description'] ?? '',
      map['isCompleted'] == 1,
      DateTime.parse(map['taskData']),
      map['startTime'] ?? '',
      map['endTime'] ?? '',
    );
  }
}
