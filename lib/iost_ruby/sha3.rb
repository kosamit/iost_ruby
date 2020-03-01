require 'digest/sha3'
require 'json'

p Digest::SHA3.digest("foo", 256)
p Digest::SHA3.hexdigest("foo", 256)


json = '{
    "time": 1544709662543340000,
    "expiration": 1544709692318715000,
    "gas_ratio": 1,
    "gas_limit": 500000,
    "delay": 0,
    "chain_id": 1024,
    "signers": [],
    "actions": [
        {
            "contract": "token.iost",
            "action_name": "transfer",
            "data": "[\"iost\", \"testaccount\", \"anothertest\", \"100\", \"this is an example transfer\"]",
        },
    ],
    "amount_limit": [
        {
            "token": "*",
            "value": "unlimited",
        },
    ],
    "signatures": [],
}'

# iwallet --account kosamit call "Contract5UdNk7w5gdXrZuKMFyhSM86Q4d3MNTnUUBFzm8AiyUmt" "getBalance" '["kosamit"]'
# HjBXZbRSXtnf2E7pGhfBQTjpqwK1Xng9q1qMCdJfE55o
json = json.
puts json