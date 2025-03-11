import ballerina/http;

final http:Client httpClient = check new ("https://api.apilayer.com/exchangerates_data");
