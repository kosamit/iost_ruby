require 'tweetnacl'
require 'base58'
require 'json'

# generate keypair
keypair = TweetNaCl.crypto_sign_keypair
verify_key = keypair[0]
signing_key = keypair[1]
puts Base58.binary_to_base58(verify_key, :bitcoin)
puts Base58.binary_to_base58(signing_key, :bitcoin)
# c = TweetNaCl.crypto_sign_ed25519("aasdfasdffas", signing_key)
# puts TweetNaCl.crypto_sign_ed25519_open(c, verify_key)


verify_key = Base58.base58_to_binary("6YjLHye9cXGLKPgbKNWjD32SY9WPry8TkcbeqH4gYVb3",:bitcoin)
signing_key = Base58.base58_to_binary("3tyqePDAQJKAnUuUck4HiaWzYpmRdocNh6Ty8bs5C4SbSMEKeecJjt4Wixi2pPttGTuSermCKu5j6As4qfPKrWtd",:bitcoin)


# c = TweetNaCl.crypto_sign_ed25519()