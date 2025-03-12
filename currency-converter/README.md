# Currency Converter API

## Description

A REST API that converts currency from one unit to another using an external exchange rate API. The service also caches
exchange rates using Redis to improve performance and reduce external API calls.

## Prerequisites

- Ensure that Redis is running on `localhost:6379`. (if Redis is running on a different host or port, update the redis
  configurations in the implementation accordingly)
  Note: If the Redis server is not running, the service will still work, but without caching.

- Log in to [ExchangeRate API](https://www.exchangerate-api.com/) and obtain an API key.
- Update the `apiKey` configuration in the `Config.toml` file with the obtained API key.

## Usage Instructions

1. Run the integration locally using the **Run** button in Ballerina Integrator.
2. Use the **"Try It"** feature (auto popup) to send a `GET` request to the `/convert` endpoint with the following query
   parameters:
    - `from` (default: `USD`): The source currency.
    - `to` (default: `LKR`): The target currency.
    - `amount` (default: `1`): The amount to be converted.
3. If an exchange rate is available in the Redis cache, the conversion will be done using the cached rate. Otherwise,
   the API fetches the latest rate and updates the cache.

## Example Request

```
GET /convert?from=EUR&to=INR&amount=100
```

## Example Response

```json
{
  "value": 8500.50
}
```
