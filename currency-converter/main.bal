import ballerina/http;
import ballerina/log;
import ballerinax/redis;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service / on httpDefaultListener {
    private redis:Client? redisClient = ();

    function init() {
        // Initialize the redis client
        do {
            self.redisClient = check new (connection = "redis://localhost:6379");
        } on fail error err {
            log:printWarn("Error initializing redis client: " + err.message());
            log:printWarn("Caching will be disabled");
            self.redisClient = ();
        }
    }

    resource function get convert(string 'from = "USD", string to = "LKR", decimal amount = 1) returns json|error {
        do {
            string key = 'from + "-" + to;
            string|() cachedRate = check getCachedRate(self.redisClient, key);
            if cachedRate is string {
                // If the value found in the cache, calculate based on the cached rate
                return {value: amount * check decimal:fromString(cachedRate)};
            } else {
                json response = check httpClient->get("/convert?from=" + 'from + "&to=" + to + "&amount=" + amount.toString(), headers = {"apikey": apiKey});
                if response.suceess == false {
                    return error("Error converting currency: " + (check response.reason).toString());
                }

                decimal rate = check response.result;
                decimal convertedAmount = amount * rate;
                // Update the cache with the new rate
                check updateCache(self.redisClient, key, rate);
                return {value: convertedAmount};
            }
        } on fail error err {
            log:printError("Error converting currency: " + err.message());
            return error("Error converting currency: " + err.message());
        }
    }
}

function getCachedRate(redis:Client? redisClient, string key) returns string|error? {
    if (redisClient is redis:Client) {
        string|() cachedRate = check redisClient->get(key);
        if cachedRate is string {
            return cachedRate;
        }
    }
}

function updateCache(redis:Client? redisClient, string key, decimal rate) returns error? {
    if (redisClient is redis:Client) {
        _ = check redisClient->set(key, rate.toString());
    }
}
