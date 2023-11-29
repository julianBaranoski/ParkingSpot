
import 'package:final_parking_sport/models/ParkingModel.dart';

class ParkingSpotList {

  final List<SpotModel> listParkingSpotModel;

  ParkingSpotList(this.listParkingSpotModel);

  ParkingSpotList.fromJson(List<dynamic> json):
        listParkingSpotModel = List.from(json).map((item) => SpotModel.fromJson(item)).toList() ;

}