require 'base58'
require 'btcruby'
require 'ed25519'
require 'sha3'

# 公開鍵生成
signing_key = Ed25519::SigningKey.generate

# 秘密鍵生成
verify_key = signing_key.verify_key

signing_key_bytes = signing_key.to_bytes
puts Base58.binary_to_base58(signing_key_bytes, :bitcoin)

verify_key_bytes = Base58.binary_to_base58(verify_key.to_bytes, :bitcoin)

puts verify_key_bytes

message = "hoge"
signature = signing_key.sign(message)
puts verify_key.verify(signature, message)