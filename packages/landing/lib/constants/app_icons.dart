import 'package:jaspr/jaspr.dart';

class AppIcons {
  /// Menu Icon
  static final menu = [
    line([], attributes: {'x1': '4', 'x2': '20', 'y1': '12', 'y2': '12'}),
    line([], attributes: {'x1': '4', 'x2': '20', 'y1': '6', 'y2': '6'}),
    line([], attributes: {'x1': '4', 'x2': '20', 'y1': '18', 'y2': '18'}),
  ];

  /// X Icon
  static final x = [
    path([], attributes: {'d': 'M18 6 6 18'}),
    path([], attributes: {'d': 'm6 6 12 12'}),
  ];

  /// Close Icon
  static final close = [
    path([], attributes: {
      'stroke-linecap': 'round',
      'stroke-linejoin': 'round',
      'd': 'M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5'
    }),
  ];

  /// Users Icon
  static final users = [
    path([], attributes: {'d': 'M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2'}),
    circle([], attributes: {'cx': '9', 'cy': '7', 'r': '4'}),
    path([], attributes: {'d': 'M22 21v-2a4 4 0 0 0-3-3.87'}),
    path([], attributes: {'d': 'M16 3.13a4 4 0 0 1 0 7.75'}),
  ];

  /// Credit Card Icon
  static final creditCard = [
    rect([], attributes: {
      'width': '20',
      'height': '14',
      'x': '2',
      'y': '5',
      'rx': '2'
    }),
    line([], attributes: {'x1': '2', 'x2': '22', 'y1': '10', 'y2': '10'}),
  ];

  // 3. Mixed Shapes (e.g. User Circle)
  // <circle cx="12" cy="12" r="10"/><path d="..."/>
  static final userCircle = [
    circle([], attributes: {'cx': '12', 'cy': '12', 'r': '10'}),
    path([], attributes: {'d': 'M8 14s1.5 2 4 2 4-2 4-2'}),
  ];
}
