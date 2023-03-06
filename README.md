# desktop_recorder

A desktop Flutter project aiming desktop screen recording on Windows and MacOS.


## Known Issue
- desktop_recorder did not consider the privilege of accessing and saving file.


## TODO
- ~~Prevent application from closing while mid-recording.~~ DONE!!
- Replace both Windows and MacOS with [ffmpeg-wasm](https://github.com/ffmpegwasm/ffmpeg.wasm) (mainly Windows)
    - Progression:
        - ~~Generate ffmpeg-wasm(ffmpeg-core.wasm).~~ DONE!!
        - ~~Load .wasm by using [dart-wasm](https://github.com/dart-lang/wasm)~~. Windows inport failed. ("dart run wasm:setup" failed to generate needed .dll)
        - Looking to [web_ffi](https://pub.dev/packages/web_ffi) and [dart:wasm](https://api.flutter.dev/flutter/dart-wasm/dart-wasm-library.html) packages.