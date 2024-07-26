import 'package:flutter/material.dart';

// The colors for the gradient
const _gradientColors = [
  Color(0xF5000000),
  Color(0xFF303030),
  Color(0xFF000000),
];

// A class that transforms the gradient for the shimmer effect
class _SlidingGradientTransform extends GradientTransform {
  /// Constructor for the class
  ///
  /// [slidePercent] - The percentage of the slide for the shimmer effect
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  // The percentage of the slide for the shimmer effect
  final double slidePercent;

  /// Transforms the gradient based on the slide percentage
  ///
  /// [bounds] - The bounds of the gradient
  /// [textDirection] - The text direction (optional)
  ///
  /// Returns the transformation matrix
  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

// A widget that provides a shimmer effect
class Shimmer extends StatefulWidget {
  /// Get the state of the shimmer widget
  ///
  /// [context] - The build context
  ///
  /// Returns the state of the shimmer widget
  static _ShimmerState? of(BuildContext context) {
    return context.findAncestorStateOfType<_ShimmerState>();
  }

  /// Constructor for the Shimmer widget
  ///
  /// [key] - The key for the widget
  /// [linearGradient] - The gradient for the shimmer effect
  /// [child] - The child widget that the shimmer effect is applied to
  const Shimmer({
    super.key,
    this.colors = _gradientColors,
    required this.child,
  });

  final List<Color> colors;
  // The gradient for the shimmer effect
  final LinearGradient linearGradient = const LinearGradient(
    colors: [],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  // The child widget that the shimmer effect is applied to
  final Widget child;

  /// Creates the mutable state for this widget
  @override
  State<Shimmer> createState() => _ShimmerState();
}

// The mutable state for a [Shimmer] widget
class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  // The controller for the shimmer animation
  late AnimationController _shimmerController;

  /// Initialize the state
  @override
  void initState() {
    super.initState();
    // Create the animation controller
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(
        min: -0.5,
        max: 1.5,
        period: const Duration(
          milliseconds: 1000,
        ),
      );
  }

  /// Dispose the state
  @override
  void dispose() {
    // Dispose the animation controller
    _shimmerController.dispose();
    super.dispose();
  }

  /// Get the gradient for the shimmer effect
  ///
  /// Returns the gradient for the shimmer effect
  LinearGradient get gradient => LinearGradient(
        colors: widget.colors,
        stops: widget.linearGradient.stops,
        begin: widget.linearGradient.begin,
        end: widget.linearGradient.end,
        transform: _SlidingGradientTransform(
          slidePercent: _shimmerController.value,
        ),
      );

  /// Check if the render object has size
  ///
  /// Returns true if the render object has size, false otherwise
  bool get isSized =>
      (context.findRenderObject() as RenderBox?)?.hasSize ?? false;

  /// Get the size of the render object
  ///
  /// Returns the size of the render object
  Size get size => (context.findRenderObject() as RenderBox).size;

  /// Get the offset of the descendant render object
  ///
  /// [descendant] - The descendant render object
  /// [offset] - The offset (optional)
  ///
  /// Returns the offset of the descendant render object
  Offset getDescendantOffset(
      {required RenderBox descendant, Offset offset = Offset.zero}) {
    final shimmerBox = context.findRenderObject() as RenderBox;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  /// Get the changes in the shimmer effect
  ///
  /// Returns the changes in the shimmer effect
  Listenable get shimmerChanges => _shimmerController;

  /// Build the widget
  ///
  /// [context] - The build context
  ///
  /// Returns the widget
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

// A widget that shows a shimmer loading effect, should wrap this with a [Container()] widget with appropriate width and height
class ShimmerLoading extends StatefulWidget {
  /// Constructor for the ShimmerLoading widget
  ///
  /// [key] - The key for the widget
  /// [isLoading] - Whether the loading effect is showing
  /// [loadingChild] - The child widget that is shown when loading
  /// [secondChild] - The child widget that is shown when not loading
  /// [loaderMargin] - The margin for the loader (optional)
  /// [loaderPadding] - The padding for the loader (optional)
  /// [loaderHeight] - The height for the loader (optional)
  /// [loaderWidth] - The width for the loader (optional)
  /// [loaderDecoration] - The decoration for the loader (optional)
  /// [loaderAlignment] - The alignment for the loader (optional)
  const ShimmerLoading({
    super.key,
    required this.isLoading,
    required this.loadingChild,
    required this.secondChild,
    this.loaderMargin = EdgeInsets.zero,
    this.loaderPadding = EdgeInsets.zero,
    this.loaderHeight = -1,
    this.loaderWidth = double.infinity,
    this.loaderDecoration = const BoxDecoration(),
    this.loaderAlignment = Alignment.center,
  });

  // Whether the loading effect is showing
  final bool isLoading;

  // The child widget that is shown when loading, should use [Container()] widgets and give it a default color
  final Widget loadingChild;

  // The child widget that is shown when not loading
  final Widget secondChild;

  // The decoration for the loader
  final Decoration loaderDecoration;

  // The margin for the loader
  final EdgeInsets loaderMargin;

  // The padding for the loader
  final EdgeInsets loaderPadding;

  // The height for the loader
  final double loaderHeight;

  // The width for the loader
  final double loaderWidth;

  // The alignment for the loader
  final Alignment loaderAlignment;

  /// Creates the mutable state for this widget
  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

// The mutable state for a [ShimmerLoading] widget
class _ShimmerLoadingState extends State<ShimmerLoading> {
  /// Initialize the state
  @override
  void initState() {
    super.initState();
  }

  // The changes in the shimmer effect
  Listenable? _shimmerChanges;

  /// Called when a dependency of this state object changes
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Remove the listener if it exists
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    // Add a listener to the shimmer effect
    _shimmerChanges = Shimmer.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }

  /// Called when the shimmer effect changes
  void _onShimmerChange() {
    setState(() {});
  }

  /// Dispose the state
  @override
  void dispose() {
    // Remove the listener
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  /// Build the widget
  ///
  /// [context] - The build context
  ///
  /// Returns the widget
  @override
  Widget build(BuildContext context) {
    // Return the second child if not loading
    if (!widget.isLoading) {
      return widget.secondChild;
    }
    // Get the shimmer context
    final shimmer = Shimmer.of(context);
    if (shimmer == null || !shimmer.isSized) {
      // Return an empty box if Shimmer context is null
      return const SizedBox();
    }
    // Get the shimmer size and gradient
    final shimmerSize = shimmer.size;
    final gradient = shimmer.gradient;
    // Get the offset of the render object
    final renderObject = context.findRenderObject();
    Offset offsetWithinShimmer = Offset.zero;
    // Get the offset of the descendant render object
    if (renderObject is RenderBox) {
      offsetWithinShimmer = shimmer.getDescendantOffset(
        descendant: renderObject,
      );
    }

    // Return the shimmer effect
    return Container(
      alignment: widget.loaderAlignment,
      margin: widget.loaderMargin,
      padding: widget.loaderPadding,
      height: widget.loaderHeight == -1 ? null : widget.loaderHeight,
      width: widget.loaderWidth,
      decoration: widget.loaderDecoration,
      child: ShaderMask(
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
      ),
    );
  }
}
