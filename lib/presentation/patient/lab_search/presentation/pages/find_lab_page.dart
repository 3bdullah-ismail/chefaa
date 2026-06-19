import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../core/resources/assets_manager.dart';
import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../../../../../../core/resources/values_manager.dart';
import '../../../../../../core/widget/custom_text_field.dart';
import '../widgets/center_recommendation_card.dart';
import '../widgets/filter_chip_item.dart';

class FindLabPage extends StatefulWidget {
  const FindLabPage({super.key});

  @override
  State<FindLabPage> createState() => _FindLabPageState();
}

class _FindLabPageState extends State<FindLabPage> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedFilterIndex = 0;

  GoogleMapController? _mapController;
  final bool _canShowMyLocation = true;
  LatLng? _currentPosition;
  final LatLng _fallbackPosition = const LatLng(29.9602, 31.2569);
  Set<Marker> _markers = {};
  BitmapDescriptor? _customIcon;

  final List<String> _filters = ["All", "Lab only", "Radiology", "Home scan"];
  final List<Map<String, dynamic>> _centers = [
    {
      "name": "Cairo MRI Center",
      "location": "Maadi Degla • 0.4 km away",
      "rating": "4.8",
      "ratingCount": "",
      "price": "EGP 1,200",
      "image": ImageAssets.mri,
      "tag": "NEAREST",
    },
    {
      "name": "Maadi Lab Professionals",
      "location": "Victory Square • 1.2 km away",
      "rating": "4.5",
      "ratingCount": "",
      "price": "EGP 450",
      "image": ImageAssets.labBackground,
      "tag": "CHEAPEST",
    },
    {
      "name": "Al-Salam Specialized",
      "location": "Corniche Road • 3.5 km away",
      "rating": "5.0",
      "ratingCount": " (2k+ reviews)",
      "price": "EGP 2,800",
      "image": ImageAssets.ct,
      "tag": "TOP RATED",
    },
    {
      "name": "Degla Rapid Diagnostics",
      "location": "Street 9 • 1.8 km away",
      "rating": "4.2",
      "ratingCount": "",
      "price": "EGP 950",
      "image": ImageAssets.xRay,
      "tag": "FASTEST",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightGray,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p20.w,
              vertical: AppPadding.p16.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                20.verticalSpace,
                CustomTextField(
                  controller: _searchController,
                  text: "Search labs, radiology, or services...",
                  prefixIcon: IconsAssets.searchIcon,
                  isSearch: true,
                ),
                20.verticalSpace,
                _buildFilterList(),
                20.verticalSpace,
                _buildMapSection(),
                24.verticalSpace,
                _buildSectionHeader(),
                16.verticalSpace,
                _buildRecommendedList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(AppRadius.r20.r),
          child: Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_back,
              color: ColorManager.black,
              size: 20.sp,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            IconsAssets.notification,
            width: 24.w,
            height: 24.h,
            colorFilter: const ColorFilter.mode(
              ColorManager.darkGray,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterList() {
    return SizedBox(
      height: 38.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _filters.length,
        separatorBuilder: (_, __) => 8.horizontalSpace,
        itemBuilder: (context, index) {
          return FilterChipItem(
            label: _filters[index],
            isSelected: _selectedFilterIndex == index,
            onTap: () {
              setState(() {
                _selectedFilterIndex = index;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      height: 160.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.input, width: 1.w),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => _mapController = controller,
            myLocationEnabled: _canShowMyLocation,
            myLocationButtonEnabled: false,
            initialCameraPosition: CameraPosition(
              target: _currentPosition ?? _fallbackPosition,
              zoom: 14,
            ),
            markers: _markers,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
            onTap: (LatLng position) {
              setState(() {
                _currentPosition = position;
                _markers = {
                  Marker(
                    markerId: const MarkerId("selected"),
                    position: position,
                    icon: _customIcon ?? BitmapDescriptor.defaultMarker,
                  ),
                };
              });
              _mapController?.animateCamera(CameraUpdate.newLatLng(position));
            },
          ),
          PositionedDirectional(
            bottom: 12.h,
            start: 12.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: ColorManager.input, width: 1.w),
              ),
              child: Text(
                "12 Centers found in Maadi",
                style: getMediumStyle(
                  color: ColorManager.black,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "AI Recommended",
          style: getBoldStyle(color: ColorManager.black, fontSize: 20.sp),
        ),
        Text(
          "Sort by: Relevance",
          style: getSemiBoldStyle(color: ColorManager.primary, fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildRecommendedList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _centers.length,
      itemBuilder: (context, index) {
        return CenterRecommendationCard(centerData: _centers[index]);
      },
    );
  }
}
