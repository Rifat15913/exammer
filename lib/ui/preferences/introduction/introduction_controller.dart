import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class IntroductionController extends GetxController {
  late VideoPlayerController? videoController;
  late Future<void>? initializeVideoPlayerFuture;

  @override
  void onInit() {
    videoController = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..setLooping(true)
      ..play();

    if (videoController != null) {
      initializeVideoPlayerFuture = videoController!.initialize();
    }

    super.onInit();
  }

  @override
  void dispose() {
    if (videoController != null && videoController!.value.isPlaying) {
      videoController?.pause();
      videoController?.dispose();
    }

    videoController = null;

    super.dispose();
  }

  void playPauseTheVideo() {
    if (videoController != null) {
      videoController!.value.isPlaying
          ? videoController!.pause()
          : videoController!.play();
    }

    update(["video_player"]);
  }

  void pauseTheVideo() {
    if (videoController != null && videoController!.value.isPlaying) {
      videoController?.pause();
    }

    update(["video_player"]);
  }

  void playTheVideo() {
    if (videoController != null && !videoController!.value.isPlaying) {
      videoController?.play();
    }

    update(["video_player"]);
  }
}
