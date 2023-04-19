import 'package:pokedex/core/const/other.dart';

abstract class NumericUtil {
  static int getPageByCount(int value) {
    double countFromValue = value / Other.limit;
    double remainder = countFromValue % 1;
    return (countFromValue - remainder + (remainder > 0 ? 1 : 0)).ceil();
  }
}
