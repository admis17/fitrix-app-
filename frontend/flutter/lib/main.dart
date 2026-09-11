import 'package:flutter/material.dart';
import 'theme.dart';

void main() => runApp(const FitomaticApp());

class FitomaticApp extends StatelessWidget {
  const FitomaticApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitRix',
      debugShowCheckedModeBanner: false,
      theme: fitTheme(),
      home: const RootNav(),
    );
  }
}

// Spec owners: Home-Adarsh, Challenges-Bhushan,
// Streaks/Today/Progress/Wallet/Profile-Vedant, Login-Adarsh
class RootNav extends StatefulWidget {
  const RootNav({super.key});
  @override
  State<RootNav> createState() => _RootNavState();
}

class _RootNavState extends State<RootNav> {
  int _index = 0;

  void _go(int i) => setState(() => _index = i);
  void _open(Widget page) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomeScreen(
        onOpenChallenges: () => _go(1),
        onOpenStreaks: () => _go(2),
        onOpenWallet: () => _go(3),
        onOpenProfile: () => _go(4),
        onOpenToday: () => _open(const SubPage(child: TodayGoalScreen())),
        onOpenProgress: () => _open(const SubPage(child: ProgressScreen())),
        onOpenLogin: () => _open(const SubPage(child: LoginSetupScreen())),
      ),
      ChallengesScreen(onOpenLogin: () => _open(const SubPage(child: LoginSetupScreen()))),
      const StreaksScreen(),
      const WalletScreen(),
      ProfileScreen(onOpenLogin: () => _open(const SubPage(child: LoginSetupScreen()))),
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: SafeArea(
          child: FitTopBar(
            onWallet: () => _go(3),
            onProfile: () => _go(4),
          ),
        ),
      ),
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: FitColors.line))),
        child: BottomNavigationBar(
          currentIndex: _index,
          onTap: _go,
          type: BottomNavigationBarType.fixed,
          backgroundColor: FitColors.bg,
          selectedItemColor: FitColors.volt,
          unselectedItemColor: FitColors.muted,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.emoji_events), label: 'Challenges'),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_fire_department), label: 'Streaks'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

// Sub-pages pushed from Home (Today / Progress / Login) get their own scaffold + back.
class SubPage extends StatelessWidget {
  final Widget child;
  const SubPage({required this.child, super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: FitColors.bg,
          foregroundColor: FitColors.text,
          title: const Text('FITRIX',
              style: TextStyle(fontWeight: FontWeight.w900))),
      body: child,
    );
  }
}

// ---------- shared ----------

