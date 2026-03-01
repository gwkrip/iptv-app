import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/channel.dart';
import '../data/playlist.dart';

class ChannelProvider extends ChangeNotifier {
  List<Channel> _allChannels = [];
  String _selectedGroup = 'SEMUA';
  String _searchQuery = '';
  Channel? _currentChannel;
  bool _isLoading = false;

  List<Channel> get allChannels => _allChannels;
  String get selectedGroup => _selectedGroup;
  Channel? get currentChannel => _currentChannel;
  bool get isLoading => _isLoading;

  List<String> get groups => PlaylistData.getGroups(_allChannels);

  List<Channel> get filteredChannels {
    List<Channel> channels = _allChannels;

    if (_selectedGroup != 'SEMUA') {
      channels = channels.where((c) => c.group == _selectedGroup).toList();
    }

    if (_searchQuery.isNotEmpty) {
      channels = channels
          .where((c) =>
              c.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return channels;
  }

  List<Channel> get favoriteChannels =>
      _allChannels.where((c) => c.isFavorite).toList();

  void initialize() async {
    _isLoading = true;
    notifyListeners();

    _allChannels = PlaylistData.getChannels();
    await _loadFavorites();

    _isLoading = false;
    notifyListeners();
  }

  void setGroup(String group) {
    _selectedGroup = group;
    notifyListeners();
  }

  void setSearch(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setCurrentChannel(Channel channel) {
    _currentChannel = channel;
    notifyListeners();
  }

  void toggleFavorite(Channel channel) async {
    final index = _allChannels.indexWhere((c) => c.url == channel.url);
    if (index != -1) {
      _allChannels[index] =
          _allChannels[index].copyWith(isFavorite: !_allChannels[index].isFavorite);
      notifyListeners();
      await _saveFavorites();
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favUrls = _allChannels
        .where((c) => c.isFavorite)
        .map((c) => c.url)
        .toList();
    await prefs.setStringList('favorites', favUrls);
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favUrls = prefs.getStringList('favorites') ?? [];
    for (int i = 0; i < _allChannels.length; i++) {
      if (favUrls.contains(_allChannels[i].url)) {
        _allChannels[i] = _allChannels[i].copyWith(isFavorite: true);
      }
    }
  }
}
