import "package:http/http.dart";
import 'dart:convert';
import "package:intl/intl.dart";

class WorldTime {
  String location; // Location name for the UI
  String time = ""; // Time of that location;
  String flag; // URL to an asset flag icon
  String url; // Endpoint url
  bool isDayTime = true;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // Get properties from data
      String dt = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // Create DateTime object
      DateTime now = DateTime.parse(dt);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;

      // Set Time Property
      time = DateFormat.jm().format(now);
    } catch (e) {
      // Handle exceptions here, such as logging or displaying an error message
      print('Error: $e');
    }
  }
}
