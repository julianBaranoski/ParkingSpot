import 'package:flutter/material.dart';
import '../Service/SpotService.dart';
import '../models/ParkingModel.dart';

class EditPage extends StatefulWidget {
  final SpotModel spot;

  const EditPage({Key? key, required this.spot}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController _parkingSpotNumberController = TextEditingController();
  TextEditingController _licensePlateCarController = TextEditingController();
  TextEditingController _brandCarController = TextEditingController();
  TextEditingController _modelCarController = TextEditingController();
  TextEditingController _colorCarController = TextEditingController();
  TextEditingController _responsibleNameController = TextEditingController();
  TextEditingController _apartmentController = TextEditingController();
  TextEditingController _blockController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _parkingSpotNumberController.text = widget.spot.parkingSpotNumber;
    _licensePlateCarController.text = widget.spot.licensePlateCar;
    _brandCarController.text = widget.spot.brandCar;
    _modelCarController.text = widget.spot.modelCar;
    _colorCarController.text = widget.spot.colorCar;
    _responsibleNameController.text = widget.spot.responsibleName;
    _apartmentController.text = widget.spot.apartment;
    _blockController.text = widget.spot.block;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Spot'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _parkingSpotNumberController,
                decoration: InputDecoration(labelText: 'Número da Vaga'),
              ),
              TextField(
                controller: _licensePlateCarController,
                decoration: InputDecoration(labelText: 'Placa do Carro'),
              ),
              TextField(
                controller: _brandCarController,
                decoration: InputDecoration(labelText: 'Marca do Carro'),
              ),
              TextField(
                controller: _modelCarController,
                decoration: InputDecoration(labelText: 'Modelo do Carro'),
              ),
              TextField(
                controller: _colorCarController,
                decoration: InputDecoration(labelText: 'Cor do Carro'),
              ),
              TextField(
                controller: _responsibleNameController,
                decoration: InputDecoration(labelText: 'Nome do Responsável'),
              ),
              TextField(
                controller: _apartmentController,
                decoration: InputDecoration(labelText: 'Apartamento'),
              ),
              TextField(
                controller: _blockController,
                decoration: InputDecoration(labelText: 'Bloco'),
              ),
              ElevatedButton(
                onPressed: () {
                  _editSpot();
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _editSpot() async {
    try {
      SpotModel updatedSpot = SpotModel(
        widget.spot.id,
        _parkingSpotNumberController.text,
        _licensePlateCarController.text,
        _brandCarController.text,
        _modelCarController.text,
        _colorCarController.text,
        "",
        _responsibleNameController.text,
        _apartmentController.text,
        _blockController.text,
      );

      await Api.editSpot(updatedSpot);

      _showSuccessMessage('Spot Edited Successfully!');

      Navigator.pop(context, true);
    } catch (e) {
      _showErrorMessage('An error occurred: $e');
    }
  }

  void _showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showErrorMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
