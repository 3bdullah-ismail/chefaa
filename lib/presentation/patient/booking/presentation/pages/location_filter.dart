import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../profile/presentation/widgets/bottom_sheet.dart';
import '../widgets/doctor_model.dart';
import '../widgets/doctor_data_sard.dart';

class LocationFilter extends StatefulWidget {
  const LocationFilter({super.key});

  @override
  State<LocationFilter> createState() => _LocationFilterState();
}

class _LocationFilterState extends State<LocationFilter> {
  BitmapDescriptor? customIcon;
  Set<Marker> markers = {};

  static const LatLng _initialPosition = LatLng(30.0444, 31.2357);

  @override
  void initState() {
    super.initState();
    _initializePage();
  }

  Future<void> _initializePage() async {
    await requestLocationPermission();
    await loadMarker();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              initialCameraPosition: const CameraPosition(
                target: _initialPosition,
                zoom: 14,
              ),
              markers: markers,
              onTap: (LatLng position) {
                setState(() {
                  markers.clear();
                  markers.add(
                    Marker(
                      markerId: const MarkerId("selected"),
                      position: position,
                      icon: customIcon ?? BitmapDescriptor.defaultMarker,
                    ),
                  );
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
              content: DoctorDataCard(
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> requestLocationPermission() async {
  var status = await Permission.location.request();
  if (status.isGranted) {
    debugPrint("Location Permission granted");
  } else if (status.isPermanentlyDenied) {
    openAppSettings();
  }
}
