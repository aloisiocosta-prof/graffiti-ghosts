import 'package:flutter/foundation.dart';

import '../../application/raid/raid_application_service.dart';
import '../../domain/entities/raid.dart';
import '../../domain/services/raid_services.dart';

class RaidController extends ChangeNotifier {
  RaidController({RaidApplicationService? application})
      : _application = application ?? RaidApplicationService(),
        _state = RaidState.initial();

  final RaidApplicationService _application;
  RaidState _state;
  ProgressionState _progression = const ProgressionState();
  RaidResult? _result;
  bool _rewardClaimed = false;
  int _economicBonus = 0;

  RaidState get state => _state;
  ProgressionState get progression => _progression;
  RaidResult? get result => _result;
  bool get rewardClaimed => _rewardClaimed;
  int get economicBonus => _economicBonus;

  void _apply(RaidState next) {
    if (identical(_state, next)) return;
    _state = next;
    notifyListeners();
  }

  void begin() => _apply(_application.begin(_state));

  void moveLeft() => _apply(_application.moveLeft(_state));

  void moveRight() => _apply(_application.moveRight(_state));

  void jump() => _apply(_application.jump(_state));

  void wallGrab() => _apply(_application.wallGrab(_state));

  void slide() => _apply(_application.slide(_state));

  void activateGraffiti() => _apply(_application.activateGraffiti(_state));

  void escape() => _apply(_application.escape(_state));

  void steal() => _apply(_application.steal(_state));

  void extract() {
    _apply(_application.extract(_state));
    if (_state.phase == RaidPhase.completed) {
      _result = _application.buildResult(_state);
      notifyListeners();
    }
  }

  void triggerCapture() => _apply(_application.triggerCapture(_state));

  void restart() {
    _result = null;
    _rewardClaimed = false;
    _economicBonus = 0;
    _apply(_application.restart(_state));
  }

  void acceptSecondChance() {
    _result = null;
    _rewardClaimed = false;
    _economicBonus = 0;
    _apply(_application.secondChance(_state));
  }

  void claimReward() {
    final currentResult = _result;
    if (currentResult == null || _rewardClaimed) return;
    final rewardResult = RaidResult(
      score: currentResult.score,
      treasure: currentResult.treasure + _economicBonus,
      reputation: currentResult.reputation,
      breakdown: currentResult.breakdown,
      usedSecondChance: currentResult.usedSecondChance,
    );
    _progression = const ProgressionService().claim(rewardResult, _progression);
    _rewardClaimed = true;
    notifyListeners();
  }

  void acceptEconomicBonus() {
    if (_result == null || _economicBonus > 0) return;
    _economicBonus = 1;
    notifyListeners();
  }

  void replay() {
    _result = null;
    _rewardClaimed = false;
    _economicBonus = 0;
    _state = _application.initialState();
    notifyListeners();
  }
}
