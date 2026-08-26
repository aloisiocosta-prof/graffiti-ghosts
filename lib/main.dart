import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const GraffitiGhostsApp());
}

class GraffitiGhostsApp extends StatelessWidget {
  const GraffitiGhostsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graffiti Ghosts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0820),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF25E7FF),
          secondary: Color(0xFFED28C5),
          tertiary: Color(0xFFA9FF2F),
        ),
      ),
      home: const RaidScreen(),
    );
  }
}

class RaidScreen extends StatefulWidget {
  const RaidScreen({super.key});

  @override
  State<RaidScreen> createState() => _RaidScreenState();
}

class _RaidScreenState extends State<RaidScreen> {
  double _progress = 0.18;
  double _ghostProgress = 0.14;
  int _treasure = 2;
  int _failures = 0;
  int _time = 47;
  bool _chase = false;
  bool _graffitiReady = true;
  bool _complete = false;

  void _move(double delta) {
    if (_complete) return;
    setState(() {
      _progress = (_progress + delta).clamp(0.0, 1.0);
      _time = math.max(0, _time - 1);
      if (_progress > 0.55 && _progress < 0.78) _chase = true;
      if (_progress >= 1.0) _complete = true;
    });
  }

  void _activateGraffiti() {
    if (!_graffitiReady || _complete) return;
    setState(() {
      _graffitiReady = false;
      _progress = (_progress + 0.16).clamp(0.0, 1.0);
      _chase = false;
      _time = math.max(0, _time - 2);
    });
  }

  void _escape() {
    if (!_chase || _complete) return;
    setState(() {
      _chase = false;
      _progress = (_progress + 0.09).clamp(0.0, 1.0);
      _time = math.max(0, _time - 3);
    });
  }

  void _collect() {
    if (_complete) return;
    setState(() {
      _treasure += 1;
      _progress = (_progress + 0.12).clamp(0.0, 1.0);
      _time = math.max(0, _time - 1);
      if (_progress >= 1.0) _complete = true;
    });
  }

  int get _score {
    final timeScore = ((_time / 60) * 400).round();
    final treasureScore = math.min(_treasure * 90, 400);
    final failureScore = math.max(0, 200 - (_failures * 100));
    return math.max(0, timeScore + treasureScore + failureScore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                  painter: FortressPainter(progress: _progress, ghost: _ghostProgress),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 18),
                  child: Column(
                    children: [
                      _buildHeader(),
                      const Spacer(),
                      if (_chase) _buildChaseBanner(),
                      if (_complete) _buildResultPanel() else _buildControls(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Text('GRAFFITI GHOSTS', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, color: Color(0xFF25E7FF))),
        const Spacer(),
        _hudChip('TIME', '00:${_time.toString().padLeft(2, '0')}'),
        const SizedBox(width: 8),
        _hudChip('TREASURE', '$_treasure'),
        const SizedBox(width: 8),
        _hudChip('HEAT', _chase ? 'HIGH' : 'LOW', color: _chase ? const Color(0xFFED28C5) : const Color(0xFFA9FF2F)),
      ],
    );
  }

