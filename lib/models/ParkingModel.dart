class SpotModel {

  final String id;
  final String parkingSpotNumber;
  final String licensePlateCar;
  final String brandCar;
  final String modelCar;
  final String colorCar;
  final String registrationDate;
  final String responsibleName;
  final String apartment;
  final String block;


  SpotModel(this.id, this.parkingSpotNumber,
      this.licensePlateCar, this.brandCar,
      this.modelCar, this.colorCar,
      this.registrationDate, this.responsibleName,
      this.apartment, this.block);


  SpotModel.fromJson(Map<String, dynamic> json) :
        id= json['id'],
        parkingSpotNumber= json['parkingSpotNumber'],
        licensePlateCar= json['licensePlateCar'],
        brandCar= json['brandCar'],
        modelCar= json['modelCar'],
        colorCar= json['colorCar'],
        registrationDate= json['registrationDate'],
        responsibleName= json['responsibleName'],
        apartment= json['apartment'],
        block= json['block'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'parkingSpotNumber': parkingSpotNumber,
    'licensePlateCar': licensePlateCar,
    'brandCar': brandCar,
    'modelCar': modelCar,
    'colorCar': colorCar,
    'registrationDate': registrationDate,
    'responsibleName': responsibleName,
    'apartment': apartment,
    'block': block,
  };

}