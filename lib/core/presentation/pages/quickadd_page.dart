import 'package:flutter/material.dart';
import 'package:refocus_app/core/presentation/widgets/action_panel_widget.dart';
import 'package:refocus_app/core/presentation/widgets/add_textfield_widget.dart';
import 'package:refocus_app/core/presentation/widgets/option_widget.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:get/get.dart';

class QuickAddPage extends StatelessWidget {
  const QuickAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: [
        TextButton(
            onPressed: Get.back,
            child: Text(
              'Abbrechen',
              style: context.textTheme.button!.copyWith(
                color: kcSecondary400,
              ),
            )).paddingOnly(top: 48).alignment(Alignment.topRight),
        // verticalSpaceSmall,
        [
          const AddTextFieldWidget(),
          const OptionRowWidget().paddingOnly(top: 24)
        ].toColumn().parent(textContainer),
        const ActionPanelWidget()
      ].toColumn(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    ).safeArea();
  }

  Widget textContainer({required Widget child}) => Container(
        // color: Colors.amber,
        height: 192,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Styled.widget(child: child),
      );
}
