import ballerina/io;
import ballerina/log;
import ballerina/time;

public function main() returns error? {
    do {

        // Get the current timestamp

        time:Utc currentTime = time:utcNow();
        string formattedTime = time:utcToString(currentTime);

        // Print the timestamp in UTC format

        io:println("Current timestamp: " + formattedTime);

    } on fail error e {
        log:printError("Error: ", 'error = e);
        return e;
    }
}
