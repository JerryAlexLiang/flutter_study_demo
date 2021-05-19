import 'package:flutter/material.dart';

///简单列表 + 路由动画

class SimpleListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'ListView',
    //   home: StudentList(
    //     students:
    //         List.generate(20, (index) => Student('学生 $index', '学生编号: $index')),
    //   ),
    // );

    return Scaffold(
          // appBar: AppBar(
          //   title: Text('ListView'),
          // ),
          body: StudentList(
            students:
                List.generate(20, (index) => Student('学生 $index', '学生编号: $index')),
          ),
        );
  }
}


class Student {
  String name;
  String number;

  Student(this.name, this.number);
}

//自定义组件
class StudentList extends StatelessWidget {
  final List<Student> students;

  StudentList({Key key, this.students}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('学生列表'),
        elevation: 0.0,
      ),
      body: ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(students[index].name),
              onTap: () {
//                Scaffold.of(context).showSnackBar(SnackBar(content: Text(students[index].name)));
                Navigator.push(
                  context,
//                    MaterialPageRoute(builder: (context) => new FirstPage()));
                  MaterialPageRoute(
                      builder: (context) =>
                          new StudentDetail(student: students[index])),
                );
              },
            );
          }),
    );
  }
}

class StudentDetail extends StatelessWidget {
  final Student student;

  const StudentDetail({Key key, this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('学生详情-${student.name}'),
      ),
      body: Center(
        child: Text('学生姓名: ${student.name}  ' + '\n' + '编号: ${student.number}'),
      ),
    );
  }
}
