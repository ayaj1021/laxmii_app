import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/presentation/general_widgets/empty_page.dart';

class AiInsightsHistory extends ConsumerStatefulWidget {
  const AiInsightsHistory({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AiInsightsHistoryState();
}

class _AiInsightsHistoryState extends ConsumerState<AiInsightsHistory> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: const EmptyPage(
              emptyMessage: 'No History Yet',
            ),
          )
        ],
      ),
    );
  }
}
