///
/// draft_bottle_detail
///
/// created by DZDcyj at 2021/12/16
///
import 'package:flutter/cupertino.dart';
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/page/draft_bottle/view_model/draft_bottle_detail_provider.dart';

class DraftBottleDetail extends PageNodeProvider<DraftBottleDetailProvider> {
  DraftBottleDetail(this.id) : super(params: [id]);

  final int id;

  @override
  Widget buildContent(BuildContext context) => _DraftBottleDetailContent(mProvider);
}

class _DraftBottleDetailContent extends BasePageContentView<DraftBottleDetailProvider> {
  _DraftBottleDetailContent(DraftBottleDetailProvider provider) : super(provider);

  @override
  _DraftBottleDetailContentState createState() => _DraftBottleDetailContentState();
}

class _DraftBottleDetailContentState extends BasePageContentViewState<DraftBottleDetailProvider> {}
