import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../../../../core/resources/color_manager.dart';

class CustomCalendarField extends StatefulWidget {
  final String? Function(String?)? validator;
  final DateTime? initialDate;
  final ValueChanged<DateTime> onDateSelected;
  final TextEditingController controller;

  const CustomCalendarField({
    required this.validator,
    super.key,
    this.initialDate,
    required this.onDateSelected,
    required this.controller,
  });

  @override
  State<CustomCalendarField> createState() => _CustomCalendarFieldState();
}

class _CustomCalendarFieldState extends State<CustomCalendarField> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  bool _showYearSelector = false;
  final ScrollController _yearScrollController = ScrollController();

  static const int _minYear = 1990;
  static const int _maxYear = 2035;

  final List<int> _years = List.generate(
    _maxYear - _minYear + 1,
    (index) => _minYear + index,
  );

  @override
  void initState() {
    super.initState();

    if (widget.initialDate != null) {
      _focusedDay = widget.initialDate!;
      _selectedDay = widget.initialDate;
      widget.controller.text = _formatDate(widget.initialDate!);
    } else {
      widget.controller.clear();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentYearIndex = _years.indexOf(DateTime.now().year);
      if (currentYearIndex != -1) {
        _yearScrollController.jumpTo((currentYearIndex ~/ 4) * 56.0);
      }
    });
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _yearScrollController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  void _toggleCalendar() {
    if (_overlayEntry == null) {
      _showYearSelector = false;
      _overlayEntry = _createCalendarOverlay();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _showYearSelector = false;
    }
  }

  void _refreshOverlay() {
    if (_overlayEntry == null) return;
    _overlayEntry?.remove();
    _overlayEntry = _createCalendarOverlay();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _toggleYearSelector() {
    setState(() {
      _showYearSelector = !_showYearSelector;
    });
    _refreshOverlay();
  }

  void _selectYear(int year) {
    setState(() {
      _focusedDay = DateTime(year, _focusedDay.month, 1);
      _showYearSelector = false;
    });
    _refreshOverlay();
  }

  OverlayEntry _createCalendarOverlay() {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return OverlayEntry(builder: (_) => const SizedBox.shrink());
    }

    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    final screenHeight = MediaQuery.of(context).size.height;
    final spaceBelow = screenHeight - offset.dy - size.height;

    const totalHeight = 280;
    final showBelow = spaceBelow > totalHeight;

    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () {
          _overlayEntry?.remove();
          _overlayEntry = null;
          _showYearSelector = false;
        },
        behavior: HitTestBehavior.translucent,
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: showBelow
                    ? offset.dy + size.height + 2.h
                    : offset.dy - totalHeight,
                width: size.width,
                child: Stack(
                  children: [
                    Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(16.r),
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 12.h,
                              ),
                              color: ColorManager.primary,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.chevron_left,
                                      color: Colors.white,
                                      size: 24.w,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _focusedDay = DateTime(
                                          _focusedDay.year,
                                          _focusedDay.month - 1,
                                          1,
                                        );
                                      });
                                      _refreshOverlay();
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: _toggleYearSelector,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "${DateFormat.MMMM().format(_focusedDay)} ${_focusedDay.year}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 6.w),
                                        Icon(
                                          _showYearSelector
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down,
                                          color: Colors.white,
                                          size: 20.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.chevron_right,
                                      color: Colors.white,
                                      size: 24.w,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _focusedDay = DateTime(
                                          _focusedDay.year,
                                          _focusedDay.month + 1,
                                          1,
                                        );
                                      });
                                      _refreshOverlay();
                                    },
                                  ),
                                ],
                              ),
                            ),

                            ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 240.h),
                              child: TableCalendar(
                                firstDay: DateTime(_minYear),
                                lastDay: DateTime(_maxYear),
                                focusedDay: _focusedDay,
                                selectedDayPredicate: (day) =>
                                    isSameDay(_selectedDay, day),
                                onDaySelected: (selectedDay, focusedDay) {
                                  setState(() {
                                    _selectedDay = selectedDay;
                                    _focusedDay = focusedDay;
                                  });
                                  widget.onDateSelected(selectedDay);
                                  widget.controller.text = _formatDate(
                                    selectedDay,
                                  );
                                  _toggleCalendar();
                                },
                                calendarStyle: CalendarStyle(
                                  todayDecoration: BoxDecoration(
                                    color: ColorManager.primary.withValues(
                                      alpha: 0.25,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  selectedDecoration: const BoxDecoration(
                                    color: ColorManager.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  selectedTextStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  weekendTextStyle: TextStyle(
                                    color: Colors.red.shade700,
                                  ),
                                ),
                                headerVisible: false,
                                rowHeight: 34.h,
                                daysOfWeekHeight: 28.h,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (_showYearSelector)
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Material(
                            elevation: 8,
                            borderRadius: BorderRadius.circular(16.r),
                            clipBehavior: Clip.hardEdge,
                            child: Container(
                              width: double.infinity,
                              constraints: BoxConstraints(maxHeight: 280.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: ColorManager.primary.withValues(
                                    alpha: 0.2,
                                  ),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.15),
                                    blurRadius: 12,
                                    spreadRadius: 0,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 10.h,
                                    ),
                                    color: ColorManager.primary,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Select Year",
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            size: 20.w,
                                            color: Colors.white,
                                          ),
                                          onPressed: _toggleYearSelector,
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(10.w),
                                      child: GridView.builder(
                                        controller: _yearScrollController,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              crossAxisSpacing: 6.w,
                                              mainAxisSpacing: 6.h,
                                              childAspectRatio: 2,
                                            ),
                                        itemCount: _years.length,
                                        itemBuilder: (context, index) {
                                          final year = _years[index];
                                          final isSelected =
                                              year == _focusedDay.year;

                                          return InkWell(
                                            onTap: () => _selectYear(year),
                                            borderRadius: BorderRadius.circular(
                                              6.r,
                                            ),
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: isSelected
                                                    ? ColorManager.primary
                                                    : Colors.grey.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(6.r),
                                                border: Border.all(
                                                  color: isSelected
                                                      ? ColorManager.primary
                                                      : Colors.grey.shade300,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text(
                                                '$year',
                                                style: TextStyle(
                                                  color: isSelected
                                                      ? Colors.white
                                                      : Colors.black87,
                                                  fontWeight: isSelected
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  fontSize: 13.sp,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        controller: widget.controller,
        readOnly: true,
        onTap: _toggleCalendar,
        validator: widget.validator,
        style: const TextStyle(
          color: ColorManager.gray,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'Select Your Birth Date',
          hintStyle: TextStyle(color: ColorManager.gray.withValues(alpha: 0.7)),
          filled: true,
          fillColor: ColorManager.lightGray,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
        ),
      ),
    );
  }
}
