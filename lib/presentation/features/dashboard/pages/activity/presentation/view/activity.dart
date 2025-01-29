import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/components/activity_header.dart';

class ActivityView extends ConsumerWidget {
  const ActivityView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [ActivityHeader()],
          ),
        ),
      ),
    );
  }
}
