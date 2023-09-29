import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/models/index.dart';

class ServiceAPI {
  static const String URLI = "https://fair-mite-gaiters.cyclic.cloud";

  static Future<Groups> getGroup(String username) async {
    try {
      final response = await http.get(
        Uri.parse("$URLI/group/$username"),
        headers: {
          'Content-Type': 'application/json', // Adjust content type as needed
          'Access-Control-Allow-Origin':
              '*', // Replace '*' with your actual allowed origin
          // Add more headers if necessary
        },
      );

      if (200 == response.statusCode) {
        print(parsegroups(response.body));
        return parsegroups(response.body);
      } else {
        return Groups();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Groups();
    }
  }

  static Groups parsegroups(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<Group> groups =
        parsed.map<Group>((json) => Group.fromJson(json)).toList();
    Groups g = Groups();
    g.groups = groups;
    return g;
  }

  static Future<Members> getmember(String username, String groupname) async {
    try {
      final response = await http.get(
        Uri.parse("$URLI/membergroup/$username/$groupname"),
        headers: {
          'Content-Type': 'application/json', // Adjust content type as needed
          'Access-Control-Allow-Origin':
              '*', // Replace '*' with your actual allowed origin
          // Add more headers if necessary
        },
      );

      if (200 == response.statusCode) {
        return parsemember(response.body);
      } else {
        return Members();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Members();
    }
  }

  static Members parsemember(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<Member> members =
        parsed.map<Member>((json) => Member.fromJson(json)).toList();
    Members m = Members();
    m.members = members;
    return m;
  }

  //userdetail
  static Future<Users> getuserfromgroupdetail(String groupid) async {
    try {
      final response = await http.get(
        Uri.parse("$URLI/datauseringroup/$groupid"),
        headers: {
          'Content-Type': 'application/json', // Adjust content type as needed
          'Access-Control-Allow-Origin':
              '*', // Replace '*' with your actual allowed origin
          // Add more headers if necessary
        },
      );

      if (200 == response.statusCode) {
        return userfromgroupdetail(response.body);
      } else {
        return Users();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Users();
    }
  }

  static Users userfromgroupdetail(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<User> users = parsed.map<User>((json) => User.fromJson(json)).toList();
    Users u = Users();
    u.users = users;
    return u;
  }

  static addfriend(
      String usernameingroup, String groupname, String usernameNew) async {
    final Map<String, String> data = {
      "usernameingroup": usernameingroup,
      "groupname": groupname,
      "usernameNew": usernameNew
    };

    final response = await http.post(
      Uri.parse("$URLI/addfriendinGroup"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return true;
      // final Map<String, dynamic> responseData = json.decode(response.body);
      // final userModel = Usermodel.fromJson(responseData);

      // ทำการนำทางไปยังหน้า NavbarPage
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => NavbarPage(userModels: userModel),
      //   ),
      // );
    } else {
      throw Exception('Failed to add firend');
    }
  }
}