class FitTopBar extends StatelessWidget {
  final VoidCallback onWallet;
  final VoidCallback onProfile;
  const FitTopBar({required this.onWallet, required this.onProfile, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: FitColors.bg,
      child: Row(
        children: [
          const Text('FIT',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
          const Text('RIX',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: FitColors.volt)),
          const SizedBox(width: 12),
          const Expanded(
            child: SizedBox(
              height: 38,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search challenges',
                  hintStyle:
                      TextStyle(color: FitColors.muted, fontSize: 13),
                  prefixIcon:
                      Icon(Icons.search, size: 18, color: FitColors.muted),
                  filled: true,
                  fillColor: FitColors.surface,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: FitColors.line)),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: onWallet,
              icon: const Icon(Icons.account_balance_wallet,
                  color: FitColors.text)),
          GestureDetector(
            onTap: onProfile,
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [FitColors.volt, Color(0xFF6FAE1C)])),
              alignment: Alignment.center,
              child: const Text('JM',
                  style: TextStyle(
                      color: Color(0xFF0F1113),
                      fontWeight: FontWeight.w800,
                      fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration cardDec() => BoxDecoration(
      color: FitColors.surface,
      border: Border.all(color: FitColors.line),
      borderRadius: BorderRadius.circular(18),
    );

class SectionHead extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;
  const SectionHead(this.title, {this.action, this.onAction, super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title.toUpperCase(),
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: FitColors.muted)),
          if (action != null)
            GestureDetector(
                onTap: onAction,
                child: Text(action!,
                    style: const TextStyle(
                        color: FitColors.volt,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}

class GoalBar extends StatelessWidget {
  final double pct;
  const GoalBar(this.pct, {super.key});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: LinearProgressIndicator(
        value: pct,
        minHeight: 8,
        backgroundColor: FitColors.surface2,
        valueColor: const AlwaysStoppedAnimation(FitColors.volt),
      ),
    );
  }
}

// ---------- 1. HOME (Adarsh) ----------

class HomeScreen extends StatefulWidget {
  final VoidCallback onOpenChallenges;
  final VoidCallback onOpenStreaks;
  final VoidCallback onOpenWallet;
  final VoidCallback onOpenProfile;
  final VoidCallback onOpenToday;
  final VoidCallback onOpenProgress;
  final VoidCallback onOpenLogin;
  const HomeScreen({
    required this.onOpenChallenges,
    required this.onOpenStreaks,
    required this.onOpenWallet,
    required this.onOpenProfile,
    required this.onOpenToday,
    required this.onOpenProgress,
    required this.onOpenLogin,
    super.key,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String category = 'Strength';
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      children: [
        // page list (spec 2)
        const SectionHead('Pages'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _PageChip('Challenges', Icons.emoji_events, widget.onOpenChallenges),
            _PageChip('Streaks', Icons.local_fire_department, widget.onOpenStreaks),
            _PageChip('Today goal', Icons.today, widget.onOpenToday),
            _PageChip('Progress', Icons.trending_up, widget.onOpenProgress),
            _PageChip('Wallet', Icons.account_balance_wallet, widget.onOpenWallet),
            _PageChip('Profile', Icons.person, widget.onOpenProfile),
            _PageChip('Login setup', Icons.qr_code_2, widget.onOpenLogin),
          ],
        ),
        // challenger video + text (spec 3)
        const SectionHead('Featured challenge'),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: cardDec(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                    color: FitColors.surface2,
                    borderRadius: BorderRadius.circular(12)),
                alignment: Alignment.center,
                child: const Icon(Icons.play_circle_fill,
                    size: 48, color: FitColors.volt),
              ),
              const SizedBox(height: 10),
              const Text('September Sweat Challenge',
                  style:
                      TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
              const SizedBox(height: 4),
              const Text(
                  'Log 20 workouts this month to unlock the club merch drop and 500 bonus points.',
                  style: TextStyle(fontSize: 12.5, color: FitColors.muted)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: ['Strength', 'Cardio', 'Yoga'].map((c) {
                  final sel = category == c;
                  return ChoiceChip(
                    label: Text(c,
                        style: TextStyle(
                            color: sel
                                ? const Color(0xFF0F1113)
                                : FitColors.text,
                            fontSize: 12)),
                    selected: sel,
                    selectedColor: FitColors.volt,
                    backgroundColor: FitColors.surface2,
                    onSelected: (_) => setState(() => category = c),
                  );
                }).toList(),
              ),
              Text('Showing challenges for: $category',
                  style: const TextStyle(
                      fontSize: 11.5, color: FitColors.muted)),
            ],
          ),
        ),
        // streak left + login setup right (spec 7)
        const SectionHead('Streak & check-in'),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: widget.onOpenStreaks,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: cardDec(),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('12',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 24,
                              color: FitColors.heat)),
                      Text('Day streak 🔥',
                          style: TextStyle(
                              fontSize: 12, color: FitColors.muted)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: widget.onOpenLogin,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: cardDec(),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.qr_code_2, color: FitColors.volt),
                      SizedBox(height: 6),
                      Text('Tap to check in',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 13)),
                      Text('Barcode · Face · Bio',
                          style: TextStyle(
                              fontSize: 11.5, color: FitColors.muted)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        // today goal strip (spec 8)
        SectionHead('Today goal', action: 'Open', onAction: widget.onOpenToday),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: cardDec(),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Upper Body Push',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  Text('4/6 done',
                      style: TextStyle(
                          fontSize: 12, color: FitColors.muted)),
                ],
              ),
              SizedBox(height: 8),
              GoalBar(0.65),
            ],
          ),
        ),
        // weekly/monthly strip (spec 9)
        SectionHead('Weekly / Monthly',
            action: 'Details', onAction: widget.onOpenProgress),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: cardDec(),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('4/5 this week · 12/20 September',
                  style: TextStyle(
                      fontSize: 12.5, fontWeight: FontWeight.w600)),
              SizedBox(height: 8),
              GoalBar(0.6),
              SizedBox(height: 6),
              Text('Remark: on track, keep pushing 💪',
                  style:
                      TextStyle(fontSize: 11.5, color: FitColors.muted)),
            ],
          ),
        ),
      ],
    );
  }
}

