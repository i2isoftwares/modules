import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpdesk/helpers/color.dart';

class Spinner extends StatelessWidget {
  String value;
  List<dynamic> items;
  Function(String?)? onChanged;
  String? hint;
  double? width;
  EdgeInsetsGeometry? padding;

  Spinner(
      {Key? key,
      required this.value,
      required this.items,
      this.onChanged,
      this.hint,
      this.width,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.focusScope!.unfocus(),
      child: Container(
        width: width ?? Get.width,
        height: 40,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 12),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [BoxShadow(color: gray, blurRadius: 0)]),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            iconSize: 18,
            hint: Text(
              hint ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            value: value,
            items: buildDropdownItem(items),
            onChanged: onChanged,
            isExpanded: true,
          ),
        ),
      ),
    );
  }

  buildDropdownItem(List<dynamic> items) {
    List<DropdownMenuItem<String>> list = [];
    for (String v in items) {
      list.add(DropdownMenuItem<String>(
        value: v.toString(),
        child: Text(
          v,
        ),
      ));
    }
    return list;
  }
}
