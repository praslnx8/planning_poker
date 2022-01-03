import 'package:flutter/widgets.dart';
import 'package:planning_poker/utils/resources/resources.dart';

extension AppContext on BuildContext {
  Resources get resources => Resources.of(this);
}
