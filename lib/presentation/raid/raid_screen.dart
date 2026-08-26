import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/config/asset_manifest.dart' as assets;
import '../../domain/entities/raid.dart';
import '../../domain/services/raid_services.dart';
import 'raid_controller.dart';

enum RaidScreenStage { selection, raid, results, base }

class RaidScreen extends StatefulWidget {
  const RaidScreen({super.key});

  @override
  State<RaidScreen> createState() => _RaidScreenState();
}

class _RaidScreenState extends State<RaidScreen> {
  final RaidController _controller = RaidController();
  final FocusNode _focusNode = FocusNode();
  RaidScreenStage _stage = RaidScreenStage.selection;

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _startRaid() {
    _controller.begin();
    setState(() => _stage = RaidScreenStage.raid);
    _focusNode.requestFocus();
  }

  void _extract() {
    _controller.extract();
    if (_controller.state.phase == RaidPhase.completed) {
      setState(() => _stage = RaidScreenStage.results);
    }
  }

  void _replay() {
    _controller.replay();
    setState(() => _stage = RaidScreenStage.raid);
    _controller.begin();
    _focusNode.requestFocus();
  }

  KeyEventResult _handleKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent || _stage != RaidScreenStage.raid) {
      return KeyEventResult.ignored;
    }
    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.arrowLeft || key == LogicalKeyboardKey.keyA) {
      _controller.moveLeft();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowRight || key == LogicalKeyboardKey.keyD) {
      _controller.moveRight();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.space) {
      _controller.jump();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.keyW) {
      _controller.wallGrab();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.keyS) {
      _controller.slide();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.keyG) {
      _controller.activateGraffiti();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Scaffold(
          body: SafeArea(
            child: Focus(
              focusNode: _focusNode,
              autofocus: true,
              onKeyEvent: _handleKey,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 260),
                child: _buildStage(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStage() {
    switch (_stage) {
      case RaidScreenStage.selection:
        return _buildSelection();
      case RaidScreenStage.raid:
        return _buildRaid();
      case RaidScreenStage.results:
        return _buildResults();
      case RaidScreenStage.base:
        return _buildBase();
    }
  }

  Widget _buildSelection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 700;
        return Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              assets.AssetManifest.fortressKeyArt,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
            Container(color: const Color(0xD90A0820)),
            SingleChildScrollView(
              padding: EdgeInsets.all(compact ? 20 : 48),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 980),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBrandLockup(),
                      SizedBox(height: compact ? 56 : 110),
                      Text(
                        'THE NEON VAULT',
                        style: TextStyle(
                          fontSize: compact ? 34 : 58,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 3,
                          color: const Color(0xFFFDFDFF),
                          shadows: const [
                            Shadow(color: Color(0xFF25E7FF), blurRadius: 18),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const SizedBox(
                        width: 650,
                        child: Text(
                          'A short stealth raid through a rooftop fortress. Read the patrols, paint your shortcut, steal the relic, and race your ghost home.',
                          style: TextStyle(
                            color: Color(0xFFE2E7FF),
                            fontSize: 17,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      _buildSelectionCards(compact),
                      const SizedBox(height: 28),
                      FilledButton.icon(
                        onPressed: _startRaid,
                        icon: const Icon(Icons.login_rounded),
                        label: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text('ENTER FORTRESS'),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF25E7FF),
                          foregroundColor: const Color(0xFF08101D),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Keyboard: A/D move · Space jump · W wall-grab · S slide · G graffiti',
                        style: TextStyle(color: Color(0xFFAEB6D8), fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBrandLockup() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF25E7FF),
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [BoxShadow(color: Color(0x9925E7FF), blurRadius: 18)],
          ),
          child: const Icon(Icons.bolt_rounded, color: Color(0xFF08101D)),
        ),
        const SizedBox(width: 14),
        const Text(
          'GRAFFITI GHOSTS',
          style: TextStyle(
            color: Color(0xFF25E7FF),
            fontWeight: FontWeight.w900,
            letterSpacing: 2.5,
            fontSize: 19,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectionCards(bool compact) {
    final cards = [
      _infoCard(
        icon: Icons.diamond_outlined,
        title: 'REWARD',
        value: 'Relic + reputation',
        accent: const Color(0xFFA9FF2F),
      ),
      _infoCard(
        icon: Icons.visibility_outlined,
        title: 'GHOST BENCHMARK',
        value: '12% route lead',
        accent: const Color(0xFFA78BFA),
      ),
      _infoCard(
        icon: Icons.timer_outlined,
        title: 'TARGET',
        value: 'Under 03:00',
        accent: const Color(0xFF25E7FF),
      ),
    ];
    return Wrap(spacing: 12, runSpacing: 12, children: cards);
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color accent,
  }) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xCC121034),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withValues(alpha: .55)),
      ),
      child: Row(
        children: [
          Icon(icon, color: accent),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Color(0xFFAEB6D8), fontSize: 10, letterSpacing: 1)),
                const SizedBox(height: 4),
                Text(value, style: TextStyle(color: accent, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRaid() {
    final state = _controller.state;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(painter: FortressRaidPainter(state: state)),
            Container(color: const Color(0x330A0820)),
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 22),
              child: Column(
                children: [
                  _buildRaidHeader(state),
                  const SizedBox(height: 18),
                  _buildRouteLegend(state),
                  SizedBox(height: constraints.maxHeight < 650 ? 160 : 250),
                  if (state.phase == RaidPhase.chasing) _buildChaseBanner(),
                  if (state.phase == RaidPhase.captured) _buildCapturePanel(),
                  if (state.phase == RaidPhase.completed)
                    _buildCompletedNotice()
                  else if (state.phase != RaidPhase.captured)
                    _buildControls(state),
                  const SizedBox(height: 14),
                  _buildEventLog(state),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRaidHeader(RaidState state) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Image.asset(
                assets.AssetManifest.thiefAnimation,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.person, color: Color(0xFF25E7FF)),
              ),
              const SizedBox(width: 10),
              const Text(
                'NEON VAULT / RAID 01',
                style: TextStyle(color: Color(0xFFFDFDFF), fontWeight: FontWeight.w900, letterSpacing: 1.2),
              ),
            ],
          ),
        ),
        _hudChip('TIME', _formatTime(state.timeRemaining), const Color(0xFF25E7FF)),
        const SizedBox(width: 8),
        _hudChip('TREASURE', '${state.treasure}', const Color(0xFFA9FF2F)),
        const SizedBox(width: 8),
        _hudChip('HEAT', '${state.heat}%', state.heat > 60 ? const Color(0xFFED28C5) : const Color(0xFFA9FF2F)),
      ],
    );
  }

  Widget _hudChip(String label, String value, Color color) {
    return Semantics(
      label: '$label $value',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xDD121034),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: .58)),
        ),
        child: Column(
          children: [
            Text(label, style: const TextStyle(fontSize: 9, letterSpacing: 1, color: Color(0xFFAEB6D8))),
            Text(value, style: TextStyle(fontWeight: FontWeight.w900, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteLegend(RaidState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xCC121034),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0x554D4B8A)),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 18,
        runSpacing: 8,
        children: [
          _legend('YOU', const Color(0xFFA9FF2F)),
          _legend('GHOST', const Color(0xFFA78BFA)),
          _legend('SAFE ROUTE', const Color(0xFF25E7FF)),
          if (state.secretRouteRevealed) _legend('ALTERNATIVE', const Color(0xFFED28C5)),
          if (state.trapAltered) _legend('TRAP ALTERED', const Color(0xFFA9FF2F)),
        ],
      ),
    );
  }

  Widget _legend(String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: .8)),
      ],
    );
  }

  Widget _buildControls(RaidState state) {
    final canSteal = state.progress >= .68;
    final canExtract = state.treasure > 0 && state.progress >= .76;
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            _actionButton(Icons.arrow_back_rounded, 'MOVE', _controller.moveLeft),
            _actionButton(Icons.arrow_forward_rounded, 'MOVE', _controller.moveRight),
            _actionButton(Icons.keyboard_arrow_up_rounded, 'JUMP', _controller.jump, accent: const Color(0xFF25E7FF)),
            _actionButton(Icons.pan_tool_alt_rounded, 'WALL-GRAB', _controller.wallGrab),
            _actionButton(Icons.south_rounded, 'SLIDE', _controller.slide),
            _actionButton(
              Icons.auto_fix_high_rounded,
              state.graffitiCharges > 0 ? 'GRAFFITI' : 'USED',
              _controller.activateGraffiti,
              accent: state.graffitiCharges > 0 ? const Color(0xFFED28C5) : const Color(0xFF6E7191),
            ),
            _actionButton(
              Icons.diamond_rounded,
              canSteal ? 'STEAL' : 'LOCKED',
              _controller.steal,
              accent: canSteal ? const Color(0xFFA9FF2F) : const Color(0xFF6E7191),
            ),
            _actionButton(
              Icons.exit_to_app_rounded,
              canExtract ? 'EXTRACT' : 'LOCKED',
              _extract,
              accent: canExtract ? const Color(0xFFFFB84D) : const Color(0xFF6E7191),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Semantics(
          label: 'Raid route progress ${(_percent(state.progress))} percent; ghost ${(_percent(state.ghostProgress))} percent',
          child: Text(
            'ROUTE ${_percent(state.progress)}%   ·   GHOST ${_percent(state.ghostProgress)}%',
            style: const TextStyle(color: Color(0xFFE2E7FF), letterSpacing: 1.8, fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }

  Widget _actionButton(
    IconData icon,
    String label,
    VoidCallback action, {
    Color accent = const Color(0xFFE2E7FF),
  }) {
    return Semantics(
      button: true,
      label: label,
      child: SizedBox(
        width: 92,
        height: 72,
        child: OutlinedButton(
          onPressed: action,
          style: OutlinedButton.styleFrom(
            foregroundColor: accent,
            side: BorderSide(color: accent.withValues(alpha: .82)),
            backgroundColor: const Color(0xCC121034),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24),
              const SizedBox(height: 3),
              Text(label, style: const TextStyle(fontSize: 9, letterSpacing: .6, fontWeight: FontWeight.w800)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChaseBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xE6ED28C5),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFF91E9), width: 2),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Color(0xFF21061D), size: 30),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'DETECTED — the guard is in pursuit. Select the revealed alternative route to escape.',
              style: TextStyle(color: Color(0xFF21061D), fontWeight: FontWeight.w900),
            ),
          ),
          const SizedBox(width: 10),
          FilledButton(
            onPressed: _controller.escape,
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFF21061D), foregroundColor: Colors.white),
            child: const Text('ESCAPE'),
          ),
        ],
      ),
    );
  }

  Widget _buildCapturePanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xF2121034),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFED28C5)),
      ),
      child: Column(
        children: [
          const Text('CAPTURED', style: TextStyle(color: Color(0xFFED28C5), fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 2)),
          const SizedBox(height: 8),
          const Text('Your checkpoint is still warm. Choose the trade-off before retrying.', style: TextStyle(color: Color(0xFFE2E7FF)), textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: [
              OutlinedButton.icon(
                onPressed: _controller.acceptSecondChance,
                icon: const Icon(Icons.replay_rounded),
                label: const Text('SECOND CHANCE  ·  -1 TREASURE / -10s'),
              ),
              TextButton(
                onPressed: _controller.restart,
                child: const Text('RESET RAID  ·  LOSE TREASURE'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedNotice() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xE61A3C2A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFA9FF2F), width: 2),
      ),
      child: const Text(
        'EXTRACTION COMPLETE — continue to the ghost comparison.',
        textAlign: TextAlign.center,
        style: TextStyle(color: Color(0xFFA9FF2F), fontWeight: FontWeight.w900, letterSpacing: 1.2),
      ),
    );
  }

  Widget _buildEventLog(RaidState state) {
    return Row(
      children: [
        const Icon(Icons.radar_rounded, color: Color(0xFFA78BFA), size: 18),
        const SizedBox(width: 8),
        Expanded(child: Text(state.lastEvent, style: const TextStyle(color: Color(0xFFBBC4E8), fontSize: 12))),
      ],
    );
  }

  Widget _buildResults() {
    final result = _controller.result;
    if (result == null) return const SizedBox.shrink();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Image.asset(assets.AssetManifest.ghostReplay, width: 96, height: 96, fit: BoxFit.cover),
              const SizedBox(height: 12),
              const Text('PERFECT HEIST', style: TextStyle(color: Color(0xFFA9FF2F), fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: 2)),
              const SizedBox(height: 8),
              const Text('Your violet ghost finished the route. Compare mastery, then bank the reward.', style: TextStyle(color: Color(0xFFE2E7FF), fontSize: 16), textAlign: TextAlign.center),
              const SizedBox(height: 24),
              _scoreCard(result),
              const SizedBox(height: 16),
              _buildBonusCard(result),
              const SizedBox(height: 18),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  FilledButton.icon(
                    onPressed: _controller.claimReward,
                    icon: Icon(_controller.rewardClaimed ? Icons.check_circle : Icons.account_balance_wallet_rounded),
                    label: Text(_controller.rewardClaimed ? 'REWARD BANKED' : 'CLAIM REWARD'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => setState(() => _stage = RaidScreenStage.base),
                    icon: const Icon(Icons.home_work_outlined),
                    label: const Text('VIEW HIDEOUT'),
                  ),
                  TextButton(onPressed: _replay, child: const Text('REPLAY RAID')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _scoreCard(RaidResult result) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xE6121034),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF25E7FF)),
        boxShadow: const [BoxShadow(color: Color(0x3325E7FF), blurRadius: 28)],
      ),
      child: Column(
        children: [
          const Text('COMBINED GHOST SCORE', style: TextStyle(color: Color(0xFFAEB6D8), letterSpacing: 1.4, fontSize: 11)),
          const SizedBox(height: 4),
          Text('${result.score}', style: const TextStyle(color: Color(0xFF25E7FF), fontSize: 52, fontWeight: FontWeight.w900)),
          const SizedBox(height: 18),
          _scoreRow('TIME  ·  40%', result.breakdown.time, const Color(0xFF25E7FF)),
          _scoreRow('TREASURE  ·  40%', result.breakdown.treasure, const Color(0xFFA9FF2F)),
          _scoreRow('FAILURES  ·  20%', result.breakdown.failures, const Color(0xFFA78BFA)),
          const Divider(color: Color(0x334D4B8A), height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('TREASURE BANKED', style: TextStyle(color: Color(0xFFAEB6D8), fontWeight: FontWeight.w700)),
              Text('${result.treasure}', style: const TextStyle(color: Color(0xFFA9FF2F), fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('REPUTATION', style: TextStyle(color: Color(0xFFAEB6D8), fontWeight: FontWeight.w700)),
              Text('+${result.reputation}', style: const TextStyle(color: Color(0xFFED28C5), fontWeight: FontWeight.w900)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _scoreRow(String label, int value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(color: Color(0xFFE2E7FF), fontSize: 12))),
          Text('$value', style: TextStyle(color: color, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }

  Widget _buildBonusCard(RaidResult result) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x99121034),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0x55A9FF2F)),
      ),
      child: Row(
        children: [
          const Icon(Icons.play_circle_outline_rounded, color: Color(0xFFA9FF2F)),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'OPTIONAL BONUS: watch an ad to add +1 economic treasure. It never changes the ghost score.',
              style: TextStyle(color: Color(0xFFE2E7FF), fontSize: 12, height: 1.35),
            ),
          ),
          const SizedBox(width: 10),
          TextButton(onPressed: _controller.acceptEconomicBonus, child: Text(_controller.economicBonus > 0 ? 'ADDED' : 'OPTIONAL')),
        ],
      ),
    );
  }

  Widget _buildBase() {
    final progression = _controller.progression;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              const Text('HIDEOUT', style: TextStyle(color: Color(0xFF25E7FF), fontSize: 34, fontWeight: FontWeight.w900, letterSpacing: 2)),
              const SizedBox(height: 8),
              const Text('Every clean escape changes the space you call home.', style: TextStyle(color: Color(0xFFE2E7FF), fontSize: 16)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Image.asset(assets.AssetManifest.thiefSheet, width: 104, height: 104, fit: BoxFit.cover),
                  const SizedBox(width: 16),
                  Expanded(child: _baseSummary(progression)),
                ],
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 14,
                runSpacing: 14,
                children: [
                  _baseCard(Icons.inventory_2_outlined, 'STORAGE', 'LEVEL ${progression.storageLevel}', 'Capacity improved after the heist.', const Color(0xFFA9FF2F)),
                  _baseCard(Icons.auto_awesome_outlined, 'REPUTATION', '${progression.reputation}', 'The rooftops know your mark.', const Color(0xFFED28C5)),
                  _baseCard(Icons.checkroom_outlined, 'WARDROBE', progression.activeCosmetic, 'Cosmetic identity does not affect score.', const Color(0xFFA78BFA)),
                ],
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  OutlinedButton.icon(onPressed: _replay, icon: const Icon(Icons.arrow_back_rounded), label: const Text('RETURN TO RAID')),
                  const SizedBox(width: 12),
                  const Text('Functional + visual progression unlocked', style: TextStyle(color: Color(0xFFAEB6D8), fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _baseSummary(ProgressionState progression) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xCC121034),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF4D4B8A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('CURRENT LOADOUT', style: TextStyle(color: Color(0xFFAEB6D8), fontSize: 11, letterSpacing: 1.2)),
          const SizedBox(height: 8),
          Text('${progression.bankedTreasure} treasure in vault', style: const TextStyle(color: Color(0xFFA9FF2F), fontSize: 20, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          Text('${progression.unlocks.length} functional/cosmetic unlocks', style: const TextStyle(color: Color(0xFFE2E7FF))),
        ],
      ),
    );
  }

  Widget _baseCard(IconData icon, String title, String value, String description, Color accent) {
    return SizedBox(
      width: 270,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xCC121034),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: accent.withValues(alpha: .56)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: accent, size: 30),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(color: Color(0xFFAEB6D8), fontSize: 11, letterSpacing: 1.2)),
            const SizedBox(height: 5),
            Text(value, style: TextStyle(color: accent, fontSize: 18, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(color: Color(0xFFE2E7FF), height: 1.35)),
          ],
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remaining = seconds % 60;
    return '$minutes:${remaining.toString().padLeft(2, '0')}';
  }

  int _percent(double value) => (value * 100).round();
}

