import 'dart:convert';


import 'package:ds_connect/student.dart';
import 'package:http/http.dart';


class  StudentData
{




  Future<StudentObject> getdata() async
  {
    var url = Uri.parse("https://script.googleusercontent.com/macros/echo?user_content_key=37EV7weXVEj3xUZrZvbPirvtMz7uWt6ETTyKXNO8KSZPE-9byI5SaMRpOgrX2eLbNBYdAJoScWHohfu7tDqn1jqYXW-vgA_6m5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnB2bgYKxKPaNxBbkpy2-XPoIuJPcPSR5KKkWt1sxk1IGoXNuu7ewZpcgCSc0TSEq98w35qy01r4M0m83_ky8Txz3XY3bqlWMbA&lib=MaUHIP6gJKB6MA9r5XZky-m5lrB3aPbYp");
    print("$url");
    Response response = await get(url);
    //var http;
    //var response=await http.get(Uri.parse('https://script.googleusercontent.com/macros/echo?user_content_key=jGy0QYwe1tYuI22Vay40GAekIEkLF2G0Sum-d8YJ5HNkg6oXSxLuNPxV-eDTPhganwCyolgun7mKfdHP2zOARs-OiSY6Dqf4m5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnFSE23GGebtYwZ_l0pds0oZE5cH-lq6JB-fK6Go93-jwsyg0SAv31oyd9btpgQeGrJfIU96C2BoGJ-kwXjh30fXx8tCAbZ6FPw&lib=MaUHIP6gJKB6MA9r5XZky-m5lrB3aPbYp'));
    if(response.statusCode==200)
    {
      return StudentObject.fromJson(json.decode(response.body));
    }
    else
    {
      throw Exception("Error recieving data");
    }
  }
}