import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/date_format.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/notifier/get_all_quotes_notifier.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/view/create_quote_view.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/view/quote_details_view.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/widgets/get_quotes_widget.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class QuoteView extends ConsumerStatefulWidget {
  const QuoteView({super.key});
  static const String routeName = '/quoteView';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuoteViewState();
}

class _QuoteViewState extends ConsumerState<QuoteView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAllQuotesNotifierProvider.notifier).getAllQuotes();

      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final quotesList = ref.watch(getAllQuotesNotifierProvider
        .select((v) => v.getAllQuotes.data?.quote ?? []));
    final isLoading = ref.watch(
        getAllQuotesNotifierProvider.select((v) => v.loadState.isLoading));
    return PageLoader(
      isLoading: isLoading,
      child: Scaffold(
        appBar: LaxmiiAppBar(
          centerTitle: true,
          title: 'Quote',
          actions: [
            GestureDetector(
              onTap: () => context.pushNamed(CreateQuoteView.routeName),
              child: const Icon(
                Icons.add_circle,
                color: AppColors.primaryColor,
              ),
            )
          ],
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ListView.builder(
                    itemCount: quotesList.length,
                    itemBuilder: (_, index) {
                      final data = quotesList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => QuoteDetailsView(
                                        quoteId: '${data.id}',
                                      )));
                        },
                        child: Column(
                          children: [
                            GetQuotesWidget(
                              quoteTitle: '${data.customerName}',
                              quoteAmount: '\$${data.totalAmount}',
                              quoteDate:
                                  formatDateTimeFromString('${data.issueDate}'),
                            ),
                            const VerticalSpacing(10),
                          ],
                        ),
                      );
                    }))),
      ),
    );
  }
}
