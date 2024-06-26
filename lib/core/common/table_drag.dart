
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../images/image.dart';

class TableDragPage extends StatefulWidget {
  final double containerWidth;
  final double containerHeight;

  const TableDragPage({
    super.key,
    required this.containerWidth,
    required this.containerHeight,
  });

  @override
  State<TableDragPage> createState() => _TableDragState();
}

class _TableDragState extends State<TableDragPage> {
  Offset _offset = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned(
                left: _offset.dx,
                top: _offset.dy,
                child: LongPressDraggable(
                  feedback: Image.asset(
                    AppImage.available,
                    height: 50,
                    color: Colors.orangeAccent,
                    colorBlendMode: BlendMode.colorBurn,
                  ),
                  child: Image.asset(
                    AppImage.available,
                    height: 50,
                  ),
                  onDragEnd: (details) {
                    setState(() {
                      // Get the local position within the container
                      RenderBox renderBox = context.findRenderObject() as RenderBox;
                      Offset localPosition = renderBox.globalToLocal(details.offset);

                      // Ensure the new offset is within the bounds of the container
                      double newX = localPosition.dx;
                      double newY = localPosition.dy;

                      // Adjustments to ensure the draggable widget remains within bounds
                      if (newX < 0) newX = 0;
                      if (newY < 0) newY = 0;
                      if (newX > widget.containerWidth - 50) newX = widget.containerWidth - 50; // Assuming image width is 50
                      if (newY > widget.containerHeight - 50) newY = widget.containerHeight - 50; // Assuming image height is 50

                      _offset = Offset(newX, newY);
                    });
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
