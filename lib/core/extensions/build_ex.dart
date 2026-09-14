import 'package:chefaa/core/imports/imports.dart';

extension BuildExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  ThemeData get theme => Theme.of(this);
}
