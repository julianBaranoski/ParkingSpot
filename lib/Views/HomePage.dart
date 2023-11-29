import 'package:flutter/material.dart';
import '../Service/SpotService.dart';
import '../models/ParkingModel.dart';
import '../models/SpotList.dart';
import 'CreatePage.dart';
import 'Edit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<ParkingSpotList> _futureSpotList;

  @override
  void initState() {
    super.initState();
    _futureSpotList = Api.fetchSpot();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parking Spot'),
      ),
      body: FutureBuilder<ParkingSpotList>(
        future: _futureSpotList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.listParkingSpotModel.length,
              itemBuilder: (context, index) {
                final spot = snapshot.data!.listParkingSpotModel[index];
                return ListTile(
                  title: Text('Placa: ${spot.licensePlateCar}'),
                  subtitle: Text('Responsável: ${spot.responsibleName}\nApartamento: ${spot.apartment}'),
                  trailing: PopupMenuButton(
                    onSelected: (value) async {
                      if (value == 'edit') {
                        await navigateToEditPage(spot);
                      } else if (value == 'delete') {
                        await deleteSpot(spot.id);
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: Text('Edit'),
                          value: 'edit',
                        ),
                        PopupMenuItem(
                          child: Text('Delete'),
                          value: 'delete',
                        ),
                      ];
                    },
                  ),
                );
              },
            );
          } else {
            return Text('No data available');
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await navigateToCreatePage();
        },
        label: Text('Add Spot'),
      ),
    );
  }

  Future<void> navigateToCreatePage() async {
    final result = await Navigator.push(context, MaterialPageRoute(
      builder: (builder) => CreatePage(),
    ));

    if (result != null && result == true) {
      _refreshList();
    }
  }

  Future<void> navigateToEditPage(SpotModel spot) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPage(spot: spot),
      ),
    );

    if (result != null && result == true) {
      _refreshList();
    }
  }

  Future<void> deleteSpot(String id) async {
    try {
      await Api.deleteSpot(id);

      _refreshList();

      showSuccessMessage('Spot deleted successfully!');
    } catch (e) {
      showErrorMessage('An error occurred: $e');
    }
  }

  Future<void> _refreshList() async {
    setState(() {
      _futureSpotList = Api.fetchSpot();
    });
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
