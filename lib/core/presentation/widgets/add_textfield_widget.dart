import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/presentation/widgets/setting_option.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:rich_text_controller/rich_text_controller.dart';
import 'package:styled_widget/styled_widget.dart';

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
  final _settingsOption = getIt<SettingOption>();

  late StreamSubscription<ProjectEntry?> _projectSubscription;
  late StreamSubscription<String> _textSubscription;

  ProjectEntry? _currentProject;

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
    //! Bug: When Deleting Text, the cursor go to the end
    _textSubscription = _textStream.getTextStream.listen((text) {
      // print(text);
      _textController.text = text;
      _textController.selection = TextSelection.fromPosition(
          TextPosition(offset: _textController.text.length));
    });
    _projectSubscription =
        _settingsOption.projectStream.listen(_projectEntryReceived);
    super.initState();
  }

  void _projectEntryReceived(ProjectEntry? entry) {
    setState(() {
      _currentProject = entry;
    });
  }

  @override
  void dispose() {
    // _textStream.dispose();
    _textSubscription.cancel();
    _projectSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: context.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            kShadowLightBase,
            kShadowLight100,
          ],
        ),
        child: [
          Text(
            _currentProject?.title ?? 'Inbox',
            style: context.textTheme.subtitle1!.copyWith(
              decoration: TextDecoration.underline,
              color: kcPrimary500,
            ),
          ).padding(top: 16),
          _buildTextInput(context),
        ].toColumn(mainAxisSize: MainAxisSize.min));
  }

  Widget _buildTextInput(BuildContext context) {
    return PlatformTextField(
      controller: _textController,
      onChanged: _textStream.updateText,
      textAlign: TextAlign.center,
      autofocus: true,
      minLines: 2,
      maxLines: 8,
      material: (context, platform) => MaterialTextFieldData(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      cupertino: (context, platform) => CupertinoTextFieldData(
        placeholder: 'Enter ...',
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    ).flexible();
  }
}
