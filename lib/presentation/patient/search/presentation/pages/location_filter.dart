import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../profile/presentation/widgets/bottom_sheet.dart';
import '../../domain/entities/doctor_model.dart';
import '../widgets/search_card.dart';

class LocationFilter extends StatefulWidget {
  const LocationFilter({super.key});

  @override
  State<LocationFilter> createState() => _LocationFilterState();
}

class _LocationFilterState extends State<LocationFilter> {
  GoogleMapController? _mapController;
  BitmapDescriptor? customIcon;
  Set<Marker> markers = {};
  LatLng? _currentPosition;
  bool _isResolvingLocation = true;
  bool _canShowMyLocation = false;

  static const LatLng _fallbackPosition = LatLng(30.0444, 31.2357);

  @override
  void initState() {
    super.initState();
    _initializePage();
  }

  Future<void> _initializePage() async {
    await loadMarker();
    await _resolveCurrentLocation();
  }

  Future<void> loadMarker() async {
    customIcon =
        await const Icon(
          Icons.location_on,
          color: ColorManager.primary,
          size: 50,
        ).toBitmapDescriptor(
          logicalSize: const Size(150, 150),
          imageSize: const Size(300, 300),
        );

    if (mounted) setState(() {});
  }

  Future<void> _resolveCurrentLocation() async {
    final hasPermission = await _requestLocationPermission();
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!hasPermission || !serviceEnabled) {
      if (!mounted) return;

      setState(() {
        _currentPosition = _fallbackPosition;
        _isResolvingLocation = false;
        _canShowMyLocation = false;
        markers.clear();
      });

      return;
    }

    try {
      final lastKnownPosition = await Geolocator.getLastKnownPosition();
      final position =
          lastKnownPosition ??
          await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
            ),
          );
      final currentLocation = LatLng(position.latitude, position.longitude);

      if (!mounted) return;

      setState(() {
        _currentPosition = currentLocation;
        _isResolvingLocation = false;
        _canShowMyLocation = true;
        markers = {
          Marker(
            markerId: const MarkerId('current-location'),
            position: currentLocation,
            icon: customIcon ?? BitmapDescriptor.defaultMarker,
          ),
        };
      });

      await _moveCamera(currentLocation);
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _currentPosition = _fallbackPosition;
        _isResolvingLocation = false;
        _canShowMyLocation = false;
        markers.clear();
      });
    }
  }

  Future<void> _moveCamera(LatLng position) async {
    final controller = _mapController;
    if (controller == null) return;

    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 15),
      ),
    );
  }

  Future<bool> _requestLocationPermission() async {
    final status = await Permission.locationWhenInUse.request();

    if (status.isGranted) {
      return true;
    }

    if (status.isPermanentlyDenied) {
      openAppSettings();
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
                if (_currentPosition != null) {
                  _moveCamera(_currentPosition!);
                }
              },
              myLocationEnabled: _canShowMyLocation,
              myLocationButtonEnabled: false,
              initialCameraPosition: CameraPosition(
                target: _currentPosition ?? _fallbackPosition,
                zoom: 14,
              ),
              markers: markers,
              onTap: (LatLng position) {
                setState(() {
                  _currentPosition = position;
                  markers = {
                    Marker(
                      markerId: const MarkerId("selected"),
                      position: position,
                      icon: customIcon ?? BitmapDescriptor.defaultMarker,
                    ),
                  };
                });
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.4, 1.0],
                  colors: [
                    ColorManager.white,
                    ColorManager.white.withValues(alpha: 0.9),
                    ColorManager.white.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          if (_isResolvingLocation)
            const Positioned.fill(
              child: IgnorePointer(
                child: ColoredBox(
                  color: Colors.transparent,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "Nearby",
                        style: getSemiBoldStyle(
                          fontSize: 20.sp,
                          color: ColorManager.black,
                        ),
                      ),
                      const Spacer(),
                      48.horizontalSpace,
                    ],
                  ),
                  12.verticalSpace,

                  Container(
                    height: 55.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.grey),
                        10.horizontalSpace,
                        Text(
                          "Search location",
                          style: getRegularStyle(
                            color: Colors.grey,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ProfileBottomSheet(
              heightFactor: 0.3.sh,
              content: SearchCard(
                doctorModel: DoctorModel(
                  name: "doctorName",
                  specialty: "spaciality",
                  rating: "rating",
                  ratingCount: "ratingCount",
                  price: "price",
                  availableDays: [
                    DateTime.now(),
                    DateTime.now().add(const Duration(days: 2)), // بعد بكره
                    DateTime.now().add(const Duration(days: 5)), // بعد 5 أيام
                  ],
                  clinkId:
                      "clinkId"
                      '',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
