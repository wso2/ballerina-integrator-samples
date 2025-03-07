import ballerina/http;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service / on httpDefaultListener {
    function init() returns error? {
        do {

        } on fail error err {

        }
    }

    resource function get greeting(string name = "world") returns string {
        // Returns the greeting message as a string
        return "Hello, " + name;
    }
}
