import 'package:flutter/material.dart';

class HoverScale extends StatefulWidget {
  final Widget child;
  final double scale;
  final Duration duration;

  const HoverScale({
    super.key,
    required this.child,
    this.scale = 1.05,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  State<HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<HoverScale> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: _isHovering ? widget.scale : 1.0,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

class HoverColor extends StatefulWidget {
  final String text;
  final TextStyle baseStyle;
  final Color hoverColor;

  const HoverColor({
    super.key,
    required this.text,
    required this.baseStyle,
    required this.hoverColor,
  });

  @override
  State<HoverColor> createState() => _HoverColorState();
}

class _HoverColorState extends State<HoverColor> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: widget.baseStyle.copyWith(
          color: _isHovering ? widget.hoverColor : widget.baseStyle.color,
        ),
        child: Text(widget.text),
      ),
    );
  }
}
