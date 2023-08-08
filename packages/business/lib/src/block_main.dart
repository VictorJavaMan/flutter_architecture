import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:data/data.dart';
import 'package:model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'block_main.freezed.dart';

@injectable
class BlockMain {
  final UserService userService;
  final StreamController<BlockMainEvent> _eventController = StreamController();
  final StreamController<BlockMainState> _stateController = StreamController.broadcast();

  Stream<BlockMainState> get state => _stateController.stream;

  BlockMain({required this.userService}) {
    _eventController.stream.listen((event) {
      event.map<void>(
        init: (_) async {
          _stateController.add(const BlockMainState.loading());
          _stateController.add(
            BlockMainState.loaded(
              userData: await userService.getDefaultUser(),
            ),
          );
        },
        setUser: (event) async => _stateController.add(
          BlockMainState.loaded(
            userData: await userService.getUserById(event.userId),
          ),
        ),
      );
    });
  }

  void add(BlockMainEvent event) {
    if (_eventController.isClosed) return;
    _eventController.add(event);
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}

@freezed
class BlockMainState with _$BlockMainState {
  const factory BlockMainState.loading() = MainLoadingState;
  const factory BlockMainState.loaded({required UserData userData}) = MainLoadedState;
}

@freezed
class BlockMainEvent with _$BlockMainEvent {
  const factory BlockMainEvent.init() = _MainInitEvent;
  const factory BlockMainEvent.setUser({required int userId}) = _MainSetEvent;
}