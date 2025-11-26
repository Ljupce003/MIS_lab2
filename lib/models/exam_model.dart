

class ExamModel{
  String name;
  DateTime dateTime;
  List<String> examRooms;

  ExamModel({required this.name,required this.dateTime,required this.examRooms});


  @override
  String toString() {
    return 'ExamModel{name: $name, dateTime: $dateTime, examRooms: $examRooms}';
  }
}