class _PageChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _PageChip(this.label, this.icon, this.onTap);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
            color: FitColors.surface,
            border: Border.all(color: FitColors.line),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: FitColors.volt),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 12.5)),
          ],
        ),
      ),
    );
  }
}

// ---------- 2. CHALLENGES (Bhushan) ----------

class ChallengesScreen extends StatelessWidget {
  final VoidCallback onOpenLogin;
  const ChallengesScreen({required this.onOpenLogin, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      children: [
        // header with meaningful subtitle (replaces debug "Bhushan · same navbar")
        const Padding(
          padding: EdgeInsets.only(top: 4, bottom: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Challenges',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                      letterSpacing: -0.5)),
              SizedBox(height: 2),
              Text('Today • 3 active • 12 Sept',
                  style: TextStyle(fontSize: 12.5, color: FitColors.muted)),
            ],
          ),
        ),
        const SectionHead('Today challenges'),
        _ChChallengeCard(
            icon: Icons.bolt,
            title: 'HIIT Circuit',
            meta: '⏱ 6:30 PM · Coach Rae · Strength',
            status: 'Join',
            isJoin: true,
            onTap: onOpenLogin),
        _ChChallengeCard(
            icon: Icons.self_improvement,
            title: 'Power Yoga',
            meta: '⏱ 7:15 PM · Coach Tom · Flex',
            status: 'Full',
            isJoin: false),
        _ChChallengeCard(
            icon: Icons.directions_bike,
            title: 'Spin & Burn',
            meta: '⏱ 8:00 PM · Coach Alex · Cardio',
            status: 'Join',
            isJoin: true,
            onTap: onOpenLogin),
        const SectionHead('Challenger spotlight'),
        Container(
          decoration: cardDec(),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 148,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1B2600),
                      Color(0xFF243600),
                      Color(0xFF0F1400)
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.55)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(Icons.play_arrow,
                            color: Color(0xFF121212), size: 28),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 4),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.55),
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                    color: Colors.white24)),
                            child: const Text('▶ 30s preview',
                                style: TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 4),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.65),
                                borderRadius: BorderRadius.circular(6)),
                            child: const Text('0:30',
                                style: TextStyle(
                                    fontSize: 10.5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(14, 12, 14, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Challenger intro — September Sweat',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 13)),
                    SizedBox(height: 2),
                    Text('Top form this week • Tap to watch full',
                        style: TextStyle(
                            fontSize: 12, color: FitColors.muted)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SectionHead('Leaderboard'),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: cardDec(),
          child: const Column(
            children: [
              _LbRow(
                  rank: 1,
                  initials: 'SK',
                  name: 'Sara K.',
                  attempts: '14',
                  pts: '980',
                  rankColor: FitColors.volt),
              _LbRow(
                  rank: 2,
                  initials: 'DM',
                  name: 'Diego M.',
                  attempts: '12',
                  pts: '920',
                  rankColor: Color(0xFFE8E8E8)),
              _LbSelfRow(),
            ],
          ),
        ),
        const SectionHead('Prize pool'),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0x3348FF00)),
            borderRadius: BorderRadius.all(Radius.circular(16)),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF252A1E), Color(0xFF1E1E1E)]),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _PrizeIcon(),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('TOTAL POOL',
                          style: TextStyle(
                              fontSize: 10,
                              letterSpacing: 0.6,
                              color: FitColors.muted,
                              fontWeight: FontWeight.w700)),
                      Text('Set by gym & participants',
                          style: TextStyle(
                              fontSize: 11, color: FitColors.muted)),
                    ],
                  ),
                ],
              ),
              Text('₹5,000',
                  style: TextStyle(
                      color: FitColors.volt,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      letterSpacing: -0.3)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 3.2,
          children: [
            _PrimaryAction('Participate', Icons.check_circle, onOpenLogin),
            _SecondaryAction('Add challenge', Icons.add, () {}),
            _SecondaryAction('History', Icons.history, () {}),
            _SecondaryAction('Add prize', Icons.payments, () {}),
          ],
        ),
      ],
    );
  }
}

