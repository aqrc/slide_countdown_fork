part of 'separated.dart';

class DigitSeparatedItem extends BaseDigitsSeparated {
  const DigitSeparatedItem({
    super.key,
    required super.height,
    required super.width,
    required super.decoration,
    required super.firstDigit,
    required super.secondDigit,
    required super.textStyle,
    required super.separatorStyle,
    required super.initValue,
    required super.slideDirection,
    required super.showZeroValue,
    required super.curve,
    required super.countUp,
    required super.slideAnimationDuration,
    required super.separator,
    required super.textDirection,
    required super.showSeparator,
    super.separatorPadding,
    super.digitsNumber,
    required super.oneDigitPerBox,
    required super.showDurationTitleUnder,
    required super.distanceBetweenDigitBoxes,
    required super.title,
    required super.maxFirstDigitValue,
  });

  @override
  Widget build(BuildContext context) {
    final withOutAnimation = slideDirection == SlideDirection.none;
    final firstDigitWidget = withOutAnimation
        ? TextWithoutAnimation(
            value: firstDigit,
            textStyle: textStyle,
          )
        : TextAnimation(
            slideAnimationDuration: slideAnimationDuration,
            value: firstDigit,
            maxValue: maxFirstDigitValue,
            textStyle: textStyle,
            slideDirection: slideDirection,
            curve: curve,
            countUp: countUp,
            digitsNumber: digitsNumber,
          );

    final secondDigitWidget = withOutAnimation
        ? TextWithoutAnimation(
            value: secondDigit,
            textStyle: textStyle,
          )
        : TextAnimation(
            slideAnimationDuration: slideAnimationDuration,
            value: secondDigit,
            textStyle: textStyle,
            slideDirection: slideDirection,
            curve: curve,
            countUp: countUp,
            digitsNumber: digitsNumber,
          );

    final separatorWidget = Separator(
      padding: separatorPadding,
      show: true,
      separator: separator,
      style: separatorStyle,
    );

    final digitWidth = (width - distanceBetweenDigitBoxes) / 2;
    final digits = [
      Container(
        width: digitWidth,
        height: height,
        decoration: oneDigitPerBox ? decoration : BoxDecoration(),
        child: firstDigitWidget,
      ),
      SizedBox(width: distanceBetweenDigitBoxes),
      Container(
        width: digitWidth,
        height: height,
        decoration: oneDigitPerBox ? decoration : BoxDecoration(),
        child: secondDigitWidget,
      ),
    ];

    Widget box = BoxSeparated(
      height: height,
      width: width,
      decoration: oneDigitPerBox ? BoxDecoration() : decoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: textDirection.isRtl ? digits.reversed.toList() : digits,
      ),
    );

    if (showDurationTitleUnder) {
      box = Column(
        children: [
          box,
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }

    final widgetsRow = [
      box,
      Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: separatorWidget,
      ),
    ];

    return Visibility(
      visible: showSeparator,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children:
            textDirection.isRtl ? widgetsRow.reversed.toList() : widgetsRow,
      ),
      replacement: box,
    );
  }
}
