import 'package:ds_connect/student.dart';
import 'package:ds_connect/student_network.dart';
import 'package:flutter/material.dart';

class ClassRoom extends StatefulWidget {

  const ClassRoom({Key key}) : super(key: key);

  @override
  _ClassRoomState createState() => _ClassRoomState();
}

class _ClassRoomState extends State<ClassRoom> {
  Future<StudentObject> vlist;
  StudentObject vlist2;
  @override
  void initState() {
    // TODO: implement initState
    sample();
    super.initState();

  }

  void sample() async{
     StudentData().getdata().then((value) {
      vlist2=value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: vlist,
        builder: (context,AsyncSnapshot snapshot){
          if (snapshot.hasData)
            {
              return Center(child: Text("${snapshot.data.stud[42].name} ${snapshot.data.stud[42].usn} ${snapshot.data.stud[42].phNo}"));
            }
          else {debugPrint(vlist2.toString());
            return
              Center(child: CircularProgressIndicator());

          }
        },
      ),
    );
  }
}
