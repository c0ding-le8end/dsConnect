class StudentObject {
   List<Stud> stud;

  StudentObject({this.stud});

  StudentObject.fromJson(Map<String, dynamic> json) {
    if (json['stud'] != null) {
      stud = <Stud>[];
      json['stud'].forEach((v) {
        stud.add(new Stud.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stud != null) {
      data['stud'] = this.stud.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stud {
   String usn;
  String name;
  String branch;
  int semester;
  String dob;
   int phNo;
double cia1;
double cia2;
double cia3;
double aat;

  Stud(
      { this.usn,  this.name,  this.branch,  this.semester, this.dob,this.phNo,this.cia1});

  Stud.fromJson(Map<String, dynamic> json) {
    usn = json['usn'];
    name = json['name'];
    branch = json['branch'];
    semester = json['semester'];
    dob = json['dob'];
    phNo = json['ph_no'];
    cia1=json['cia1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usn'] = this.usn;
    data['name'] = this.name;
    data['branch'] = this.branch;
    data['semester'] = this.semester;
    data['dob'] = this.dob;
    data['ph_no'] = this.phNo;
    data['cia1']=this.phNo;
    return data;
  }
}
