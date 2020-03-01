require 'iost_sdk'

# set the JSON RPC endpoint base URL
base_url = 'https://127.0.0.1:30001'
iost = IOSTSdk::Main.new(endpoint: base_url)

# get node info
node_info = iost.get_node_info

# get chain info
chain_info = iost.get_chain_info

# get gas ratio
gas_ratio = iost.get_gas_ratio

# get ram info
ram_info = iost.get_ram_info

# # get transaction by hash
# txn = iost.get_tx_by_hash(hash_value: 'my-transaction-hash')

# # get transaction receipt by hash
# tx_receipt = iost.get_tx_receipt_by_tx_hash(hash_value: 'my-transaction-receipt-hash')

# # get block by hash
# block_info = iost.get_block_by_hash(hash_value: 'hash-value', complete: true)

# # get block by number
# block_info = iost.get_block_by_number(number: 123, complete: true)

# # # get account
# account = iost.get_account(name: 'my_account', by_longest_chain: true)

# # get token balance
# token_balance = iost.get_token_balance(
#   account_name: 'my_account',
#   token_name: 'iost',
#   by_longest_chain: true
# )

# # get contract
# contract = iost.get_contract(id: 'contract_123', by_longest_chain: true)

# # get contract storage
# query = IOSTSdk::Models::Query::ContractStorage.new.populate(
#   model_data: {
#     'id' => 'contract_id',
#     'field' => 'producer002',
#     'key' => 'producerTable',
#     'by_longest_chain' => true
#   }
# )
# contract_storage = iost.get_contract_storage(query: query)

# # get contract storage fields
# query = IOSTSdk::Models::Query::ContractStorageFields.new.populate(
#   model_data: {
#     'id' => @test_data[:contract_name],
#     'key' => 'producerTable',
#     'by_longest_chain' => true
#   }
# )
# contract_storage_fields = iost.get_contract_storage_fields(query: query)