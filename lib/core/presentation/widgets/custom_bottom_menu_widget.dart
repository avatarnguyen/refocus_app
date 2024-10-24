import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';

typedef BottomMenuOptionBuilder<T> = Map<String, T> Function();

Future<T?> showCustomBottomMenu<T>({
  required BuildContext context,
  required BottomMenuOptionBuilder<T> menuOptionBuilder,
  String? title,
  String? description,
}) {
  final _options = menuOptionBuilder();

  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: kBorderRadiusBottomMenu,
    ),
    builder: (context) {
      return SizedBox(
        width: screenWidth(context),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: PlatformButton(
                  onPressed: () {
                    Navigator.of(context).pop(null);
                  },
                  child: const Icon(Icons.close),
                ),
              ),
              if (title != null) Text(title),
              if (description != null) Text(description),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: _options.keys.map((title) {
                  final value = _options[title];
                  return PlatformButton(
                    child: Text(title),
                    onPressed: () {
                      Navigator.of(context).pop(value);
                    },
                  );
                }).toList(),
              ).flexible(),
            ],
          ),
        ),
      );
    },
  );
}
