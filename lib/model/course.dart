class Course {
  final String id;
  final String name;
  final List<String> studentIds = [];

  Course({required this.id, required this.name});

  void addStudent(String studentId) {
    if(studentId.isEmpty) {
      throw Exception('Student ID cannot be empty');
    }

    if (studentIds.contains(studentId)) {
      throw Exception('Student already enrolled in this course');
    }
    studentIds.add(studentId);
  }
}
