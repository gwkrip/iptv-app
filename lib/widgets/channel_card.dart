import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../models/channel.dart';
import '../data/channel_provider.dart';
import '../utils/app_theme.dart';

class ChannelCard extends StatelessWidget {
  final Channel channel;
  final VoidCallback onTap;
  final bool isSelected;

  const ChannelCard({
    super.key,
    required this.channel,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary.withOpacity(0.15) : AppTheme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.primary : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Logo
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppTheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  imageUrl: channel.logoUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: AppTheme.surfaceVariant,
                    highlightColor: AppTheme.surface,
                    child: Container(color: AppTheme.surfaceVariant),
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Text(
                      channel.name.isNotEmpty ? channel.name[0] : '?',
                      style: const TextStyle(
                        color: AppTheme.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      channel.name,
                      style: const TextStyle(
                        color: AppTheme.onSurface,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            channel.group,
                            style: const TextStyle(
                              color: AppTheme.onSurfaceVariant,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: AppTheme.live,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'LIVE',
                          style: TextStyle(
                            color: AppTheme.live,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Favorite button
              Consumer<ChannelProvider>(
                builder: (context, provider, _) {
                  return IconButton(
                    icon: Icon(
                      channel.isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: channel.isFavorite
                          ? AppTheme.accent
                          : AppTheme.onSurfaceVariant,
                      size: 22,
                    ),
                    onPressed: () => provider.toggleFavorite(channel),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