class _ChChallengeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String meta;
  final String status;
  final bool isJoin;
  final VoidCallback? onTap;
  const _ChChallengeCard(
      {required this.icon,
      required this.title,
      required this.meta,
      required this.status,
      required this.isJoin,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(13),
        decoration: cardDec(),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: FitColors.surface2,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: FitColors.line)),
              child: Icon(icon, size: 18, color: FitColors.text),
            ),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 13.5)),
                  Text(meta,
                      style: const TextStyle(
                          fontSize: 12, color: FitColors.muted)),
                ])),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
              decoration: BoxDecoration(
                  color: isJoin
                      ? FitColors.volt.withOpacity(0.13)
                      : FitColors.heat.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: isJoin
                          ? FitColors.volt.withOpacity(0.22)
                          : FitColors.heat.withOpacity(0.20))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(isJoin ? '●' : '✕',
                      style: TextStyle(
                          fontSize: 10,
                          color: isJoin ? FitColors.volt : FitColors.heat)),
                  const SizedBox(width: 4),
                  Text(status,
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: isJoin ? FitColors.volt : FitColors.heat)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LbRow extends StatelessWidget {
  final int rank;
  final String initials;
  final String name;
  final String attempts;
  final String pts;
  final Color rankColor;
  const _LbRow(
      {required this.rank,
      required this.initials,
      required this.name,
      required this.attempts,
      required this.pts,
      required this.rankColor});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
                color: rankColor, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text('$rank',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: rank == 1 ? const Color(0xFF121212) : const Color(0xFF121212))),
          ),
          const SizedBox(width: 8),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                color: rank == 1
                    ? FitColors.volt
                    : const Color(0xFF3A4047),
                shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(initials,
                style: const TextStyle(
                    fontSize: 11, fontWeight: FontWeight.w800)),
          ),
          const SizedBox(width: 8),
          Expanded(
              child: Text(name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 13))),
          Text('$attempts · ',
              style:
                  const TextStyle(fontSize: 11.5, color: FitColors.muted)),
          Text('$pts pts',
              style: const TextStyle(
                  fontSize: 12, color: FitColors.volt, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _LbSelfRow extends StatelessWidget {
  const _LbSelfRow();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: FitColors.volt.withOpacity(0.07),
          border: Border.all(color: FitColors.volt.withOpacity(0.18)),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(
                color: Color(0xFFC9A86A), shape: BoxShape.circle),
            alignment: Alignment.center,
            child: const Text('3',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF121212))),
          ),
          const SizedBox(width: 8),
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
                color: FitColors.volt, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: const Text('JM',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF121212))),
          ),
          const SizedBox(width: 8),
          const Expanded(
              child: Row(
            children: [
              Text('Jordan (you)',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 13)),
              SizedBox(width: 6),
              _YouBadge(),
            ],
          )),
          const Text('10 · ',
              style: TextStyle(fontSize: 11.5, color: FitColors.muted)),
          const Text('840 pts',
              style: TextStyle(
                  fontSize: 12, color: FitColors.volt, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _YouBadge extends StatelessWidget {
  const _YouBadge();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
          color: FitColors.volt, borderRadius: BorderRadius.circular(20)),
      child: const Text('YOU',
          style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              color: Color(0xFF121212))),
    );
  }
}

class _PrizeIcon extends StatelessWidget {
  const _PrizeIcon();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
          color: FitColors.volt.withOpacity(0.14),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: FitColors.volt.withOpacity(0.22))),
      child: const Icon(Icons.emoji_events, color: FitColors.volt, size: 22),
    );
  }
}

class _PrimaryAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _PrimaryAction(this.label, this.icon, this.onTap);
  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16, color: const Color(0xFF121212)),
      label: Text(label,
          style: const TextStyle(
              color: Color(0xFF121212),
              fontWeight: FontWeight.w900,
              fontSize: 12.5)),
      style: FilledButton.styleFrom(
          backgroundColor: FitColors.volt,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    );
  }
}

class _SecondaryAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _SecondaryAction(this.label, this.icon, this.onTap);
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16, color: FitColors.text),
      label: Text(label,
          style: const TextStyle(
              color: FitColors.text,
              fontWeight: FontWeight.w700,
              fontSize: 12.5)),
      style: OutlinedButton.styleFrom(
          backgroundColor: FitColors.surface,
          side: const BorderSide(color: FitColors.line),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    );
  }
}

