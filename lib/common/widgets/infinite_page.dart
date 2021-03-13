import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fuzzgram/common/blocs/infinite_list/infinite_bloc.dart';
import 'package:fuzzgram/common/widgets/bottom_loader.dart';
import 'package:fuzzgram/common/widgets/template_card.dart';

class InfinitePage extends StatefulWidget {
  @override
  InfinitePageState createState() => InfinitePageState();
}

class InfinitePageState extends State<InfinitePage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  InfiniteBloc infiniteBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    infiniteBloc = BlocProvider.of<InfiniteBloc>(context);
  }

  Widget stateToView(InfiniteState state) {
    if (state is InfiniteInitial) {
      return Center(child: BottomLoader());
    } else if (state is InfiniteSuccess) {
      final templatesList = state.templates;
      return StaggeredGridView.countBuilder(
        padding: EdgeInsets.only(bottom: 90.0),
        controller: _scrollController,
        shrinkWrap: true,
        crossAxisCount: 2,
        staggeredTileBuilder: (index) {
          return StaggeredTile.fit(index >= templatesList.length ? 2 : 1);
        },
        itemCount: state.hasReachedMax
            ? templatesList.length
            : templatesList.length + 1,
        itemBuilder: (context, index) {
          return index >= templatesList.length
              ? (state.hasReachedMax ? Center() : BottomLoader())
              : GridTile(
              child: TemplateWidget(template: templatesList[index]));
        },
      );
    } else {
      return Center(child: Text("Error"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfiniteBloc, InfiniteState>(builder: (context, state) {
      return stateToView(state);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      infiniteBloc.add(FetchTemplates());
    }
  }
}
