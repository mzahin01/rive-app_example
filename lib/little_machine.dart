import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// An example showing how to drive a StateMachine via a trigger input.
class LittleMachine extends StatefulWidget {
  const LittleMachine({Key? key}) : super(key: key);

  @override
  State<LittleMachine> createState() => _LittleMachineState();
}

class _LittleMachineState extends State<LittleMachine> {
  /// Message that displays when state has changed
  String stateChangeMessage = '';

  Artboard? _riveArtboard;
  SMITrigger? _trigger;

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
  }

  Future<void> _loadRiveFile() async {
    final file = await RiveFile.asset('assets/little_machine.riv');

    // The artboard is the root of the animation and gets drawn in the
    // Rive widget.
    final artboard = file.mainArtboard.instance();
    var controller = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
      onStateChange: _onStateChange,
    );
    if (controller != null) {
      artboard.addController(controller);
      _trigger = controller.getTriggerInput('Trigger 1');
    }
    setState(() => _riveArtboard = artboard);
  }

  /// Do something when the state machine changes state
  void _onStateChange(String stateMachineName, String stateName) => setState(
        () => stateChangeMessage =
            'State Changed in $stateMachineName to $stateName',
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Little Machine')),
      body: Stack(
        children: [
          _riveArtboard == null
              ? const SizedBox()
              : GestureDetector(
                  onTapDown: (_) => _trigger?.fire(),
                  child: Rive(
                    artboard: _riveArtboard!,
                    fit: BoxFit.cover,
                  ),
                ),
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Press to activate!',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                stateChangeMessage,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
