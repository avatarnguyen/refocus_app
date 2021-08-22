import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:get/get.dart';

class QuickAddPage extends StatelessWidget {
  const QuickAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: context.theme.backgroundColor,
      body: const AddTextFieldWidget().parent(textContainer).safeArea(),
    );
  }

  Widget textContainer({required Widget child}) => Container(
        height: 120,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Styled.widget(child: child),
      );
}

class AddTextFieldWidget extends StatefulWidget {
  const AddTextFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  _AddTextFieldWidgetState createState() => _AddTextFieldWidgetState();
}

class _AddTextFieldWidgetState extends State<AddTextFieldWidget> {
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: PlatformTextField(
        controller: _textController,
        autofocus: true,
        minLines: 4,
        maxLines: 8,
        material: (context, platform) => MaterialTextFieldData(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            fillColor: Colors.grey[300],
          ),
        ),
        cupertino: (context, platform) => CupertinoTextFieldData(
            decoration: BoxDecoration(
          border: Border.all(
            color: kcSecondary500,
            width: 2.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Colors.grey[300],
        )),
      ),
    );
  }
}
