import 'package:flutter/material.dart';
import 'package:union_shop/util/slices.dart';

class Paginated extends StatefulWidget {
  final List<Widget> children;
  final int perPage;

  const Paginated({super.key, required this.children, this.perPage = 3});

  @override
  State<StatefulWidget> createState() => _PaginatedState();
}

class _PaginatedState extends State<Paginated> {
  int _pageIndex = 0;
  late List<List<Widget>> _childrenPartitioned;

  @override
  void didUpdateWidget(covariant Paginated oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.children != oldWidget.children || widget.perPage != oldWidget.perPage) {
      setState(() {
        _childrenPartitioned = partition(widget.children, widget.perPage);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _childrenPartitioned = partition(widget.children, widget.perPage);
  }

  void _previousPage() {
    if (_pageIndex - 1 < 0) {
      setState(() {
        _pageIndex = _childrenPartitioned.length - 1;
      });
    } else {
      setState(() {
        _pageIndex--;
      });
    }
  }

  void _nextPage() {
    if (_pageIndex + 1 >= _childrenPartitioned.length) {
      setState(() {
        _pageIndex = 0;
      });
    } else {
      setState(() {
        _pageIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.count(
            primary: false,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: _childrenPartitioned[_pageIndex]),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            IconButton(
                onPressed: _previousPage, icon: const Icon(Icons.arrow_left)),
            const Spacer(),
            Text("Page ${_pageIndex + 1} of ${_childrenPartitioned.length}"),
            const Spacer(),
            IconButton(
                onPressed: _nextPage, icon: const Icon(Icons.arrow_right)),
          ],
        )
      ],
    );
  }
}
