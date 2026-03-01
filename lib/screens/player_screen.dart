import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/channel.dart';
import '../data/channel_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/channel_card.dart';

class PlayerScreen extends StatefulWidget {
  final Channel channel;

  const PlayerScreen({super.key, required this.channel});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';
  late Channel _currentChannel;

  @override
  void initState() {
    super.initState();
    _currentChannel = widget.channel;
    _initPlayer(_currentChannel.url);
  }

  Future<void> _initPlayer(String url) async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      await _disposePlayer();

      _videoController = VideoPlayerController.networkUrl(Uri.parse(url));
      await _videoController!.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControlsOnInitialize: true,
        placeholder: Container(color: Colors.black),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline,
                    color: AppTheme.live, size: 48),
                const SizedBox(height: 12),
                Text(
                  'Stream tidak tersedia',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        },
      );

      if (mounted) setState(() => _isLoading = false);
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
          _errorMessage = 'Stream tidak dapat diputar';
        });
      }
    }
  }

  Future<void> _disposePlayer() async {
    _chewieController?.dispose();
    _chewieController = null;
    await _videoController?.dispose();
    _videoController = null;
  }

  void _switchChannel(Channel channel) {
    setState(() {
      _currentChannel = channel;
    });
    context.read<ChannelProvider>().setCurrentChannel(channel);
    _initPlayer(channel.url);
  }

  @override
  void dispose() {
    _disposePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Column(
        children: [
          // Player Section
          _buildPlayer(),
          // Channel Info Bar
          _buildChannelInfo(),
          // Channel List
          Expanded(child: _buildChannelList()),
        ],
      ),
    );
  }

  Widget _buildPlayer() {
    return Container(
      color: Colors.black,
      child: SafeArea(
        bottom: false,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (_isLoading) _buildLoadingState(),
              if (_hasError) _buildErrorState(),
              if (!_isLoading && !_hasError && _chewieController != null)
                Chewie(controller: _chewieController!),
              // Back button overlay
              Positioned(
                top: 8,
                left: 8,
                child: SafeArea(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_rounded,
                        color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: _currentChannel.logoUrl,
              fit: BoxFit.contain,
              errorWidget: (_, __, ___) => const Icon(
                Icons.tv_rounded,
                color: AppTheme.primary,
                size: 32,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(
            color: AppTheme.primary,
            strokeWidth: 2,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Memuat stream...',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.signal_wifi_off_rounded,
            color: AppTheme.live, size: 48),
        const SizedBox(height: 12),
        Text(
          _errorMessage,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () => _initPlayer(_currentChannel.url),
          icon: const Icon(Icons.refresh_rounded),
          label: const Text('Coba Lagi'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primary,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildChannelInfo() {
    return Container(
      color: AppTheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              imageUrl: _currentChannel.logoUrl,
              fit: BoxFit.contain,
              errorWidget: (_, __, ___) => const Icon(
                Icons.tv_rounded,
                color: AppTheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _currentChannel.name,
                  style: const TextStyle(
                    color: AppTheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _currentChannel.group,
                  style: const TextStyle(
                    color: AppTheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppTheme.live,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'LIVE',
                style: TextStyle(
                  color: AppTheme.live,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Consumer<ChannelProvider>(
            builder: (context, provider, _) => IconButton(
              icon: Icon(
                _currentChannel.isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: _currentChannel.isFavorite
                    ? AppTheme.accent
                    : AppTheme.onSurfaceVariant,
              ),
              onPressed: () {
                provider.toggleFavorite(_currentChannel);
                setState(() {
                  _currentChannel = _currentChannel.copyWith(
                    isFavorite: !_currentChannel.isFavorite,
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChannelList() {
    return Consumer<ChannelProvider>(
      builder: (context, provider, _) {
        final channels = provider.filteredChannels;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Text(
                'Channel Lainnya',
                style: TextStyle(
                  color: AppTheme.onSurface,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: channels.length,
                itemBuilder: (context, index) {
                  final ch = channels[index];
                  return ChannelCard(
                    channel: ch,
                    isSelected: ch.url == _currentChannel.url,
                    onTap: () => _switchChannel(ch),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
