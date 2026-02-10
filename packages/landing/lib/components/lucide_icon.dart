import 'package:jaspr/jaspr.dart';

class LucideIcon extends StatelessComponent {
  // Changed from String pathData to List<Component>
  final List<Component> children;
  final String? classes;
  final double size;

  const LucideIcon({
    required this.children,
    this.classes,
    this.size = 24,
    super.key,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield svg(
      classes: classes,
      attributes: {
        'xmlns': 'http://www.w3.org/2000/svg',
        'width': '$size',
        'height': '$size',
        'viewBox': '0 0 24 24',
        'fill': 'none',
        'stroke': 'currentColor',
        'stroke-width': '2',
        'stroke-linecap': 'round',
        'stroke-linejoin': 'round',
      },
      children, // Injects the specific shapes (rect, line, path, etc.) here
    );
  }
}
