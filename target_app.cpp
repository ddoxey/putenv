#include <iostream>
#include <cstdlib>     // For getenv()
#include <unistd.h>    // For getpid() and sleep()
#include <ctime>       // For std::strftime

void print_current_time(char* buffer, size_t size) {
    std::time_t now = std::time(nullptr);
    std::tm* local_time = std::localtime(&now);
    std::strftime(buffer, size, "%Y-%m-%d %H:%M:%S", local_time);
}

int main() {
    while (true) {
        // Get the debug level from the environment
        const char* debug_level = std::getenv("ABC_DEBUG_LEVEL");
        if (!debug_level) {
            debug_level = "0";  // Default to "0" if not set
        }

        // Get the current timestamp
        char timestamp[20];
        print_current_time(timestamp, sizeof(timestamp));

        // Print the message
        std::cout << "[" << timestamp << "] "
                  << getpid() << " "
                  << "ABC_DEBUG_LEVEL: " << debug_level << std::endl;

        // Pause for 2 seconds
        sleep(2);
    }

    return 0;
}
