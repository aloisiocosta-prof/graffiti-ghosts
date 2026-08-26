import '../../core/config/game_config.dart';
import '../../domain/entities/raid.dart';
import '../../domain/services/raid_services.dart';

class RaidApplicationService {
  RaidApplicationService({
    RaidService? raidService,
    GhostScoreService? scoreService,
  })  : _raidService = raidService ?? const RaidService(),
        _scoreService = scoreService ?? const GhostScoreService();

  final RaidService _raidService;
  final GhostScoreService _scoreService;

  RaidState initialState() => RaidState.initial(config: GameConfig.defaults);

  RaidState begin(RaidState state) => _raidService.begin(state);

  RaidState moveLeft(RaidState state) =>
      _raidService.move(state, distance: -0.025);

  RaidState moveRight(RaidState state) =>
      _raidService.move(state, distance: 0.06);

  RaidState jump(RaidState state) =>
      _raidService.move(state, distance: 0.10);

  RaidState wallGrab(RaidState state) =>
      _raidService.move(state, distance: 0.12);

  RaidState slide(RaidState state) =>
      _raidService.move(state, distance: 0.14);

  RaidState activateGraffiti(RaidState state) =>
      _raidService.activateGraffiti(state);

  RaidState escape(RaidState state) => _raidService.selectEscapeRoute(state);

  RaidState steal(RaidState state) => _raidService.steal(state);

  RaidState extract(RaidState state) => _raidService.extract(state);

  RaidState triggerCapture(RaidState state) => _raidService.triggerCapture(state);

  RaidState restart(RaidState state) =>
      _raidService.restartWithoutSecondChance(state);

  RaidState secondChance(RaidState state) =>
      _raidService.continueWithSecondChance(state);

  RaidResult buildResult(RaidState state) {
    final breakdown = _scoreService.calculate(state);
    return RaidResult(
      score: breakdown.total,
      treasure: state.treasure,
      reputation: 10 + state.treasure * 3,
      breakdown: breakdown,
      usedSecondChance: state.usedSecondChance,
    );
  }
}
