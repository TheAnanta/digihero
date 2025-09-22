import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:hive/hive.dart';

class AudioService extends ChangeNotifier {
  late Box _settingsBox;
  late AudioPlayer _musicPlayer;
  late AudioPlayer _sfxPlayer;
  
  bool _musicEnabled = true;
  bool _sfxEnabled = true;
  double _musicVolume = 0.7;
  double _sfxVolume = 0.8;
  
  AudioService() {
    _initializeAudio();
  }
  
  // Getters
  bool get musicEnabled => _musicEnabled;
  bool get sfxEnabled => _sfxEnabled;
  double get musicVolume => _musicVolume;
  double get sfxVolume => _sfxVolume;
  
  void _initializeAudio() async {
    _settingsBox = Hive.box('settings');
    _musicPlayer = AudioPlayer();
    _sfxPlayer = AudioPlayer();
    
    _loadAudioSettings();
  }
  
  void _loadAudioSettings() {
    _musicEnabled = _settingsBox.get('musicEnabled', defaultValue: true);
    _sfxEnabled = _settingsBox.get('sfxEnabled', defaultValue: true);
    _musicVolume = _settingsBox.get('musicVolume', defaultValue: 0.7);
    _sfxVolume = _settingsBox.get('sfxVolume', defaultValue: 0.8);
    
    notifyListeners();
  }
  
  void _saveAudioSettings() {
    _settingsBox.put('musicEnabled', _musicEnabled);
    _settingsBox.put('sfxEnabled', _sfxEnabled);
    _settingsBox.put('musicVolume', _musicVolume);
    _settingsBox.put('sfxVolume', _sfxVolume);
  }
  
  // Music Controls
  Future<void> playBackgroundMusic(String fileName) async {
    if (_musicEnabled) {
      try {
        await _musicPlayer.setVolume(_musicVolume);
        await _musicPlayer.setReleaseMode(ReleaseMode.loop);
        await _musicPlayer.play(AssetSource('audio/music/$fileName'));
      } catch (e) {
        if (kDebugMode) {
          print('Error playing background music: $e');
        }
      }
    }
  }
  
  Future<void> stopBackgroundMusic() async {
    await _musicPlayer.stop();
  }
  
  Future<void> pauseBackgroundMusic() async {
    await _musicPlayer.pause();
  }
  
  Future<void> resumeBackgroundMusic() async {
    await _musicPlayer.resume();
  }
  
  // Sound Effects
  Future<void> playSoundEffect(String fileName) async {
    if (_sfxEnabled) {
      try {
        await _sfxPlayer.setVolume(_sfxVolume);
        await _sfxPlayer.play(AssetSource('audio/sfx/$fileName'));
      } catch (e) {
        if (kDebugMode) {
          print('Error playing sound effect: $e');
        }
      }
    }
  }
  
  // Predefined sound effects
  Future<void> playButtonClick() async {
    await playSoundEffect('button_click.mp3');
  }
  
  Future<void> playLevelComplete() async {
    await playSoundEffect('level_complete.mp3');
  }
  
  Future<void> playGameOver() async {
    await playSoundEffect('game_over.mp3');
  }
  
  Future<void> playCollectCoin() async {
    await playSoundEffect('collect_coin.mp3');
  }
  
  Future<void> playCorrectAnswer() async {
    await playSoundEffect('correct_answer.mp3');
  }
  
  Future<void> playWrongAnswer() async {
    await playSoundEffect('wrong_answer.mp3');
  }
  
  Future<void> playPowerUp() async {
    await playSoundEffect('power_up.mp3');
  }
  
  // Settings
  void toggleMusic() {
    _musicEnabled = !_musicEnabled;
    if (!_musicEnabled) {
      stopBackgroundMusic();
    }
    _saveAudioSettings();
    notifyListeners();
  }
  
  void toggleSfx() {
    _sfxEnabled = !_sfxEnabled;
    _saveAudioSettings();
    notifyListeners();
  }
  
  void setMusicVolume(double volume) {
    _musicVolume = volume.clamp(0.0, 1.0);
    _musicPlayer.setVolume(_musicVolume);
    _saveAudioSettings();
    notifyListeners();
  }
  
  void setSfxVolume(double volume) {
    _sfxVolume = volume.clamp(0.0, 1.0);
    _saveAudioSettings();
    notifyListeners();
  }
  
  void dispose() {
    _musicPlayer.dispose();
    _sfxPlayer.dispose();
    super.dispose();
  }
}