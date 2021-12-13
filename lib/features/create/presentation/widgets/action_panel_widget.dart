import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:refocus_app/core/presentation/helper/action_stream.dart';
import 'package:refocus_app/core/presentation/helper/text_stream.dart';

import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/action_selection_type.dart';
import 'package:refocus_app/enum/prio_type.dart';
import 'package:refocus_app/features/create/presentation/widgets/action_bottom_widget.dart';
import 'package:refocus_app/features/create/presentation/widgets/set_duedate_widget.dart';
import 'package:refocus_app/injection.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:uuid/uuid.dart';

class ActionPanelWidget extends StatefulWidget {
  const ActionPanelWidget({
    Key? key,
  }) : super(key: key);

  @override
  _ActionPanelWidgetState createState() => _ActionPanelWidgetState();
}

class _ActionPanelWidgetState extends State<ActionPanelWidget> {
  Uuid uuid = const Uuid();

  final _textStream = getIt<TextStream>();
  final _actionStream = getIt<ActionStream>();

  final _prioList = [
    PrioType.low,
    PrioType.medium,
    PrioType.high,
  ];
  PrioType? _currentPrio;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return [
      StreamBuilder<ActionSelectionType>(
        stream: _actionStream.actionTypeStream,
        builder: (context, snapshot1) {
          final _currentAction = snapshot1.data;

          if (_currentAction == ActionSelectionType.prio) {
            return StreamBuilder<String>(
              stream: _textStream.getTextStream,
              builder: (context, snapshot2) {
                final _currentText = snapshot2.data;

                return _buildSelectionListRow(context, _prioList, _currentText);
              },
            );
          } else if (_currentAction == ActionSelectionType.dueDate) {
            return const SetDueDateWidget().padding(vertical: 4);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),

      //* Action Bottom Panel
      const ActionBottomWidget()
    ].toColumn(mainAxisSize: MainAxisSize.min);
  }

  String _getItemString(dynamic item) {
    if (item is PrioType) {
      final _dueDateString = <String>['Low Prio', 'Medium Prio', 'High Prio'];
      return _dueDateString[item.index];
    } else {
      return item as String;
    }
  }

  Widget _buildSelectionListRow(
      BuildContext context, List items, String? currentText) {
    return SizedBox(
      height: 44,
      width: context.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final dynamic _item = items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              backgroundColor: context.colorScheme.background,
              selectedColor: context.colorScheme.secondary,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              label: Text(
                _getItemString(_item),
                style: context.subtitle1.copyWith(
                  color: kcPrimary100,
                ),
              ),
              selected: _currentPrio == _item,
              onSelected: (bool selected) {
                setState(() {
                  if (_item is PrioType) {
                    _currentPrio = _item;
                    _mapPrioTypeToAction(_item, currentText ?? '');
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }

  void _mapPrioTypeToAction(PrioType prio, String currentText) {
    final _tmpStr = currentText.replaceAll(RegExp('!{1,3}'), '');
    switch (prio) {
      case PrioType.low:
        _textStream.updateText('$_tmpStr!');
        break;
      case PrioType.medium:
        _textStream.updateText('$_tmpStr!!');
        break;
      case PrioType.high:
        _textStream.updateText('$_tmpStr!!!');
        break;
      default:
    }
  }
}