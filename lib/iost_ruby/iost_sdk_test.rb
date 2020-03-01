require 'iost_sdk'

# set the JSON RPC endpoint base URL
base_url = 'http://127.0.0.1:30001'
iost = IOSTSdk::Main.new(endpoint: base_url)

ALGO = "ed25519"
PUBKEY = "3F4foNDXWccUvAdonmEVyGoeEaFYqDy4CrqsixbaWx3Q"
SECKEY = "3HsWKwM28fG6FUnXmD8f1MREmiRoYGyRzaVraZz94iKyJZf3yGcpET3ignN9AmJZpgKn28vJhYts4z4jrVG391YS"

kosamit = {
"Algorithm": "ed25519",
"Pubkey": "GF89KXHx4c2GPak2E7zUUJ9KmUzdn6t7peSJnchDfmJc",
"Seckey": "4QgtwgN7iu4fYqUEUuLQqyEs21euPjPk2TzfkKs2bhR83aYxUzEzm2BcW9D4gfeSY5h6RUYLKoypfHKHa8v39jeL"
}
key_pair = IOSTSdk::Crypto.keypair_from_private_key(
      algo: 'ED25519',
      encoded_private_key: 'GF89KXHx4c2GPak2E7zUUJ9KmUzdn6t7peSJnchDfmJc'
    )

# puts kosamit[:Pubkey]
# # create a new account
# resp = iost.new_account(
#              name: 'n00b',
#              creator: 'admin',
#              owner_key: key_pair,
#              active_key: key_pair,
#              initial_ram: 10,
#              initial_gas_pledge: 0
#            )
#            .sign_and_send(account_name: 'admin', key_pair: key_pair)
# # transfer tokens
resp = iost.transfer(
             token: 'iost',
             from: 'kosamit',
             to: 'kosamit2',
             amount: 1.0,
             memo: 'free tokens!'
           )
           .sign_and_send(account_name: 'kosamit', key_pair: key_pair)
# call ABI
# resp = iost.call_abi(
#              contract_id: 'token.iost',
#              abi_name: 'transfer',
#              abi_args: ['iost', 'rich', 'poor', '10.000', 'hey hey']
#            )
#            .sign_and_send(account_name: 'rich', key_pair: key_pair)

# resp is a hash with keys :status and :txn_hash
# status = resp[:status] # status can be `pending`, `success` or `failed`
# txn_hash = resp[:txn_hash]