  Widget _hudChip(String label, String value, {Color color = const Color(0xFF25E7FF)}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(color: const Color(0xCC121034), border: Border.all(color: color.withOpacity(.5))),
      child: Column(children: [Text(label, style: const TextStyle(fontSize: 9, letterSpacing: 1, color: Color(0xFFCBD1E8))), Text(value, style: TextStyle(fontWeight: FontWeight.w900, color: color))]),
    );
  }

  Widget _buildChaseBanner() => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        color: const Color(0xCCED28C5),
        child: Row(children: [const Icon(Icons.warning_amber_rounded), const SizedBox(width: 10), const Expanded(child: Text('DETECTED — choose an alternative route')), ElevatedButton(onPressed: _escape, child: const Text('ESCAPE'))]),
      );

  Widget _buildControls() {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _actionButton(Icons.keyboard_arrow_left, 'MOVE', () => _move(-.04)),
          const SizedBox(width: 12),
          _actionButton(Icons.keyboard_arrow_up, 'JUMP', () => _move(.08), accent: const Color(0xFF25E7FF)),
          const SizedBox(width: 12),
          _actionButton(Icons.keyboard_arrow_right, 'MOVE', () => _move(.06)),
          const SizedBox(width: 12),
          _actionButton(Icons.bolt, 'GRAFFITI', _activateGraffiti, accent: _graffitiReady ? const Color(0xFFED28C5) : const Color(0xFF5E6078)),
          const SizedBox(width: 12),
          _actionButton(Icons.diamond, 'STEAL', _collect, accent: const Color(0xFFA9FF2F)),
        ]),
        const SizedBox(height: 12),
        Text('ROUTE ${(100 * _progress).round()}%  ·  GHOST ${(100 * _ghostProgress).round()}%', style: const TextStyle(letterSpacing: 2, color: Color(0xFFCBD1E8))),
      ],
    );
  }

  Widget _actionButton(IconData icon, String label, VoidCallback action, {Color accent = const Color(0xFFCBD1E8)}) {
    return SizedBox(width: 82, height: 70, child: OutlinedButton(onPressed: action, style: OutlinedButton.styleFrom(side: BorderSide(color: accent), foregroundColor: accent, padding: const EdgeInsets.only(top: 7)), child: Column(children: [Icon(icon, size: 27), Text(label, style: const TextStyle(fontSize: 9, letterSpacing: 1))])));
  }

  Widget _buildResultPanel() => Container(
        width: 520,
        padding: const EdgeInsets.all(22),
        color: const Color(0xEE121034),
        child: Column(children: [
          const Text('PERFECT HEIST', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFFA9FF2F), letterSpacing: 2)),
          const SizedBox(height: 12),
          Text('SCORE  $_score', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF25E7FF))),
          const SizedBox(height: 8),
          const Text('Ghost comparison unlocked · Base reward ready', style: TextStyle(color: Color(0xFFCBD1E8))),
          const SizedBox(height: 16),
          OutlinedButton(onPressed: () => setState(() { _progress = .18; _treasure = 2; _time = 47; _complete = false; _chase = false; }), child: const Text('REPLAY RAID')),
        ]),
      );
}

class FortressPainter extends CustomPainter {
  FortressPainter({required this.progress, required this.ghost});
  final double progress;
  final double ghost;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFF0A0820);
    canvas.drawRect(Offset.zero & size, bg);
    final wall = Paint()..color = const Color(0xFF17143E);
    final cyan = Paint()..color = const Color(0xFF25E7FF)..strokeWidth = 6..style = PaintingStyle.stroke;
    final magenta = Paint()..color = const Color(0xFFED28C5)..strokeWidth = 5..style = PaintingStyle.stroke;
    final lime = Paint()..color = const Color(0xFFA9FF2F)..strokeWidth = 5..style = PaintingStyle.stroke;
    for (var i = 0; i < 8; i++) {
      final x = (i * size.width / 7) - 50;
      final double h = 170 + (i % 3) * 80;
      canvas.drawRect(Rect.fromLTWH(x, size.height - h - 100, 170, h), wall);
    }
    final routeY = size.height * .56;
    final route = Path()..moveTo(30, routeY)..lineTo(size.width * .33, routeY - 75)..lineTo(size.width * .58, routeY + 18)..lineTo(size.width - 36, routeY - 105);
    canvas.drawPath(route, cyan);
    canvas.drawLine(Offset(size.width * .46, routeY - 10), Offset(size.width * .58, routeY + 18), magenta);
    canvas.drawCircle(Offset(size.width * progress.clamp(.05, .95), routeY - 35), 18, lime);
    canvas.drawCircle(Offset(size.width * ghost.clamp(.05, .95), routeY - 70), 15, Paint()..color = const Color(0xFFA78BFA));
    final graffiti = Paint()..color = const Color(0xFFED28C5)..strokeWidth = 7..style = PaintingStyle.stroke;
    canvas.drawArc(Rect.fromLTWH(size.width * .68, routeY - 180, 90, 90), .3, 4.6, false, graffiti);
    canvas.drawLine(Offset(size.width * .73, routeY - 150), Offset(size.width * .82, routeY - 205), lime);
  }

  @override
  bool shouldRepaint(covariant FortressPainter oldDelegate) => oldDelegate.progress != progress || oldDelegate.ghost != ghost;
}
