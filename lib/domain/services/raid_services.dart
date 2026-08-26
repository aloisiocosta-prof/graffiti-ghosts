import '../../core/config/game_config.dart';
import '../entities/raid.dart';

class GhostScoreService {
  const GhostScoreService({this.config = GameConfig.defaults});

  final GameConfig config;

  ScoreBreakdown calculate(RaidState raid) {
    final timeRatio =
        (raid.timeRemaining / config.raidDurationSeconds).clamp(0.0, 1.0).toDouble();
    final timeScore = (timeRatio * config.maxTimeScore).round();
    final treasureScore = (raid.treasure * config.treasureUnitScore)
        .clamp(0, config.maxTreasureScore)
        .toInt();
    final failureScore =
        (config.maxFailureScore - raid.failures * config.failurePenalty)
            .clamp(0, config.maxFailureScore)
            .toInt();

    return ScoreBreakdown(
      time: timeScore,
      treasure: treasureScore,
      failures: failureScore,
    );
  }

  int calculateTotal(RaidState raid) =>
      calculate(raid).total.clamp(0, config.maxScore).toInt();
}

class RaidService {
  const RaidService({this.config = GameConfig.defaults});

  final GameConfig config;

  RaidState begin(RaidState raid) {
    if (raid.phase != RaidPhase.ready) return raid;
    return raid.copyWith(
      phase: RaidPhase.infiltrating,
      lastEvent: 'Infiltration started. Read the cyan route marks.',
    );
  }

  RaidState move(RaidState raid, {required double distance}) {
    if (!raid.isPlayable || raid.phase == RaidPhase.chasing) return raid;

    final nextProgress =
        (raid.progress + distance).clamp(0.0, 1.0).toDouble();
    final nextTime =
        (raid.timeRemaining - 2).clamp(0, config.raidDurationSeconds).toInt();
    final shouldChase = nextProgress >= 0.48 && nextProgress < 0.72;
    final nextHeat =
        shouldChase ? 100 : (raid.heat - 12).clamp(0, 100).toInt();

    return raid.copyWith(
      phase: shouldChase ? RaidPhase.chasing : RaidPhase.infiltrating,
      progress: nextProgress,
      timeRemaining: nextTime,
      heat: nextHeat,
      checkpointProgress: nextProgress >= 0.38
          ? config.checkpointProgress
          : raid.checkpointProgress,
      lastEvent: shouldChase
          ? 'Guard spotted you. Choose the violet alternative route.'
          : 'Acrobatics keep the patrol line cold.',
    );
  }

  RaidState activateGraffiti(RaidState raid) {
    if (!raid.isPlayable || raid.graffitiCharges <= 0) return raid;

    return raid.copyWith(
      graffitiCharges: raid.graffitiCharges - 1,
      graffitiActive: true,
      secretRouteRevealed: true,
      temporaryShortcutActive: true,
      trapAltered: true,
      progress: (raid.progress + 0.16).clamp(0.0, 1.0).toDouble(),
      timeRemaining:
          (raid.timeRemaining - 1).clamp(0, config.raidDurationSeconds).toInt(),
      heat: (raid.heat - 28).clamp(0, 100).toInt(),
      lastEvent: 'Graffiti awakened: secret route revealed, trap altered, shortcut active.',
    );
  }

  RaidState selectEscapeRoute(RaidState raid) {
    if (raid.phase != RaidPhase.chasing || !raid.secretRouteRevealed) return raid;

    return raid.copyWith(
      phase: RaidPhase.infiltrating,
      selectedRoute: RouteKind.escape,
      progress: (raid.progress + 0.12).clamp(0.0, 1.0).toDouble(),
      heat: 38,
      lastEvent: 'Alternative route selected. The chase is broken.',
    );
  }

  RaidState steal(RaidState raid) {
    if (!raid.isPlayable || raid.progress < 0.68) return raid;

    return raid.copyWith(
      treasure: raid.treasure + 1,
      progress: (raid.progress + 0.08).clamp(0.0, 1.0).toDouble(),
      timeRemaining:
          (raid.timeRemaining - 2).clamp(0, config.raidDurationSeconds).toInt(),
      checkpointProgress: config.checkpointProgress,
      lastEvent: 'Treasure secured. Extraction route is now the priority.',
    );
  }

  RaidState extract(RaidState raid) {
    if (!raid.isPlayable || raid.treasure <= 0 || raid.progress < 0.76) return raid;

    return raid.copyWith(
      phase: RaidPhase.completed,
      progress: 1,
      heat: 0,
      lastEvent: 'Perfect heist complete. Ghost comparison is ready.',
    );
  }

  RaidState triggerCapture(RaidState raid) {
    if (!raid.isPlayable) return raid;

    return raid.copyWith(
      phase: RaidPhase.captured,
      failures: raid.failures + 1,
      heat: 100,
      lastEvent: 'Captured. Keep the treasure or restart the raid.',
    );
  }

  RaidState restartWithoutSecondChance(RaidState raid) {
    if (raid.phase != RaidPhase.captured) return raid;
    return RaidState.initial(config: config).copyWith(
      failures: raid.failures,
      lastEvent: 'Raid reset. The stolen treasure was lost.',
    );
  }

  RaidState continueWithSecondChance(RaidState raid) {
    if (raid.phase != RaidPhase.captured) return raid;

    return raid.copyWith(
      phase: RaidPhase.infiltrating,
      progress: raid.checkpointProgress,
      treasure: (raid.treasure - 1).clamp(0, raid.treasure).toInt(),
      timeRemaining:
          (raid.timeRemaining - 10).clamp(0, config.raidDurationSeconds).toInt(),
      heat: 20,
      usedSecondChance: true,
      lastEvent: 'Second chance used: checkpoint restored with time and treasure penalties.',
    );
  }
}

class ProgressionService {
  const ProgressionService();

  ProgressionState claim(RaidResult result, ProgressionState current) {
    final storageLevel = result.treasure >= 1
        ? (current.storageLevel + 1).clamp(1, 3)
        : current.storageLevel;
    final unlocks = {...current.unlocks, 'WARDROBE_NEON_MASK'};
    return ProgressionState(
      bankedTreasure: current.bankedTreasure + result.treasure,
      reputation: current.reputation + result.reputation,
      storageLevel: storageLevel,
      unlocks: unlocks,
      activeCosmetic: 'NEON_MASK',
    );
  }
}

class ProgressionState {
  const ProgressionState({
    this.bankedTreasure = 0,
    this.reputation = 0,
    this.storageLevel = 1,
    this.unlocks = const <String>{},
    this.activeCosmetic = 'STARTER_HOOD',
  });

  final int bankedTreasure;
  final int reputation;
  final int storageLevel;
  final Set<String> unlocks;
  final String activeCosmetic;
}