class FortressRaidPainter extends CustomPainter {
  FortressRaidPainter({required this.state});

  final RaidState state;

  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()..color = const Color(0xFF0A0820);
    canvas.drawRect(Offset.zero & size, background);

    final building = Paint()..color = const Color(0xFF17143E);
    for (var index = 0; index < 9; index++) {
      final x = index * size.width / 8 - 45;
      final double height = 140 + (index % 3) * 58;
      canvas.drawRect(Rect.fromLTWH(x, size.height - height - 72, 150, height), building);
    }

    final routeY = size.height * .51;
    final route = Path()
      ..moveTo(24, routeY + 40)
      ..lineTo(size.width * .25, routeY - 30)
      ..lineTo(size.width * .48, routeY + 18)
      ..lineTo(size.width * .72, routeY - 54)
      ..lineTo(size.width - 24, routeY - 6);

    final safeRoute = Paint()
      ..color = const Color(0xFF25E7FF)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    canvas.drawPath(route, safeRoute);

    if (state.secretRouteRevealed) {
      final shortcut = Path()
        ..moveTo(size.width * .43, routeY + 16)
        ..quadraticBezierTo(size.width * .58, routeY + 115, size.width * .84, routeY - 8);
      final alternative = Paint()
        ..color = const Color(0xFFED28C5)
        ..strokeWidth = 7
        ..style = PaintingStyle.stroke;
      canvas.drawPath(shortcut, alternative);
    }

