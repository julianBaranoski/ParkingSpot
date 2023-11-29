import 'package:flutter/material.dart';
import '../Service/SpotService.dart';
import '../models/ParkingModel.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController _parkingSpotNumberController = TextEditingController();
  TextEditingController _licensePlateCarController = TextEditingController();
  TextEditingController _brandCarController = TextEditingController();
  TextEditingController _modelCarController = TextEditingController();
  TextEditingController _colorCarController = TextEditingController();
  TextEditingController _responsibleNameController = TextEditingController();
  TextEditingController _apartmentController = TextEditingController();
  TextEditingController _blockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Spot'),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  submitData();
                },
                child: Text('Adicionar Registro'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> submitData() async {
    try {
      SpotModel spotModel = SpotModel(
        "",
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

      await Api.createSpot(spotModel);

      setState(() {
        _parkingSpotNumberController.text = "";
        _licensePlateCarController.text = "";
        _brandCarController.text = "";
        _modelCarController.text = "";
        _colorCarController.text = "";
        _responsibleNameController.text = "";
        _apartmentController.text = "";
        _blockController.text = "";
      });

      showSuccessMessage('Parking Spot Added!');

      Navigator.pop(context, true);
    } catch (e) {
      showErrorMessage('An error occurred: $e');
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
