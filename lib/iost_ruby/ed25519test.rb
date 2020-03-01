require 'base58'
require 'btcruby'
require 'ed25519'
require 'sha3'

def sign(signing_key)
  signing_key.keypair.unpack('H*').pack('m0')
end

serialized_hash = "/gB8TJQibGI7Kem1v4vJPcJ7vHP48GuShYfd/7NhZ3w="
public_key = "lDS+SdM+aiVHbDyXapvrsgyKxFg9mJuHWPZb/INBRWY="
private_key = "gkpobuI3gbFGstgfdymLBQAGR67ulguDzNmLXEJSWaGUNL5J0z5qJUdsPJdqm+uyDIrEWD2Ym4dY9lv8g0FFZg=="
signed_hash = "/K1HM0OEbfJ4+D3BmalpLmb03WS7BeCz4nVHBNbDrx3/A31aN2RJNxyEKhv+VSoWctfevDNRnL1kadRVxSt8CA=="

# puts public_key.unpack('m0')