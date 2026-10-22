import 'package:test/test.dart';
import '../lib/service/lms_system.dart';

void main() {
  test('creates and removes a student', () {
    final lms = LmsSystem();

    lms.addStudent(studentId: 'S1', studentName: 'Ronan');

    expect(lms.students.length, 1);
    expect(lms.students.first.name, 'Ronan');

    lms.removeStudent(studentId: 'S1');

    expect(lms.students.length, 0);
  });

  test('creates and removes a course', () {
    final lms = LmsSystem();

    lms.addCourse(courseId: 'C1', courseName: 'Flutter');

    expect(lms.courses.length, 1);

    lms.removeCourse(courseId: 'C1');

    expect(lms.courses.length, 0);
  });

  test('enrolls a student in a course', () {
    final lms = LmsSystem();

    lms.addStudent(studentId: 'S1', studentName: 'Ronan');
    lms.addCourse(courseId: 'C1', courseName: 'Dart');

    lms.addStudentToCourse(studentId: 'S1', courseId: 'C1');

    expect(lms.courses.first.studentIds, contains('S1'));
  });

  test('adds a score for an enrolled student', () {
    final lms = LmsSystem();

    lms.addStudent(studentId: 'S1', studentName: 'Ronan');
    lms.addCourse(courseId: 'C1', courseName: 'Dart');

    lms.addStudentToCourse(studentId: 'S1', courseId: 'C1');

    lms.addScore(studentId: 'S1', courseId: 'C1', score: 90);

    expect(lms.scores.length, 1);
    expect(lms.scores.first.score, 90);
  });

  test('removing a student also removes their enrollment and score', () {
    final lms = LmsSystem();

    lms.addStudent(studentId: 'S1', studentName: 'Ronan');
    lms.addCourse(courseId: 'C1', courseName: 'Dart');

    lms.addStudentToCourse(studentId: 'S1', courseId: 'C1');
    lms.addScore(studentId: 'S1', courseId: 'C1', score: 90);

    lms.removeStudent(studentId: 'S1');

    expect(lms.students, isEmpty);
    expect(lms.courses.first.studentIds, isEmpty);
    expect(lms.scores, isEmpty);
  });
}