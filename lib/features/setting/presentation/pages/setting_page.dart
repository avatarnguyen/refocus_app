import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: context.backgroundColor,
      appBar: PlatformAppBar(
        title: PlatformText('Settings'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: ModalScrollController.of(context),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      radius: 32,
                      child: const Icon(
                        Icons.person,
                        color: Colors.white70,
                        size: 40,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: context.bodyText1,
                          ),
                          Text(
                            'nguyenanh@hotmail.de',
                            style: context.subtitle1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpaceTiny,
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                ),
                child: Column(
                  children: [
                    _buildSettingItem(
                      context,
                      title: 'Standard Calendar',
                      subtitle: 'nguyenanh@hotmail.de',
                    ),
                    const Divider(height: 24),
                    _buildSettingItem(
                      context,
                      title: 'Standard Project',
                      subtitle: 'Inbox',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSettingItem(BuildContext context,
      {required String title, String? subtitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.bodyText1,
            ),
            if (subtitle != null)
              Text(
                subtitle,
                style: context.subtitle1,
              ),
          ],
        ),
        const Icon(
          Icons.arrow_forward_ios,
        )
      ],
    );
  }
}
