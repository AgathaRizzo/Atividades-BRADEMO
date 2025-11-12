import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isEnabled = await Geolocator.isLocationServiceEnabled();
  var permission = await Geolocator.checkPermission();

  if (!isEnabled) {
    return Future.error("Serviço de localização não habilitado");
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error("Permissão de localização negada");
    }
  }

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: GeolocatorApp(),
  ));
}

class GeolocatorApp extends StatefulWidget {
  const GeolocatorApp({super.key});

  @override
  State<StatefulWidget> createState() => GeolocatorAppState();
}

class GeolocatorAppState extends State<GeolocatorApp> {
  late final Stream<Position> _geoStream;
  GoogleMapController? _mapController;
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _geoStream = Geolocator.getPositionStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minha Localização no Mapa"),
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder<Position>(
        stream: _geoStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final pos = snapshot.data!;
            final latLng = LatLng(pos.latitude, pos.longitude);
            _currentPosition = latLng;

            if (_mapController != null) {
              _mapController!.animateCamera(
                CameraUpdate.newLatLng(latLng),
              );
            }

            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: latLng,
                    zoom: 16,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('atual'),
                      position: latLng,
                      infoWindow: const InfoWindow(title: 'Você está aqui!'),
                    ),
                  },
                  onMapCreated: (controller) => _mapController = controller,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      "Latitude: ${pos.latitude.toStringAsFixed(5)} | "
                      "Longitude: ${pos.longitude.toStringAsFixed(5)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Erro ao obter localização.",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
