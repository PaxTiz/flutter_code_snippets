import 'package:flutter/material.dart';

enum ResizeIndicatorPosition { left, right, top, bottom }

extension ResizeDirection on ResizeIndicatorPosition {
  bool isHorizontal() {
    return this == ResizeIndicatorPosition.left ||
        this == ResizeIndicatorPosition.right;
  }
}

class ResizableWidget extends StatefulWidget {
  final Widget child;
  final ResizeIndicatorPosition indicatorPosition;
  final ValueSetter<double> onDrag;

  const ResizableWidget({
    super.key,
    required this.child,
    required this.onDrag,
    this.indicatorPosition = ResizeIndicatorPosition.right,
  });

  @override
  createState() => _ResizableWidget();
}

class _ResizableWidget extends State<ResizableWidget> {
  Color? _indicatorColor;

  void _onHover(bool enter) {
    setState(() => _indicatorColor = enter ? Colors.grey.shade700 : null);
  }

  @override
  Widget build(BuildContext context) {
    final indicator = MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: widget.indicatorPosition.isHorizontal()
          ? SystemMouseCursors.resizeColumn
          : SystemMouseCursors.resizeRow,
      child: GestureDetector(
        onPanUpdate: (e) {
          if (widget.indicatorPosition.isHorizontal()) {
            final position = e.globalPosition.dx;
            if (position > 0 && position < MediaQuery.of(context).size.width) {
              widget.onDrag(position);
            }
          } else {
            final position = e.globalPosition.dy;
            if (position > 0 && position < MediaQuery.of(context).size.height) {
              widget.onDrag(position);
            }
          }
        },
        child: VerticalDivider(
          width: 2,
          thickness: 2,
          color: _indicatorColor,
        ),
      ),
    );

    switch (widget.indicatorPosition) {
      case ResizeIndicatorPosition.left:
        return Row(children: [indicator, widget.child]);
      case ResizeIndicatorPosition.right:
        return Row(children: [widget.child, indicator]);
      case ResizeIndicatorPosition.top:
        return Column(children: [indicator, widget.child]);
      case ResizeIndicatorPosition.bottom:
        return Column(children: [widget.child, indicator]);
    }
  }
}
