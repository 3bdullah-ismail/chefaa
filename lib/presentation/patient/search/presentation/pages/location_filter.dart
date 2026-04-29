import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
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
  final TextEditingController _searchController = TextEditingController();
  static const LatLng _fallbackPosition = LatLng(30.0444, 31.2357);

  @override
  void dispose() {
    _searchController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializePage();
  }

  Future<void> _initializePage() async {
    await loadMarker();
    await _resolveCurrentLocation();
  }

  void _searchLocation(String address) async {
    try {
      setState(() => _isResolvingLocation = true);
      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        LatLng newPos = LatLng(locations[0].latitude, locations[0].longitude);

        setState(() {
          _currentPosition = newPos;
          _isResolvingLocation = false;
          markers = {
            Marker(
              markerId: const MarkerId("selected"),
              position: newPos,
              icon: customIcon ?? BitmapDescriptor.defaultMarker,
            ),
          };
        });

        await _moveCamera(newPos);
      }
    } catch (e) {
      setState(() => _isResolvingLocation = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No results found for this address")),
        );
      }
    }
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
    setState(() => _isResolvingLocation = true);
    final hasPermission = await _requestLocationPermission();
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!hasPermission || !serviceEnabled) {
      if (!mounted) return;
      setState(() {
        _currentPosition ??= _fallbackPosition;
        _isResolvingLocation = false;
        _canShowMyLocation = false;
      });
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
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
      if (mounted) setState(() => _isResolvingLocation = false);
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
    if (status.isGranted) return true;
    if (status.isPermanentlyDenied) openAppSettings();
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
              onMapCreated: (controller) => _mapController = controller,
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
              height: 220.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorManager.white,
                    ColorManager.white.withValues(alpha: 0.92),
                    ColorManager.white.withValues(alpha: 0),
                  ],
                ),
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(18.r),
                      border: Border.all(
                        color: ColorManager.input.withValues(alpha: 0.5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 14,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        final query = value.trim();
                        if (query.isNotEmpty) _searchLocation(query);
                      },
                      decoration: InputDecoration(
                        hintText: "Search by area, street, or landmark",
                        hintStyle: getRegularStyle(
                          color: ColorManager.gray,
                          fontSize: 14.sp,
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: ColorManager.gray,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            final query = _searchController.text.trim();
                            if (query.isEmpty) {
                              _searchController.clear();
                              return;
                            }
                            _searchLocation(query);
                          },
                          icon: const Icon(
                            Icons.north_east,
                            color: ColorManager.primary,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (_isResolvingLocation)
            const Positioned.fill(
              child: Center(child: CircularProgressIndicator()),
            ),

          Positioned(
            bottom: 0.32.sh,
            right: 16.w,
            child: FloatingActionButton(
              heroTag: "my_location_btn",
              mini: true,
              backgroundColor: ColorManager.white,
              elevation: 4,
              onPressed: _resolveCurrentLocation,
              child: const Icon(Icons.my_location, color: ColorManager.primary),
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
                  name: "Dr. Ahmed",
                  specialty: "Cardiology",
                  rating: "4.8",
                  ratingCount: "120",
                  price: "500 EGP",
                  availableDays: [DateTime.now()],
                  clinkId: "1",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
