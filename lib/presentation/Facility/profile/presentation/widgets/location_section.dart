import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

import '../../data/models/get_profile_response.dart';

class LocationSection extends StatefulWidget {
  final List<AddressData>? addresses;

  const LocationSection({super.key, this.addresses});

  @override
  State<LocationSection> createState() => _LocationSectionState();
}

class _LocationSectionState extends State<LocationSection> {
  LatLng? _mapCoordinates;
  bool _isLoadingCoordinates = false;

  @override
  void initState() {
    super.initState();
    _resolveCoordinates();
  }

  @override
  void didUpdateWidget(covariant LocationSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.addresses != widget.addresses) {
      _resolveCoordinates();
    }
  }

  Future<void> _resolveCoordinates() async {
    final hasAddress = widget.addresses != null && widget.addresses!.isNotEmpty;
    final address = hasAddress ? widget.addresses!.first.addressText : null;

    if (address == null || address.trim().isEmpty) {
      if (mounted) {
        setState(() {
          _mapCoordinates = const LatLng(30.0444, 31.2357); // Cairo fallback
          _isLoadingCoordinates = false;
        });
      }
      return;
    }

    if (mounted) {
      setState(() {
        _isLoadingCoordinates = true;
      });
    }

    try {
      final locations = await locationFromAddress(address);
      if (locations.isNotEmpty && mounted) {
        setState(() {
          _mapCoordinates = LatLng(locations.first.latitude, locations.first.longitude);
          _isLoadingCoordinates = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _mapCoordinates = const LatLng(30.0444, 31.2357); // fallback
          _isLoadingCoordinates = false;
        });
      }
    }
  }

  Set<Marker> get _markers {
    if (_mapCoordinates == null) return {};
    return {
      Marker(
        markerId: const MarkerId("facility_location"),
        position: _mapCoordinates!,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final hasAddress = widget.addresses != null && widget.addresses!.isNotEmpty;
    final addressText = hasAddress ? (widget.addresses!.first.addressText ?? '') : 'Maadi, Cairo, Egypt';
    final floorText = hasAddress && widget.addresses!.first.floor != null ? 'Floor ${widget.addresses!.first.floor}' : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: getBoldStyle(
            color: ColorManager.black,
            fontSize: FontSize.s14.sp,
          ),
        ),
        SizedBox(height: AppSize.s8.h),
        Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(AppRadius.r16.r),
            border: Border.all(
              color: ColorManager.input.withValues(alpha: 0.8),
              width: 1.w,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 150.h,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                  child: _isLoadingCoordinates
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.primary,
                          ),
                        )
                      : _mapCoordinates == null
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  ImageAssets.map,
                                  height: 150.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  width: 36.r,
                                  height: 36.r,
                                  decoration: BoxDecoration(
                                    color: ColorManager.primary,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: ColorManager.white, width: 2.w),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorManager.primary.withValues(alpha: 0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.location_on,
                                    color: ColorManager.white,
                                    size: 18.sp,
                                  ),
                                ),
                              ],
                            )
                          : AbsorbPointer(
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: _mapCoordinates!,
                                  zoom: 15,
                                ),
                                markers: _markers,
                                zoomControlsEnabled: false,
                                myLocationButtonEnabled: false,
                                scrollGesturesEnabled: false,
                                rotateGesturesEnabled: false,
                                zoomGesturesEnabled: false,
                                tiltGesturesEnabled: false,
                                myLocationEnabled: false,
                              ),
                            ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(AppPadding.p12.r),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            addressText,
                            style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s12.sp,
                            ),
                          ),
                          if (floorText.isNotEmpty) ...[
                            SizedBox(height: AppSize.s4.h),
                            Text(
                              floorText,
                              style: getRegularStyle(
                                color: ColorManager.gray,
                                fontSize: FontSize.s11.sp,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(AppPadding.p8.r),
                      decoration: BoxDecoration(
                        color: ColorManager.lightGray,
                        borderRadius: BorderRadius.circular(AppRadius.r10.r),
                        border: Border.all(
                          color: ColorManager.input.withValues(alpha: 0.6),
                          width: 1.w,
                        ),
                      ),
                      child: Icon(
                        Icons.directions_outlined,
                        color: ColorManager.primary,
                        size: 18.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
