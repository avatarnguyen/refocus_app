import 'package:flutter/widgets.dart';
import 'package:styled_widget/styled_widget.dart';

Widget scrollablePage({required Widget child}) => Styled.widget(child: child)
    .padding(vertical: 30, horizontal: 20)
    .scrollable();
