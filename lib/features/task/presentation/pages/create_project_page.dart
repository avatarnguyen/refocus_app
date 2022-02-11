import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/project_params.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:uuid/uuid.dart';

class CreateProjectPage extends StatefulWidget {
  const CreateProjectPage({Key? key, this.project}) : super(key: key);

  final ProjectEntry? project;

  @override
  _CreateProjectPageState createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  final TextEditingController _textController = TextEditingController();
  Uuid uuid = const Uuid();
  late String projectID;

  final _colorCodeList = <String>[
    '#0000FF',
    '#FE642E',
    '#0174DF',
    '#7401DF',
    '#DF01D7',
    '#04B431',
    '#DF013A',
    '#FF8000',
  ];

  int _selectedColorIdx = -1;

  @override
  void initState() {
    super.initState();
    projectID = widget.project?.id ?? uuid.v1();
    if (widget.project != null) {
      _textController.text = widget.project!.title ?? '';
      _selectedColorIdx = _colorCodeList.indexOf(widget.project!.color ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.background,
      child: PlatformScaffold(
        backgroundColor: context.colorScheme.background,
        body: [
          verticalSpaceRegular,
          'Create New Project'.toH5(color: kcSecondary400),
          verticalSpaceSmall,
          SizedBox(
            height: 32,
            width: context.width,
            child: Material(
              color: Colors.transparent,
              child: PlatformTextField(
                controller: _textController,
                textAlign: TextAlign.center,
                autofocus: true,
                style: context.h4.copyWith(color: kcPrimary100),
                // onChanged: (text) {},
                onSubmitted: (text) {
                  _saveData();
                },
                material: (context, platform) => MaterialTextFieldData(
                  decoration: InputDecoration(
                    hintText: 'Enter new Project',
                    hintStyle: context.h4.copyWith(color: Colors.white38),
                    contentPadding: const EdgeInsets.all(16),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
                cupertino: (context, platform) => CupertinoTextFieldData(
                  placeholder: 'Enter new Project',
                  placeholderStyle: context.h4.copyWith(color: Colors.white38),
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ).expanded(),
          [
            'Choose a color'.toBodyText1().padding(bottom: 16),
            Wrap(
              children: _colorCodeList.mapIndexed(_buildColorItem).toList(),
            ),
            verticalSpaceMedium,
            Container(
              height: 48,
              color: kcPrimary900,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.close,
                    size: 26,
                    color: kcPrimary100,
                  ).gestures(onTap: () {}),
                  horizontalSpaceLarge,
                  Icon(
                    Icons.send,
                    size: 26,
                    color: context.colorScheme.secondary,
                  ).gestures(onTap: _saveData),
                ],
              ),
            )
          ].toColumn()
        ].toColumn(mainAxisSize: MainAxisSize.min),
      ).safeArea(),
    );
  }

  void _saveData() {
    late ProjectEntry _project;

    if (widget.project != null) {
      _project = widget.project!.copyWith(
        title: _textController.text,
        color: _colorCodeList[_selectedColorIdx],
      );
      context.read<ProjectBloc>().add(
            ProjectEvent.update(
              project: ProjectParams(_project),
            ),
          );
    } else {
      _project = ProjectEntry(
        id: uuid.v1(),
        title: _textController.text,
        color: _colorCodeList[_selectedColorIdx],
        taskCount: 0,
      );
      context.read<ProjectBloc>().add(
            ProjectEvent.create(
              project: ProjectParams(_project),
            ),
          );
    }
    // context.router.pop();
  }

  Widget _buildColorItem(int index, String colorID) {
    final _color = StyleUtils.getColorFromString(colorID);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: index == _selectedColorIdx ? kcSecondary500 : Colors.white, borderRadius: const BorderRadius.all(Radius.circular(24))),
      child: CustomPaint(
        painter: ColorCirclePainter(_color),
      ),
    ).gestures(
      onTap: () => setState(() => _selectedColorIdx = index),
    );
  }
}

class ColorCirclePainter extends CustomPainter {
  ColorCirclePainter(this.elementColor);

  final Color elementColor;
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = elementColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(const Offset(20, 20), 16, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
