import "package:http/http.dart";
import 'dart:convert';

class WorldTime {
  String location; // Location name for the UI
  String time = ""; // Time of that location;
  String flag; // URL to an asset flag icon
  String url; // Endpoint url

  WorldTime({required this.location, required this.flag, required this.url});

  /* If we want to use the value updated by a method of a class which is async then we have to make the return type as Future<generic type> so that it will promise the invocation that wait for me I am returning the valuee and only then print that pomised (returned/updated) value */

  Future<void> getTime() async {
    // TODO: simulate network request for a username

    // await blocks, without await we get non-blocking output

    Response response =
        await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));

    Map data = jsonDecode(response.body);

    // print(data);

    // Get properties from data

    String dt = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);

    // Create DateTime object
    DateTime now = DateTime.parse(dt);
    now = now.add(Duration(hours: int.parse(offset)));

    // Set Time Property
    time = now.toString();
  }
}