// ---------- 3. STREAKS (Vedant) ----------

class StreaksScreen extends StatelessWidget {
  const StreaksScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: cardDec(),
          child: const Column(
            children: [
              Text('🔥',
                  style: TextStyle(fontSize: 40)),
              SizedBox(height: 8),
              Text('12 day streak',
                  style: TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 22)),
              Text('Best: 21 days · Rewards unlock at 15',
                  style: TextStyle(
                      fontSize: 12, color: FitColors.muted)),
              SizedBox(height: 12),
              GoalBar(0.8),
            ],
          ),
        ),
        const SectionHead('Attendance grid'),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: cardDec(),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6),
            itemCount: 28,
            itemBuilder: (_, i) => Container(
              decoration: BoxDecoration(
                  color: i % 5 == 4
                      ? FitColors.surface2
                      : FitColors.volt.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
        ),
        const SectionHead('Rewards → Wallet'),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: cardDec(),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('500 pts = merch drop',
                  style: TextStyle(fontSize: 13)),
              Text('Claim ›',
                  style: TextStyle(
                      color: FitColors.volt,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------- 4. TODAY GOAL ----------

class TodayGoalScreen extends StatefulWidget {
  const TodayGoalScreen({super.key});
  @override
  State<TodayGoalScreen> createState() => _TodayGoalScreenState();
}

class _TodayGoalScreenState extends State<TodayGoalScreen> {
  final done = {0, 1};
  final items = const [
    ('Barbell bench press', '4 × 8 · 72.5 kg'),
    ('Incline dumbbell press', '3 × 10 · 26 kg'),
    ('Cable fly', '3 × 12 · 18 kg'),
    ('Lateral raise', '3 × 15 · 8 kg'),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: cardDec(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${done.length}/${items.length} done',
                  style: const TextStyle(
                      fontSize: 12, color: FitColors.muted)),
              const SizedBox(height: 8),
              GoalBar(done.length / items.length),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ...List.generate(items.length, (i) {
          final d = done.contains(i);
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: cardDec(),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => setState(
                      () => d ? done.remove(i) : done.add(i)),
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: d ? FitColors.volt : null,
                        border: Border.all(
                            color: d
                                ? FitColors.volt
                                : FitColors.line,
                            width: 2)),
                    alignment: Alignment.center,
                    child: d
                        ? const Text('✓',
                            style: TextStyle(
                                color: Color(0xFF0F1113),
                                fontWeight: FontWeight.w800))
                        : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                    child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                      Text(items[i].$1,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              decoration: d
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: d
                                  ? FitColors.muted
                                  : FitColors.text)),
                      Text(items[i].$2,
                          style: const TextStyle(
                              fontSize: 12,
                              color: FitColors.muted)),
                    ])),
              ],
            ),
          );
        }),
      ],
    );
  }
}

// ---------- 5. PROGRESS (same pattern, renamed) ----------

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      children: const [
        _ProgCard('Weekly', '4/5 workouts', 0.8, 'On track 💪'),
        _ProgCard('Monthly', '12/20 September', 0.6, 'Push 2 more this week'),
        _ProgCard('Weight', '2.6 / 4 kg lost', 0.65, 'Steady progress'),
      ],
    );
  }
}

class _ProgCard extends StatelessWidget {
  final String t;
  final String v;
  final double pct;
  final String remark;
  const _ProgCard(this.t, this.v, this.pct, this.remark);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: cardDec(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(t,
                    style:
                        TextStyle(fontWeight: FontWeight.w700)),
                Text(v,
                    style: TextStyle(
                        fontSize: 12, color: FitColors.muted)),
              ]),
          SizedBox(height: 8),
          GoalBar(pct),
          SizedBox(height: 6),
          Text(remark,
              style:
                  TextStyle(fontSize: 11.5, color: FitColors.muted)),
        ],
      ),
    );
  }
}

