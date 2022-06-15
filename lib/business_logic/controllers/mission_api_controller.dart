import 'dart:convert';

import 'package:airspector/business_logic/models/stages.dart';
import 'package:http/http.dart' as http;
import 'package:airspector/business_logic/models/points.dart';

class MissionApiController {
  String _skydioToken = "";
  String _points = "-1";

  Future<WayPoints> requestGeneratedMission(Stages stages) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    String body = jsonEncode(stages.toJson());
    print(body);
    final response = await http.post(
      Uri.parse(
          'https://g3n50ajpa9.execute-api.eu-central-1.amazonaws.com/default/mission_planner'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      _points = jsonEncode({"route": jsonDecode(response.body)});
      return WayPoints(jsonDecode(response.body)["route-meta"]["points"]);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to generate mission.');
    }
  }

  Future<String> loginSkydio() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json'
    };
    String body = jsonEncode({
      "client_id": "client#1",
      "requested_level": 8,
      "commandeer": true,
    });
    print(body);
    final response = await http.post(
      Uri.parse('http://192.168.10.1/api/authentication'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      String token = jsonDecode(response.body)["data"]["accessToken"];
      print(token);
      _skydioToken = token;
      return token;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to upload mission.');
    }
  }

  Future<String> skillsetSkydio() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + _skydioToken,
    };

    String body = jsonEncode({"args": {}});
    final response = await http.post(
      Uri.parse(
          'http://192.168.10.1/api/set_skill/airspector2.wp_flight_gps.WpFlightGps'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      print(response.body);
      //String token = jsonDecode(response.body);
      return response.body;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to upload mission.');
    }
  }

  Future<String> uploadMissionSkydioFromJson(String json) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + _skydioToken,
    };
    json = jsonEncode({"route": jsonDecode(json)});
    String body = jsonEncode({
      "data": base64.encode(utf8.encode(json)),
      "skill_key": 'airspector2.wp_flight_gps.WpFlightGps',
      "no_response": false,
    });
    final response = await http.post(
      Uri.parse('http://192.168.10.1/api/custom_comms'),
      headers: headers,
      body: body,
    );

    print(json);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)["data"]["data"];
      print(utf8.decode(base64.decode(data)));
      return utf8.decode(base64.decode(data));
    } else {
      throw Exception('Failed to upload mission.');
    }
  }

  Future<String> uploadMissionSkydio() => uploadMissionSkydioFromJson(jsonEncode({"route": _points}));

  /*
  import 'dart:convert';

main() {
  final str = "Hello world";
  final bytes = utf8.encode(str);
  final base64Str = base64.encode(bytes);
  print(base64Str);
}
  */

  void generateMissionFromRest(Stages data) {
    requestGeneratedMission(data);
  }

  /*Stages getFakeStages(){

    return 
  }*/
}
