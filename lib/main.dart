import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'package:rive_example/artboard_nested_inputs.dart';
import 'package:rive_example/copybilai.dart';
import 'package:rive_example/custom_asset_loading.dart';
import 'package:rive_example/custom_cached_asset_loading.dart';
import 'package:rive_example/carousel.dart';
import 'package:rive_example/custom_controller.dart';
import 'package:rive_example/event_open_url_button.dart';
import 'package:rive_example/event_sounds.dart';
import 'package:rive_example/event_star_rating.dart';
import 'package:rive_example/example_state_machine.dart';
import 'package:rive_example/liquid_download.dart';
import 'package:rive_example/little_machine.dart';
import 'package:rive_example/play_one_shot_animation.dart';
import 'package:rive_example/play_pause_animation.dart';
import 'package:rive_example/rive_audio.dart';
import 'package:rive_example/rive_audio_out_of_band.dart';
import 'package:rive_example/simple_animation.dart';
import 'package:rive_example/simple_animation_network.dart';
import 'package:rive_example/simple_machine_listener.dart';
import 'package:rive_example/simple_state_machine.dart';
import 'package:rive_example/skinning_demo.dart';
import 'package:rive_example/state_machine_skills.dart';
import 'package:rive_example/basic_text.dart';

void main() {
  /// Initialize Rive's text, audio, and layout engines.
  /// This will automatically be called the first time a RiveFile is loaded if
  /// it has not been initialized. And does not need to be called.
  ///
  /// However, calling it early here makes the first
  /// visible Rive graphic load faster.
  unawaited(RiveFile.initialize());
  runApp(
    MaterialApp(
      title: 'Rive Example',
      home: const RiveExampleApp(),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: _backgroundColor,
        appBarTheme: const AppBarTheme(backgroundColor: _appBarColor),
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: _primaryColor),
      ),
      themeMode: ThemeMode.dark,
    ),
  );
}

/// An example application demoing Rive.
class RiveExampleApp extends StatefulWidget {
  const RiveExampleApp({Key? key}) : super(key: key);

  @override
  State<RiveExampleApp> createState() => _RiveExampleAppState();
}

class _RiveExampleAppState extends State<RiveExampleApp> {
  // Examples
  final _pages = [
    const _Page('Asset Loading', CustomAssetLoading()),
    const _Page('CopyBilai', CopyBilai()),
    const _Page('Simple Animation - Asset', SimpleAssetAnimation()),
    const _Page('Simple Animation - Network', SimpleNetworkAnimation()),
    const _Page('Play/Pause Animation', PlayPauseAnimation()),
    const _Page('Play One-Shot Animation', PlayOneShotAnimation()),
    const _Page('Button State Machine', ExampleStateMachine()),
    const _Page('Skills Machine', StateMachineSkills()),
    const _Page('Little Machine', LittleMachine()),
    const _Page('Nested Inputs', ArtboardNestedInputs()),
    const _Page('Liquid Download', LiquidDownload()),
    const _Page('Custom Controller - Speed', SpeedyAnimation()),
    const _Page('Simple State Machine', SimpleStateMachine()),
    const _Page('State Machine with Listener', StateMachineListener()),
    const _Page('Skinning Demo', SkinningDemo()),
    const _Page('Animation Carousel', AnimationCarousel()),
    const _Page('Basic Text', BasicText()),
    const _Page('Cached Asset Loading', CustomCachedAssetLoading()),
    const _Page('Event Open URL Button', EventOpenUrlButton()),
    const _Page('Event Sounds', EventSounds()),
    const _Page('Event Star Rating', EventStarRating()),
    const _Page('Rive Audio', RiveAudioExample()),
    const _Page('Rive Audio [Out-of-Band]', RiveAudioOutOfBandExample()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rive Examples')),
      body: Center(
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) => _NavButton(page: _pages[index]),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: _pages.length,
        ),
      ),
    );
  }
}

/// Class used to organize demo pages.
class _Page {
  final String name;
  final Widget page;

  const _Page(this.name, this.page);
}

/// Button to navigate to demo pages.
class _NavButton extends StatelessWidget {
  const _NavButton({required this.page});

  final _Page page;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: SizedBox(
          width: 250,
          child: Center(
            child: Text(
              page.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => page.page,
            ),
          );
        },
      ),
    );
  }
}

const _appBarColor = Color(0xFF323232);
const _backgroundColor = Color(0xFF1D1D1D);
const _primaryColor = Color(0xFF57A5E0);
