import 'package:absen_online/constant/assets_constant.dart';
import 'package:absen_online/constant/color_constant.dart';
import 'package:flutter/material.dart';

class CustomButtonPrimary extends StatelessWidget {
  CustomButtonPrimary({
    this.onTap,
    this.isEnable : false,
    this.btnLoading : false,
    this.isBorder : false,
    this.title,
    this.icon,
    this.shadow,
    this.borderRadius,
    this.customText,
    this.customTextSize,
    this.spaceIcon,
    this.color,this.textColor,
    this.hasHeight = false,this.hasWidth = false,

  });
  final bool isEnable, btnLoading, isBorder,hasHeight,hasWidth;
  final Function onTap;
  final String title;
  final Color color,textColor;
  final List<BoxShadow> shadow;
  final Widget icon, customText;
  final double borderRadius, spaceIcon,customTextSize;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: isEnable ? onTap : null,
      disabledColor: color_grey,
      disabledTextColor: Colors.white,
      textColor: textColor,
      color: isEnable ? color: color_grey,
      splashColor: Colors.white.withOpacity(0.5),
      highlightColor: Colors.white.withOpacity(0.5),
      hoverColor: Colors.white.withOpacity(0.5),
      disabledElevation: 0,
      highlightElevation: 0,
      elevation: 0,
      height: 0,
      minWidth: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding:EdgeInsets.symmetric(
          vertical:  hasHeight ? 0 :12,
        horizontal:  hasWidth ? 0 : 17,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: isBorder ? BorderSide(
          color: Colors.grey,
          width: 1,
        ) : BorderSide.none,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null
              ? Padding(
              padding: EdgeInsets.only(right: spaceIcon), child: icon)
              : Container(),
          !btnLoading
              ? customText != null
              ? customText
              : Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: baseUrlFontsPoppinsSemiBold,
                fontSize: customTextSize ?? 13),
          )
              : Container(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(backgroundColor: Colors.white)),
        ],
      ),
    );
  }
}