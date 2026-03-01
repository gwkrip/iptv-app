import '../models/channel.dart';

class PlaylistData {
  static List<Channel> getChannels() {
    return [
      // ========== INDONESIA ==========
      Channel(
        name: 'TVRI SPORT',
        url: 'https://ott-balancer.tvri.go.id/live/eds/SportHD/hls/SportHD-avc1_900000=10002-mp4a_96000=20002.m3u8',
        logoUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZ1VJ8fS-Oh63MRSY0_9NSxm457-gypcqjOA&s',
        group: 'INDONESIA',
      ),
      Channel(
        name: 'TVRI Nasional',
        url: 'https://ott-balancer.tvri.go.id/live/eds/NasionalHD/hls/NasionalHD-avc1_900000=10002-mp4a_96000=20002.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/58/TVRI_logo_2019.svg/240px-TVRI_logo_2019.svg.png',
        group: 'INDONESIA',
      ),
      Channel(
        name: 'TVRI World',
        url: 'https://ott-balancer.tvri.go.id/live/eds/WorldHD/hls/WorldHD-avc1_900000=10002-mp4a_96000=20002.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/58/TVRI_logo_2019.svg/240px-TVRI_logo_2019.svg.png',
        group: 'INDONESIA',
      ),
      Channel(
        name: 'Metro TV',
        url: 'https://s.metrotvnews.com/videos/metrotv.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/Metro_TV_logo.svg/320px-Metro_TV_logo.svg.png',
        group: 'INDONESIA',
      ),
      Channel(
        name: 'CNN Indonesia',
        url: 'https://cnnindonesia-cnnindonesialive.akamaized.net/hls/live/1074897/cnnindonesialive/master_2.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/CNN_Indonesia.svg/320px-CNN_Indonesia.svg.png',
        group: 'INDONESIA',
      ),
      Channel(
        name: 'KOMPAS TV',
        url: 'https://live.kompas.tv/live/kompastv.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Logo_Kompas_TV.svg/320px-Logo_Kompas_TV.svg.png',
        group: 'INDONESIA',
      ),
      Channel(
        name: 'iNews TV',
        url: 'https://live.inews.id/hls/live.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/INEWS_logo.svg/320px-INEWS_logo.svg.png',
        group: 'INDONESIA',
      ),
      Channel(
        name: 'SCTV',
        url: 'https://live.sctv.co.id/live/smarthls/sctv/playlist.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/SCTV_Indonesia_logo.svg/320px-SCTV_Indonesia_logo.svg.png',
        group: 'INDONESIA',
      ),
      Channel(
        name: 'RCTI',
        url: 'https://stream-sth.rctiplus.com/a/100001/rcti/master_240.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/Rcti_logo_2020.svg/320px-Rcti_logo_2020.svg.png',
        group: 'INDONESIA',
      ),
      Channel(
        name: 'GTV',
        url: 'https://stream-sth.rctiplus.com/a/100003/gtv/master_240.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/GTV_Indonesia_logo.svg/320px-GTV_Indonesia_logo.svg.png',
        group: 'INDONESIA',
      ),
      Channel(
        name: 'MNC TV',
        url: 'https://stream-sth.rctiplus.com/a/100004/mnctv/master_240.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/MNCTV_logo.svg/320px-MNCTV_logo.svg.png',
        group: 'INDONESIA',
      ),
      Channel(
        name: 'Trans TV',
        url: 'https://live.transtv.co.id/live/transtv/index.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Trans_TV_logo.svg/320px-Trans_TV_logo.svg.png',
        group: 'INDONESIA',
      ),
      Channel(
        name: 'Trans7',
        url: 'https://live.transtv.co.id/live/trans7/index.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ef/Trans7_logo.svg/320px-Trans7_logo.svg.png',
        group: 'INDONESIA',
      ),
      Channel(
        name: 'TV One',
        url: 'https://live.tvone.co.id/hls/tvone/index.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Tvone_logo.svg/320px-Tvone_logo.svg.png',
        group: 'INDONESIA',
      ),
      Channel(
        name: 'Indosiar',
        url: 'https://live.indosiar.com/live/smarthls/indosiar/playlist.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Indosiar.svg/320px-Indosiar.svg.png',
        group: 'INDONESIA',
      ),
      Channel(
        name: 'ANTV',
        url: 'https://live.antvklik.com/live/antv/master.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/ANTV_logo.svg/320px-ANTV_logo.svg.png',
        group: 'INDONESIA',
      ),
      Channel(
        name: 'RTV',
        url: 'https://live.rtv.co.id/hls/live.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/RTV_Indonesia_logo.svg/320px-RTV_Indonesia_logo.svg.png',
        group: 'INDONESIA',
      ),

      // ========== INTERNASIONAL ==========
      Channel(
        name: 'CNN International',
        url: 'https://cnn-cnninternational-1-us.samsung.wurl.com/manifest/playlist.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/CNN.svg/320px-CNN.svg.png',
        group: 'INTERNASIONAL',
      ),
      Channel(
        name: 'BBC World News',
        url: 'https://vs-hls-push-ww-live.akamaized.net/x=4/i=urn:bbc:pips:service:bbc_news_channel_hd/pc_hd_abr_v2.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/BBC_World_News_2022_%28Boxed%29.svg/320px-BBC_World_News_2022_%28Boxed%29.svg.png',
        group: 'INTERNASIONAL',
      ),
      Channel(
        name: 'Al Jazeera English',
        url: 'https://live-hls-web-aje.getaj.net/AJE/index.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Al_Jazeera_English_Logo.svg/320px-Al_Jazeera_English_Logo.svg.png',
        group: 'INTERNASIONAL',
      ),
      Channel(
        name: 'DW English',
        url: 'https://dwamdstream102.akamaized.net/hls/live/2015525/dwstream102/index.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/Deutsche_Welle_symbol_2012.svg/320px-Deutsche_Welle_symbol_2012.svg.png',
        group: 'INTERNASIONAL',
      ),
      Channel(
        name: 'France 24 English',
        url: 'https://stream.france24.com/hls/live/2037226/F24_EN_HI_HLS/master.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/France_24_logo.svg/320px-France_24_logo.svg.png',
        group: 'INTERNASIONAL',
      ),
      Channel(
        name: 'NHK World',
        url: 'https://nhkwlive-ojp.akamaized.net/hls/live/2003459/nhkwlive-ojp-en/index_4M.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/NHK_logo.svg/320px-NHK_logo.svg.png',
        group: 'INTERNASIONAL',
      ),
      Channel(
        name: 'RT English',
        url: 'https://rt-glb.rttv.com/live/rten/playlist.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/RT_logo.svg/320px-RT_logo.svg.png',
        group: 'INTERNASIONAL',
      ),
      Channel(
        name: 'Euronews English',
        url: 'https://euronews-euronewslive.akamaized.net/hls/live/573891/euronewslive/euronewsen/master_720.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Euronews_logo_2022.svg/320px-Euronews_logo_2022.svg.png',
        group: 'INTERNASIONAL',
      ),

      // ========== OLAHRAGA ==========
      Channel(
        name: 'beIN Sports 1',
        url: 'https://bein1-live.akamaized.net/hls/live/bein1/index.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Bein_sport_1_logo.svg/320px-Bein_sport_1_logo.svg.png',
        group: 'OLAHRAGA',
      ),
      Channel(
        name: 'TVRI Sport HD',
        url: 'https://ott-balancer.tvri.go.id/live/eds/SportHD/hls/SportHD-avc1_900000=10002-mp4a_96000=20002.m3u8',
        logoUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZ1VJ8fS-Oh63MRSY0_9NSxm457-gypcqjOA&s',
        group: 'OLAHRAGA',
      ),

      // ========== ANAK-ANAK ==========
      Channel(
        name: 'Boomerang',
        url: 'https://live.boomerangtv.co.id/hls/live.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8b/Boomerang_2015_logo.svg/320px-Boomerang_2015_logo.svg.png',
        group: 'ANAK-ANAK',
      ),
      Channel(
        name: 'Nickelodeon',
        url: 'https://live.nick.tv/hls/live.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/Nickelodeon_2009_logo.svg/320px-Nickelodeon_2009_logo.svg.png',
        group: 'ANAK-ANAK',
      ),

      // ========== RELIGI ==========
      Channel(
        name: 'TV9 Nusantara',
        url: 'https://live.tv9.co.id/hls/tv9.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/TV9_Nusantara_logo.svg/320px-TV9_Nusantara_logo.svg.png',
        group: 'RELIGI',
      ),
      Channel(
        name: 'Rodja TV',
        url: 'https://cdn.rodja.tv/live/rodja/index.m3u8',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a1/Rodja_TV_Logo.png/320px-Rodja_TV_Logo.png',
        group: 'RELIGI',
      ),
    ];
  }

  static List<String> getGroups(List<Channel> channels) {
    final groups = <String>{};
    for (final ch in channels) {
      groups.add(ch.group);
    }
    return ['SEMUA', ...groups.toList()];
  }
}
