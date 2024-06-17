import 'package:flutter/material.dart';

// Define a constant for the shimmer gradient
const _shimmerGradient = LinearGradient(
  colors: [
    Color(0xF5000000),
    Color(0xFF303030),
    Color(0xFF000000),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

// A class that transforms the gradient for the shimmer effect
class _SlidingGradientTransform extends GradientTransform {
  // Constructor for the class
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  // The percentage of the slide for the shimmer effect
  final double slidePercent;

  // Transforms the gradient based on the slide percentage
  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

// A widget that provides a shimmer effect
class Shimmer extends StatefulWidget {
  static _ShimmerState? of(BuildContext context) {
    return context.findAncestorStateOfType<_ShimmerState>();
  }

  // Constructor for the Shimmer widget
  const Shimmer({
    super.key,
    this.linearGradient = _shimmerGradient,
    required this.child,
  });

  // The gradient for the shimmer effect
  final LinearGradient linearGradient;
  // The child widget that the shimmer effect is applied to
  final Widget child;

  // Creates the mutable state for this widget
  @override
  State<Shimmer> createState() => _ShimmerState();
}

// The mutable state for a [Shimmer] widget
class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  // The controller for the shimmer animation
  late AnimationController _shimmerController;

  // Initialize the state
  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(
        min: -0.5,
        max: 1.5,
        period: const Duration(
          milliseconds: 1000,
        ),
      );
  }

  // Dispose the state
  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  // Get the gradient for the shimmer effect
  LinearGradient get gradient => LinearGradient(
        colors: widget.linearGradient.colors,
        stops: widget.linearGradient.stops,
        begin: widget.linearGradient.begin,
        end: widget.linearGradient.end,
        transform: _SlidingGradientTransform(
          slidePercent: _shimmerController.value,
        ),
      );

  // Check if the render object has size
  bool get isSized =>
      (context.findRenderObject() as RenderBox?)?.hasSize ?? false;

  // Get the size of the render object
  Size get size => (context.findRenderObject() as RenderBox).size;

  // Get the offset of the descendant render object
  Offset getDescendantOffset(
      {required RenderBox descendant, Offset offset = Offset.zero}) {
    final shimmerBox = context.findRenderObject() as RenderBox;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  // Get the changes in the shimmer effect
  Listenable get shimmerChanges => _shimmerController;

  // Build the widget
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

// A widget that shows a shimmer loading effect, should wrap this with a [Container()] widget with appropriate width and height
class ShimmerLoading extends StatefulWidget {
  // Constructor for the ShimmerLoading widget
  const ShimmerLoading({
    super.key,
    required this.isLoading,
    required this.loadingChild,
    required this.secondChild,
  });

  // Whether the loading effect is showing
  final bool isLoading;
  // The child widget that is shown when loading, should use [Container()] widgets and give it a default color
  final Widget loadingChild;
  // The child widget that is shown when not loading
  final Widget secondChild;

  // Creates the mutable state for this widget
  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

// The mutable state for a [ShimmerLoading] widget
class _ShimmerLoadingState extends State<ShimmerLoading> {
  // Initialize the state
  @override
  void initState() {
    super.initState();
  }

  // The changes in the shimmer effect
  Listenable? _shimmerChanges;

  // Called when a dependency of this state object changes
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    _shimmerChanges = Shimmer.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }

  // Called when the shimmer effect changes
  void _onShimmerChange() {
    setState(() {});
  }

  // Dispose the state
  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  // Build the widget
  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.secondChild;
    }
    final shimmer = Shimmer.of(context);
    if (shimmer == null || !shimmer.isSized) {
      // Return an empty box if Shimmer context is null
      return const SizedBox();
    }
    final shimmerSize = shimmer.size;
    final gradient = shimmer.gradient;
    final renderObject = context.findRenderObject();
    Offset offsetWithinShimmer = Offset.zero;
    if (renderObject is RenderBox) {
      offsetWithinShimmer = shimmer.getDescendantOffset(
        descendant: renderObject,
      );
    }

    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(
            -offsetWithinShimmer.dx,
            -offsetWithinShimmer.dy,
            shimmerSize.width,
            shimmerSize.height,
          ),
        );
      },
      blendMode: BlendMode.srcATop,
      child: widget.loadingChild,
    );
  }
}
