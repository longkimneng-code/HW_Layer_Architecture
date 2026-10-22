import '../model/student.dart';
import '../model/course.dart';
import '../model/score.dart';

class LmsSystem {
  final List<Student> students = [];
  final List<Course> courses = [];
  final List<Score> scores = [];

  void addStudent({required String studentId, required String studentName}) {
    // ! Student shall not exist already
    Student? student = _findStudentOrNull(studentId);
    if (student != null) {
      throw Exception('Student $student already exists');
    }

    students.add(Student(id: studentId, name: studentName));
  }
 
 
  void removeStudent({required String studentId}) {
    Student? student = _findStudentOrNull(studentId);
    if (student == null) {
      throw Exception('Student $studentId not found');
    }
    // 1- Remove student from the students list
    students.removeWhere((student) => student.id == studentId);
    // 2- Remove student from course
    for(final course in courses){
      course.studentIds.remove(studentId);
    }

    // Remove student from score
    scores.removeWhere((score) => score.studentId == studentId);
 
  }

  // find NUll
  Student? _findStudentOrNull(String studentId) {
    for (Student s in students) {
      if (s.id == studentId) {
        return s;
      }
    }
    return null; // not found
  } 

  Course? _findCourseOrNull(String courseId) {
    return courses.where((course) => course.id == courseId).firstOrNull;
  }

  void addCourse({required String courseId, required String courseName}) {
    // ! Course shall not exist already
    Course? course = _findCourseOrNull(courseId);
    if (course != null) {
      throw Exception('Course $course already exists');
    }

    courses.add(Course(id: courseId, name: courseName));
  }

  void removeCourse({required String courseId}) {
    Course? course = _findCourseOrNull(courseId);
    
    if (course == null) {
      throw Exception('Course $courseId not found');
    }

    if(course.studentIds.isNotEmpty || scores.any((score) => score.courseId == courseId)){
      throw Exception("Connot remove course ${course.name} because score or student exist");
    }

    courses.removeWhere((course) => course.id == courseId);
  }

  void addStudentToCourse({required String studentId, required String courseId}){
    final enroll = _findCourseOrNull(courseId);

    if(_findStudentOrNull(studentId) == null){
      throw Exception('Student $studentId not found');
    }
    if(enroll == null){
      throw Exception('Course $courseId not found');
    }

    enroll.addStudent(studentId);
  }


  void addScore({required String studentId, required String courseId, required int score}){
    final enroll = _findCourseOrNull(courseId);

    if(_findStudentOrNull(studentId) == null){
      throw Exception('Student $studentId not found');
    }
    if(enroll == null){
      throw Exception('Course $courseId not found');
    }

    if(!enroll.studentIds.contains(studentId)){
      throw Exception('Student $studentId is not enrolled in course $courseId');
    }

    scores.add(Score(studentId: studentId, courseId: courseId, score: score));

  }



  




}
