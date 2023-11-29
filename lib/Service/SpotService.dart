
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ParkingModel.dart';
import '../models/SpotList.dart';

class Api {
  static const String baseUrl = "https://parking-spot-238adfbb7467.herokuapp.com/parking-spot";

  static Future<void> createSpot(SpotModel spotModel) async {
    try {
      final url = '$baseUrl/save';
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        body: jsonEncode(spotModel),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        // Spot added successfully
      } else {
        throw Exception('Error adding the new spot!');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  static Future<void> editSpot(SpotModel updatedSpot) async {
    try {
      final url = '$baseUrl/${updatedSpot.id}';
      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode(updatedSpot.toJson()),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Editing successful
      } else {
        throw Exception('Error editing the spot. Status code: ${response.statusCode}, Response: ${response.body}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  static Future<ParkingSpotList> fetchSpot() async {
    try {
      final url = '$baseUrl/list';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> list = jsonDecode(response.body);
        return ParkingSpotList.fromJson(list);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  static Future<void> deleteSpot(String id) async {
    try {
      final url = '$baseUrl/delete/$id';
      final response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        // Deletion successful
      } else {
        throw Exception('Failed to delete the spot');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