// ---------- 6. WALLET ----------

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: cardDec(),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('TOTAL BALANCE',
                  style: TextStyle(
                      fontSize: 11,
                      color: FitColors.volt,
                      fontWeight: FontWeight.w700)),
              Text('2,140 pts',
                  style: TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 28)),
              Text('≈ ₹214 rewards · team design coming',
                  style: TextStyle(
                      fontSize: 12, color: FitColors.muted)),
            ],
          ),
        ),
        const SectionHead('Recent'),
        ...const [
          ('Sweat Challenge bonus', '+500 pts'),
          ('Weekly streak', '+120 pts'),
          ('Merch redeemed', '-800 pts'),
        ].map((e) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: cardDec(),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text(e.$1,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600)),
                  Text(e.$2,
                      style: TextStyle(
                          color: FitColors.volt,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            )),
      ],
    );
  }
}

// ---------- 7. PROFILE ----------

class ProfileScreen extends StatelessWidget {
  final VoidCallback onOpenLogin;
  const ProfileScreen({required this.onOpenLogin, super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      children: [
        Center(
          child: Column(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      FitColors.volt,
                      Color(0xFF4D7A13)
                    ])),
                alignment: Alignment.center,
                child: const Text('JM',
                    style: TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 24)),
              ),
              const SizedBox(height: 8),
              const Text('Jordan Miles',
                  style: TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 18)),
              const Text('Member since Apr 2024',
                  style: TextStyle(
                      fontSize: 12, color: FitColors.muted)),
            ],
          ),
        ),
        const SectionHead('Membership'),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: cardDec(),
          child: const Column(
            children: [
              _MRow('Status', 'Active'),
              _MRow('Renews', 'Oct 14, 2026'),
              _MRow('Home club', 'Downtown'),
            ],
          ),
        ),
        SectionHead('Check-in setup',
            action: 'Open', onAction: onOpenLogin),
        const SectionHead('Account'),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: cardDec(),
          child: const Column(
            children: [
              _MRow('Training goals', '›'),
              _MRow('Payment & billing', '›'),
              _MRow('Connected devices', '›'),
              _MRow('Notifications', '›'),
              _MRow('Support', '›'),
            ],
          ),
        ),
      ],
    );
  }
}

class _MRow extends StatelessWidget {
  final String k;
  final String v;
  const _MRow(this.k, this.v);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(k,
              style: const TextStyle(
                  fontSize: 13, color: FitColors.muted)),
          Text(v,
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// ---------- 8. LOGIN / BARCODE SETUP (Adarsh) ----------

class LoginSetupScreen extends StatefulWidget {
  const LoginSetupScreen({super.key});
  @override
  State<LoginSetupScreen> createState() => _LoginSetupScreenState();
}

class _LoginSetupScreenState extends State<LoginSetupScreen> {
  String category = 'Strength';
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: cardDec(),
          alignment: Alignment.center,
          child: const Column(
            children: [
              Icon(Icons.qr_code_2, size: 90, color: Colors.white),
              SizedBox(height: 8),
              Text('Scan at club entry',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              Text('Refreshes every 45s',
                  style: TextStyle(
                      fontSize: 12, color: FitColors.muted)),
            ],
          ),
        ),
        const SectionHead('Or use'),
        Row(
          children: [
            Expanded(
                child: _LoginOpt(Icons.face, 'Face', () {})),
            const SizedBox(width: 10),
            Expanded(
                child: _LoginOpt(
                    Icons.fingerprint, 'Biometric', () {})),
          ],
        ),
        const SectionHead('Pick category (shows matching challenges)'),
        Wrap(
          spacing: 8,
          children: ['Strength', 'Cardio', 'Yoga', 'Boxing']
              .map((c) => ChoiceChip(
                    label: Text(c),
                    selected: category == c,
                    selectedColor: FitColors.volt,
                    backgroundColor: FitColors.surface2,
                    labelStyle: TextStyle(
                        color: category == c
                            ? const Color(0xFF0F1113)
                            : FitColors.text,
                        fontSize: 12),
                    onSelected: (_) =>
                        setState(() => category = c),
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () => Navigator.of(context).maybePop(),
            style: FilledButton.styleFrom(
                backgroundColor: FitColors.volt,
                foregroundColor: const Color(0xFF0F1113),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.all(14)),
            child: const Text('Save & continue',
                style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        ),
      ],
    );
  }
}

class _LoginOpt extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _LoginOpt(this.icon, this.label, this.onTap);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: cardDec(),
        child: Column(
          children: [
            Icon(icon, color: FitColors.volt),
            const SizedBox(height: 6),
            Text(label,
                style: const TextStyle(
                    fontSize: 12.5, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
