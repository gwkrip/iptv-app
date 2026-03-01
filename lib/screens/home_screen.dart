import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../data/channel_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/channel_card.dart';
import '../widgets/group_filter_chips.dart';
import 'player_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          _ChannelListTab(),
          _FavoritesTab(),
          _SearchTab(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv_rounded),
            label: 'Channel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Cari',
          ),
        ],
      ),
    );
  }
}

// =========== Channel List Tab ===========
class _ChannelListTab extends StatelessWidget {
  const _ChannelListTab();

  @override
  Widget build(BuildContext context) {
    return Consumer<ChannelProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppTheme.primary),
          );
        }

        final channels = provider.filteredChannels;

        return CustomScrollView(
          slivers: [
            _buildAppBar(context),
            SliverToBoxAdapter(
              child: _buildFeaturedBanner(context, provider),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  children: [
                    const Text(
                      'Semua Channel',
                      style: TextStyle(
                        color: AppTheme.onSurface,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${channels.length}',
                        style: const TextStyle(
                          color: AppTheme.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: GroupFilterChips()),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            if (channels.isEmpty)
              const SliverFillRemaining(
                child: Center(
                  child: Text(
                    'Tidak ada channel ditemukan',
                    style: TextStyle(color: AppTheme.onSurfaceVariant),
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final ch = channels[index];
                    return ChannelCard(
                      channel: ch,
                      isSelected: provider.currentChannel?.url == ch.url,
                      onTap: () {
                        provider.setCurrentChannel(ch);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PlayerScreen(channel: ch),
                          ),
                        );
                      },
                    );
                  },
                  childCount: channels.length,
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
          ],
        );
      },
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: AppTheme.background,
      title: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.primary, Color(0xFF8B7FF0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.live_tv_rounded,
                color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MyIPTV',
                style: TextStyle(
                  color: AppTheme.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              Text(
                'Live Streaming TV',
                style: TextStyle(
                  color: AppTheme.onSurfaceVariant,
                  fontSize: 11,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.live.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.live.withOpacity(0.3)),
          ),
          child: const Row(
            children: [
              Icon(Icons.circle, color: AppTheme.live, size: 8),
              SizedBox(width: 4),
              Text(
                'LIVE',
                style: TextStyle(
                  color: AppTheme.live,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedBanner(
      BuildContext context, ChannelProvider provider) {
    if (provider.allChannels.isEmpty) return const SizedBox();
    final featured = provider.allChannels.take(5).toList();

    return Container(
      height: 160,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: featured.length,
        itemBuilder: (context, index) {
          final ch = featured[index];
          return GestureDetector(
            onTap: () {
              provider.setCurrentChannel(ch);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PlayerScreen(channel: ch),
                ),
              );
            },
            child: Container(
              width: 200,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.primary.withOpacity(0.3),
                    AppTheme.surfaceVariant,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppTheme.primary.withOpacity(0.2),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: ch.logoUrl,
                      height: 70,
                      fit: BoxFit.contain,
                      errorWidget: (_, __, ___) => const Icon(
                        Icons.tv_rounded,
                        color: AppTheme.primary,
                        size: 48,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.6),
                          ],
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              ch.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(Icons.play_circle_filled_rounded,
                              color: AppTheme.primary, size: 22),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.live,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'LIVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// =========== Favorites Tab ===========
class _FavoritesTab extends StatelessWidget {
  const _FavoritesTab();

  @override
  Widget build(BuildContext context) {
    return Consumer<ChannelProvider>(
      builder: (context, provider, _) {
        final favs = provider.favoriteChannels;
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text(
                'Favorit Saya',
                style: TextStyle(
                  color: AppTheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: AppTheme.background,
              floating: true,
            ),
            if (favs.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border_rounded,
                        color: AppTheme.onSurfaceVariant,
                        size: 64,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Belum ada favorit',
                        style: TextStyle(
                          color: AppTheme.onSurfaceVariant,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Tekan ♡ pada channel untuk menambahkan',
                        style: TextStyle(
                          color: AppTheme.onSurfaceVariant,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final ch = favs[index];
                    return ChannelCard(
                      channel: ch,
                      isSelected: provider.currentChannel?.url == ch.url,
                      onTap: () {
                        provider.setCurrentChannel(ch);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PlayerScreen(channel: ch),
                          ),
                        );
                      },
                    );
                  },
                  childCount: favs.length,
                ),
              ),
          ],
        );
      },
    );
  }
}

// =========== Search Tab ===========
class _SearchTab extends StatefulWidget {
  const _SearchTab();

  @override
  State<_SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<_SearchTab> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChannelProvider>(
      builder: (context, provider, _) {
        final results = provider.filteredChannels;
        return SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: TextField(
                  controller: _ctrl,
                  autofocus: false,
                  onChanged: provider.setSearch,
                  style: const TextStyle(color: AppTheme.onSurface),
                  decoration: const InputDecoration(
                    hintText: 'Cari channel...',
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                ),
              ),
              if (_ctrl.text.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search_rounded,
                          color: AppTheme.onSurfaceVariant,
                          size: 64,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Ketik nama channel',
                          style: TextStyle(
                            color: AppTheme.onSurfaceVariant,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else if (results.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      'Channel "${_ctrl.text}" tidak ditemukan',
                      style: const TextStyle(color: AppTheme.onSurfaceVariant),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final ch = results[index];
                      return ChannelCard(
                        channel: ch,
                        onTap: () {
                          provider.setCurrentChannel(ch);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PlayerScreen(channel: ch),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
