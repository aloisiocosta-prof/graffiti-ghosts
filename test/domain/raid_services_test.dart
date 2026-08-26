import 'package:flutter_test/flutter_test.dart';

import 'package:graffiti_ghosts/core/config/game_config.dart';
import 'package:graffiti_ghosts/domain/entities/raid.dart';
import 'package:graffiti_ghosts/domain/services/raid_services.dart';

void main() {
  const config = GameConfig.defaults;
  const service = RaidService(config: config);
  const scoreService = GhostScoreService(config: config);

  RaidState infiltration() => service.begin(RaidState.initial(config: config));

  test('GHOST-SCORE-001 applies 40/40/20 bounded components', () {
    var state = infiltration();
    state = state.copyWith(timeRemaining: 120, treasure: 5, failures: 0);

    final breakdown = scoreService.calculate(state);

    expect(breakdown.time, 400);
    expect(breakdown.treasure, 400);
    expect(breakdown.failures, 200);
    expect(breakdown.total, 1000);
  });

  test('GHOST-SCORE-002 is independent from economic bonuses', () {
    final state = infiltration();
    final baseScore = scoreService.calculateTotal(state);
    final bonusState = state.copyWith(treasure: state.treasure + 1);

    expect(scoreService.calculateTotal(bonusState), greaterThan(baseScore));
    expect(scoreService.calculate(state).total, baseScore);
  });

  test('GRAFFITI-001 and GRAFFITI-002 reveal route and alter the trap once', () {
    final state = service.activateGraffiti(infiltration());
    final unchanged = service.activateGraffiti(state);

    expect(state.graffitiCharges, 0);
    expect(state.secretRouteRevealed, isTrue);
    expect(state.temporaryShortcutActive, isTrue);
    expect(state.trapAltered, isTrue);
    expect(unchanged, same(state));
  });

  test('RAID-OUTCOME-002 starts a chase instead of an automatic failure', () {
    var state = infiltration();
    state = service.move(state, distance: .5);

    expect(state.phase, RaidPhase.chasing);
    expect(state.failures, 0);
    expect(state.heat, 100);
  });

  test('RAID-OUTCOME-003 escapes through an revealed alternative route', () {
    var state = service.activateGraffiti(infiltration());
    state = service.move(state, distance: .5);
    state = service.selectEscapeRoute(state);

    expect(state.phase, RaidPhase.infiltrating);
    expect(state.selectedRoute, RouteKind.escape);
    expect(state.progress, greaterThan(.6));
  });

  test('RAID-OUTCOME-001 resets and loses collected treasure after capture', () {
    var state = infiltration().copyWith(progress: .8, treasure: 2);
    state = service.triggerCapture(state);
    final reset = service.restartWithoutSecondChance(state);

    expect(state.phase, RaidPhase.captured);
    expect(reset.phase, RaidPhase.ready);
    expect(reset.treasure, 0);
    expect(reset.failures, 1);
  });

  test('RAID-OUTCOME-004 resumes from checkpoint with penalties', () {
    var state = infiltration().copyWith(
      progress: .8,
      checkpointProgress: .46,
      treasure: 2,
      timeRemaining: 80,
    );
    state = service.triggerCapture(state);
    final continued = service.continueWithSecondChance(state);

    expect(continued.phase, RaidPhase.infiltrating);
    expect(continued.progress, .46);
    expect(continued.treasure, 1);
    expect(continued.timeRemaining, 70);
    expect(continued.usedSecondChance, isTrue);
  });

  test('completed raid produces a result only after theft and extraction', () {
    var state = infiltration().copyWith(progress: .8, treasure: 1);
    state = service.extract(state);

    expect(state.phase, RaidPhase.completed);
    expect(state.progress, 1);
  });
}
