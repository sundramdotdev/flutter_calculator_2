import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../calculator/presentation/providers/navigation_provider.dart';

class ToolsDashboard extends ConsumerWidget {
  const ToolsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 2 columns on phones, 3 on tablets/desktops
        int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

        return GridView.count(
          crossAxisCount: crossAxisCount,
          padding: const EdgeInsets.all(16.0),
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 1.1,
          children: [
            _ToolCard(
              icon: Icons.science_outlined,
              title: "Scientific",
              description: "Advanced functions",
              onTap: () =>
                  ref.read(activeToolProvider.notifier).setTool("Scientific"),
            ),
            _ToolCard(
              icon: Icons.account_balance_outlined,
              title: "GST Calculator",
              description: "Tax calculations",
              onTap: () => ref.read(activeToolProvider.notifier).setTool("GST"),
            ),
            _ToolCard(
              icon: Icons.currency_rupee_outlined,
              title: "EMI Calculator",
              description: "Loan planning",
              onTap: () => ref.read(activeToolProvider.notifier).setTool("EMI"),
            ),
            _ToolCard(
              icon: Icons.trending_up,
              title: "SIP Calculator",
              description: "Investment returns",
              onTap: () => ref.read(activeToolProvider.notifier).setTool("SIP"),
            ),
            _ToolCard(
              icon: Icons.cake_outlined,
              title: "Age Calculator",
              description: "Date duration",
              onTap: () => ref.read(activeToolProvider.notifier).setTool("Age"),
            ),
            _ToolCard(
              icon: Icons.straighten_outlined,
              title: "Unit Converter",
              description: "Length, mass & more",
              onTap: () =>
                  ref.read(activeToolProvider.notifier).setTool("Units"),
            ),
          ],
        );
      },
    );
  }
}

class _ToolCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _ToolCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  State<_ToolCard> createState() => _ToolCardState();
}

class _ToolCardState extends State<_ToolCard>
    with SingleTickerProviderStateMixin {
  bool _isHovering = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) => _controller.forward();
  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) =>
              Transform.scale(scale: _scaleAnimation.value, child: child),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: theme.cardTheme.color,
              borderRadius: BorderRadius.circular(24),
              boxShadow: _isHovering
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ]
                  : [],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(widget.icon, color: theme.colorScheme.primary, size: 32),
                const Spacer(),
                Text(
                  widget.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.description,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
