import 'package:equatable/equatable.dart';

class ProfileOrderItem extends Equatable {
  const ProfileOrderItem({
    required this.name,
    required this.quantity,
    required this.total,
    required this.thumbnail,
  });

  final String name;
  final int quantity;
  final double total;
  final String thumbnail;

  @override
  List<Object?> get props => [name, quantity, total, thumbnail];
}
