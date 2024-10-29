import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/data/graphql/__generated__/schema.schema.gql.dart';

class UserState {
  final String? id;
  final String? email;
  final String? name;
  final String? imageUrl;
  final String? category;
  final String? primaryCategory;

  const UserState({
    this.id,
    this.email,
    this.name,
    this.imageUrl,
    this.category,
    this.primaryCategory,
  });

  UserState copyWith({
    String? id,
    String? email,
    String? name,
    String? imageUrl,
    String? category,
    String? primaryCategory,
  }) {
    return UserState(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      primaryCategory: primaryCategory ?? this.primaryCategory,
    );
  }
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(const UserState());

  void updateUser({
    String? id,
    String? email,
    String? name,
    String? imageUrl,
    String? category,
    String? primaryCategory,
  }) {
    state = state.copyWith(
      id: id,
      email: email,
      name: name,
      imageUrl: imageUrl,
      category: category,
      primaryCategory: primaryCategory,
    );
  }

  void clearUser() {
    state = const UserState();
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});
