part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();
}

class HomePageLoading extends HomePageState {
  @override
  List<Object> get props => [];
}

class HomePageLoaded extends HomePageState {
  final Map<String, dynamic> homeContent;

  const HomePageLoaded(this.homeContent);

  @override
  List<Object> get props => [homeContent];
}

class HomePageError extends HomePageState {
  @override
  List<Object> get props => [];
}
