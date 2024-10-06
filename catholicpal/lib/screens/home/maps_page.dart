import 'package:catholicpal/models/church_model.dart';
import 'package:catholicpal/screens/home/church_details_page.dart';
import 'package:catholicpal/services/map_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChurchMapPage extends StatefulWidget {
  const ChurchMapPage({super.key});

  @override
  ChurchMapPageState createState() => ChurchMapPageState();
}

class ChurchMapPageState extends State<ChurchMapPage> {
  late GoogleMapController mapController;
  final ChurchService _churchService = ChurchService();
  Set<Marker> _markers = {};
  LatLng _center = const LatLng(0, 0);
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNearbyChurches();
  }

  void _loadNearbyChurches() async {
    setState(() => _isLoading = true);
    try {
      final position = await _churchService.getUserLocation();
      _center = LatLng(position.latitude, position.longitude);

      final churches = await _churchService.getNearbyChurches(
        position.latitude,
        position.longitude,
        5000, // 5km radius
      );

      setState(() {
        _markers = churches
            .map((church) => Marker(
                  markerId: MarkerId(church.id),
                  position: LatLng(church.latitude, church.longitude),
                  infoWindow: InfoWindow(title: church.name),
                  onTap: () => _showChurchDetails(church),
                ))
            .toSet();
        _isLoading = false;
      });

      mapController.animateCamera(CameraUpdate.newLatLng(_center));
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading churches: $e')),
      );
    }
  }

  void _showChurchDetails(Church church) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ChurchDetailsWidget(church: church),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Churches')),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => mapController = controller,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 12,
            ),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadNearbyChurches,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
