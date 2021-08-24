import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:rich_text_controller/rich_text_controller.dart';
import 'package:refocus_app/injection.dart';
import 'package:get/get.dart';
import '../text_stream.dart';

class AddTextFieldWidget extends StatefulWidget {
  const AddTextFieldWidget({Key? key}) : super(key: key);
  @override
  _AddTextFieldWidgetState createState() => _AddTextFieldWidgetState();
}

class _AddTextFieldWidgetState extends State<AddTextFieldWidget> {
  final _textController = TextEditingController();
  final _textStream = getIt<TextStream>();

  // late RichTextController _textController;

  @override
  void initState() {
    // _textController = RichTextController(
    //     patternMap: {
    //       // #
    //       RegExp(r"\B#[a-zA-Z0-9]+\b"): const TextStyle(color: kcPrimary500),
    //       // @
    //       RegExp(r'\B@[a-zA-Z0-9]+\b'): const TextStyle(color: kcSecondary500),
    //       // /
    //       RegExp(r'\B/[a-zA-Z0-9]+\b'): const TextStyle(color: Colors.green),
    //       // !
    //       RegExp(r'\B#[a-zA-Z0-9]+\b'): const TextStyle(color: Colors.red),
    //     },
    //     onMatch: (List<String> matches) {
    //       print(matches);
    //       // Do sth with matches
    //     });
    _textStream.getTextStream.listen((text) {
      print(text);
      _textController.text = text;
      _textController.selection = TextSelection.fromPosition(
          TextPosition(offset: _textController.text.length));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: context.width,
      decoration: BoxDecoration(
        color: context.theme.backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: const [
          kShadowLightBase,
          kShadowLight100,
        ],
      ),
      child: PlatformTextField(
        controller: _textController,
        onChanged: _textStream.updateText,
        autofocus: true,
        minLines: 4,
        maxLines: 8,
        material: (context, platform) => MaterialTextFieldData(
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        cupertino: (context, platform) => CupertinoTextFieldData(
          placeholder: 'Enter ...',
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
    );
  }
}
