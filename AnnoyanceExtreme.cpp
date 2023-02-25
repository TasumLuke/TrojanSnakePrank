#include <iostream>
#include <vector>
#include <shellapi.h>
#include <windows.h>

int main()
{
    std::vector<std::string> urls = {
        "https://www.youtube.com/watch?v=UqEEbwbFAN0&list=RDMMGQD31ZSqBG4&index=36",
        "https://www.youtube.com/watch?v=paNWYLhMoDU&list=RDMMGQD31ZSqBG4&index=3",
        "https://www.youtube.com/watch?v=1W_f_q4ENMA&list=RDMMGQD31ZSqBG4&index=20"
        "https://www.youtube.com/watch?v=NP2qBzJ24VA&list=RDMMGQD31ZSqBG4&index=21"
        "https://www.youtube.com/watch?v=EoVvI058KrI&list=RDMMGQD31ZSqBG4&index=18"
        "https://www.youtube.com/watch?v=6k1Lxa7o5o4&list=RDMMGQD31ZSqBG4&index=19"
        "https://www.youtube.com/watch?v=I_2d_7ItQOc&list=RDMMGQD31ZSqBG4&index=16"
        "https://www.youtube.com/watch?v=rc8FALoOP9c&list=RDMMGQD31ZSqBG4&index=14"
        "https://www.youtube.com/watch?v=H_HQnv4xzec&list=RDMMGQD31ZSqBG4&index=15"
        "https://www.youtube.com/watch?v=WMAUZ9XWb80&list=RDMMGQD31ZSqBG4&index=12"
        "https://www.youtube.com/watch?v=0TY2SkS3EnY&list=RDMMGQD31ZSqBG4&index=5"
        "https://www.youtube.com/watch?v=7-kkD7XUFso&list=RDMMGQD31ZSqBG4&index=8"
        "https://www.youtube.com/watch?v=5YsbA-A0w2I&list=RDMMGQD31ZSqBG4&index=3"
    };

    int current_url = 0;
    while (true) {
        std::string url = urls[current_url];

        // Open the URL in the default web browser
        HINSTANCE result = ShellExecute(NULL, "open", url.c_str(), NULL, NULL, SW_SHOWNORMAL);

        // Check if the ShellExecute function was successful
        if ((int)result <= 32) {
            std::cerr << "Error: Could not open URL in web browser" << std::endl;
            return 1;
        }

        // Wait for the process to terminate
        HANDLE process = (HANDLE)result;
        WaitForSingleObject(process, INFINITE);

        // Open two more tabs
        for (int i = 0; i < 2; i++) {
            std::string url = urls[(current_url + i + 1) % urls.size()];
            result = ShellExecute(NULL, "open", url.c_str(), NULL, NULL, SW_SHOWNORMAL);

            // Check if the ShellExecute function was successful
            if ((int)result <= 32) {
                std::cerr << "Error: Could not open URL in web browser" << std::endl;
                return 1;
            }
        }

        // Increment the index and wrap around if necessary
        current_url = (current_url + 2) % urls.size();
    }

    return 0;
}