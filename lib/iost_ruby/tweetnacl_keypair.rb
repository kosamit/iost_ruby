require 'tweetnacl'
require 'base58'
require 'json'

# generate keypair
keypair = TweetNaCl.crypto_sign_keypair
verify_key = keypair[0]
signing_key = keypair[1]
puts Base58.binary_to_base58(verify_key, :bitcoin).length
puts Base58.binary_to_base58(signing_key, :bitcoin).length
c = TweetNaCl.crypto_sign_ed25519("aasdfasdffas", signing_key)
puts TweetNaCl.crypto_sign_ed25519_open(c, verify_key)