    if (state.temporaryShortcutActive) {
      final platform = Paint()
        ..color = const Color(0xFFED28C5)
        ..strokeWidth = 12
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(Offset(size.width * .53, routeY - 86), Offset(size.width * .67, routeY - 86), platform);
    }

    if (state.trapAltered) {
      final alteredTrap = Paint()
        ..color = const Color(0xFFA9FF2F)
        ..strokeWidth = 4
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(Offset(size.width * .31, routeY + 10), 26, alteredTrap);
      canvas.drawLine(Offset(size.width * .28, routeY - 10), Offset(size.width * .34, routeY + 30), alteredTrap);
    }

    final playerX = (size.width * state.progress).clamp(24.0, size.width - 24.0);
    final ghostX = (size.width * state.ghostProgress).clamp(24.0, size.width - 24.0);
    final playerPaint = Paint()
      ..color = const Color(0xFFA9FF2F)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(playerX, routeY - 26), 18, playerPaint);
    canvas.drawCircle(Offset(playerX, routeY - 26), 25, Paint()..color = const Color(0x55A9FF2F));

    final ghostPaint = Paint()
      ..color = const Color(0xFFA78BFA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(Offset(ghostX, routeY - 60), 15, ghostPaint);
    canvas.drawLine(Offset(ghostX - 12, routeY - 45), Offset(ghostX - 4, routeY - 22), ghostPaint);
    canvas.drawLine(Offset(ghostX + 12, routeY - 45), Offset(ghostX + 4, routeY - 22), ghostPaint);

    final graffitiPaint = Paint()
      ..color = const Color(0xFFED28C5)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;
    canvas.drawArc(Rect.fromLTWH(size.width * .76, routeY - 200, 90, 90), .2, 4.8, false, graffitiPaint);
    canvas.drawLine(Offset(size.width * .78, routeY - 148), Offset(size.width * .86, routeY - 212), Paint()..color = const Color(0xFFA9FF2F)..strokeWidth = 5);
  }

  @override
  bool shouldRepaint(covariant FortressRaidPainter oldDelegate) => oldDelegate.state != state;
}
