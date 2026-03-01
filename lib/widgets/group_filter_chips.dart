import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/channel_provider.dart';
import '../utils/app_theme.dart';

class GroupFilterChips extends StatelessWidget {
  const GroupFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChannelProvider>(
      builder: (context, provider, _) {
        final groups = provider.groups;
        return SizedBox(
          height: 44,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              final isSelected = provider.selectedGroup == group;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => provider.setGroup(group),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [AppTheme.primary, Color(0xFF8B7FF0)],
                            )
                          : null,
                      color: isSelected ? null : AppTheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Text(
                      group,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : AppTheme.onSurfaceVariant,
                        fontSize: 13,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
