import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../../core/resources/color_manager.dart';

class HealthIndicator extends StatelessWidget {
  final double value;

  const HealthIndicator({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 250,
        padding: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(85),
              blurRadius: 5,
              spreadRadius: 3,
            ),
          ],
        ),
        child: SfRadialGauge(
          enableLoadingAnimation: true,
          axes: <RadialAxis>[
            RadialAxis(
              startAngle: 180,
              endAngle: 360,
              minimum: 0,
              maximum: 10,
              showLabels: false,
              showTicks: false,
              canScaleToFit: true,
              radiusFactor: 0.95,
              axisLineStyle: const AxisLineStyle(
                thickness: 0.04,
                thicknessUnit: GaugeSizeUnit.factor,
                color: ColorManager.transparent,
              ),
              ranges: <GaugeRange>[
                GaugeRange(
                  startValue: 0,
                  endValue: 3.3,
                  color: ColorManager.lightGreen,
                  startWidth: 0.4,
                  endWidth: 0.4,
                  sizeUnit: GaugeSizeUnit.factor,
                ),
                GaugeRange(
                  startValue: 3.4,
                  endValue: 6.8,
                  color: ColorManager.lawAnalysis,
                  startWidth: 0.4,
                  endWidth: 0.4,
                  sizeUnit: GaugeSizeUnit.factor,
                ),
                GaugeRange(
                  startValue: 6.9,
                  endValue: 10,
                  color: ColorManager.error,
                  startWidth: 0.4,
                  endWidth: 0.4,
                  sizeUnit: GaugeSizeUnit.factor,
                ),
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: value,
                  needleColor: Colors.black,
                  knobStyle: const KnobStyle(
                    color: Colors.black,
                    knobRadius: 0.06,
                    sizeUnit: GaugeSizeUnit.factor,
                  ),
                  needleLength: 0.65,
                  needleStartWidth: 1,
                  needleEndWidth: 7,
                  enableAnimation: true,
                  animationType: AnimationType.elasticOut,
                ),
              ],
              annotations: <GaugeAnnotation>[
                _buildLabel('0', 175, 0.8, ColorManager.lightGreen),
                _buildLabel('3.3', 235, 1.1, ColorManager.lightGreen),

                _buildLabel('3.4', 245, 1.1, ColorManager.lawAnalysis),
                _buildLabel('6.8', 297, 1.1, ColorManager.lawAnalysis),

                _buildLabel('6.9', 308, 1.15, ColorManager.error),
                _buildLabel('10', 365, 0.8, ColorManager.error),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GaugeAnnotation _buildLabel(
    String text,
    double angle,
    double factor,
    Color color,
  ) {
    return GaugeAnnotation(
      widget: Text(text, style: getSemiBoldStyle(fontSize: 14.7, color: color)),
      angle: angle,
      positionFactor: factor,
    );
  }
}
