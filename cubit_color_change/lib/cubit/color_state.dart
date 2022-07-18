part of 'color_cubit.dart';

abstract class ColorState extends Equatable {
  final Color color;
  const ColorState(this.color);

  @override
  List<Object> get props => [color];
}

class ColorInitial extends ColorState {
  const ColorInitial() : super(Colors.grey);
}

class ColorDownloaded extends ColorState {
  final Color newColor;
  const ColorDownloaded(this.newColor) : super(newColor);
}

//just for simulating network or loading
class ColorNetworkFetching extends ColorState {
  const ColorNetworkFetching() : super(Colors.grey);
}
