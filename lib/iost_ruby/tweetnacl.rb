require 'tweetnacl'
require 'base58'
require 'json'
require 'ed25519'

kosamit = {
  "Algorithm": "ed25519",
  "Pubkey": "GF89KXHx4c2GPak2E7zUUJ9KmUzdn6t7peSJnchDfmJc",
  "Seckey": "4QgtwgN7iu4fYqUEUuLQqyEs21euPjPk2TzfkKs2bhR83aYxUzEzm2BcW9D4gfeSY5h6RUYLKoypfHKHa8v39jeL"
}

# sign from exist keys
# b = TweetNaCl.crypto_sign_ed25519("aaa",Base58.base58_to_binary(kosamit[:Seckey], :bitcoin))
# puts TweetNaCl.crypto_sign_ed25519_open(b, Base58.base58_to_binary(kosamit[:Pubkey], :bitcoin))

# generate keypair
# keypair = TweetNaCl.crypto_sign_keypair
# pubkey = Base58.binary_to_base58(keypair[0], :bitcoin)
# seckey = Base58.binary_to_base58(keypair[1], :bitcoin)

# c = TweetNaCl.crypto_sign_ed25519("aaa",Base58.base58_to_binary(seckey, :bitcoin))
# puts TweetNaCl.crypto_sign_ed25519_open(c, Base58.base58_to_binary(pubkey, :bitcoin))

# generate keypair

1.times do
  pubkey, seckey = TweetNaCl.crypto_sign_keypair
  p pubkey
  c = TweetNaCl.crypto_sign_ed25519("aaa",seckey)
  puts TweetNaCl.crypto_sign_ed25519_open(c, pubkey)
end
