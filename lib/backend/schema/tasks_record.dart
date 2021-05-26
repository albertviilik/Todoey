import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'tasks_record.g.dart';

abstract class TasksRecord implements Built<TasksRecord, TasksRecordBuilder> {
  static Serializer<TasksRecord> get serializer => _$tasksRecordSerializer;

  @nullable
  String get description;

  @nullable
  @BuiltValueField(wireName: 'due_date')
  Timestamp get dueDate;

  @nullable
  bool get completed;

  @nullable
  String get owner;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(TasksRecordBuilder builder) => builder
    ..description = ''
    ..completed = false
    ..owner = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('tasks');

  static Stream<TasksRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  TasksRecord._();
  factory TasksRecord([void Function(TasksRecordBuilder) updates]) =
      _$TasksRecord;
}

Map<String, dynamic> createTasksRecordData({
  String description,
  Timestamp dueDate,
  bool completed,
  String owner,
}) =>
    serializers.serializeWith(
        TasksRecord.serializer,
        TasksRecord((t) => t
          ..description = description
          ..dueDate = dueDate
          ..completed = completed
          ..owner = owner));

TasksRecord get dummyTasksRecord {
  final builder = TasksRecordBuilder()
    ..description = dummyString
    ..dueDate = dummyTimestamp
    ..completed = dummyBoolean
    ..owner = dummyString;
  return builder.build();
}

List<TasksRecord> createDummyTasksRecord({int count}) =>
    List.generate(count, (_) => dummyTasksRecord);
