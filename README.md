# desktop_recorder

A desktop Flutter project aiming desktop screen recording on Windows and MacOS.


## Known Issue
- desktop_recorder did not consider the privilege of accessing and saving file in certain directory.
- on MacOS, terminate the application while it is still recording will cause the video to corrupt.


## TODO
- replace both Windows and MacOS with [dart-wasm](https://github.com/dart-lang/wasm) + [ffmpeg-wasm](https://github.com/ffmpegwasm/ffmpeg.wasm)
   - current progression:
      - Generate ffmpeg-wasm completed. (ffmpeg-core.wasm)
      - Fail to import dart-wasm to Windows platform. ("dart run wasm:setup" failed to generate needed .dll)
