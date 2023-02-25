#include <Windows.h>
#include <MMSystem.h>
#include <iostream>

using namespace std;

int main()
{
    // Check if the PC is muted every 1 second
    while (true)
    {
        // Get the current volume level
        DWORD volume;
        MMRESULT result = waveOutGetVolume(0, &volume);

        // If the volume level is 0, it means the PC is muted
        if (result == MMSYSERR_NOERROR && volume == 0)
        {
            // Shut down the computer
            system("shutdown /s /t 0");
            break;
        }

        // Sleep for 1 second before checking again
        Sleep(1000);
    }

    return 0;
}
