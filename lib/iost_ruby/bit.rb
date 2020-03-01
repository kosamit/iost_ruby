# frozen_string_literal: true

require 'pp'
require 'fast_jsonapi'

def num_to_array(num)
  num.each_char.each_slice(2).map { |s| s.join.to_i(16) }
end

def int64_to_bytes(num)
  num_to_array(format('%016x', num))
end

def int32_to_bytes(num)
  num_to_array(format('%08x', num))
end

def string_to_bytes(str)
  num_to_array(format('%08x', str.length)).concat(str.bytes)
end

def array_to_bytes(array)
  arr = []
  array.each do |str|
    arr.concat(string_to_bytes(str))
  end
  num_to_array(format('%08x', array.length)).concat(arr)
end

def map_to_bytes(hash)
  hash = hash.first.to_h
  arr = []
  hash.each do |array|
    array.each do |str|
      arr.concat(string_to_bytes(str.to_s))
    end
  end
  num_to_array(format('%08x', hash.length)).concat(arr)
end

def debug
  p int64_to_bytes(18_446_744_073_709_551_615)
  p int32_to_bytes(4_294_967_295)
  p string_to_bytes('iost')
  p array_to_bytes(%w[iost iost])
  p map_to_bytes(["b": 'iost', "a": 'iost'])
end

def tx_to_bytes(tx)
  reserved = tx.dig('reserved') ? tx.dig('reserved') : 0
	int64_to_bytes(tx.dig('time')) + int64_to_bytes(tx.dig('expiration')) +
  int64_to_bytes((tx.dig('gas_ratio').to_i * 100)) + int64_to_bytes((tx.dig('gas_limit').to_i * 100)) +
  int64_to_bytes(tx.dig('delay')) + int32_to_bytes(tx.dig('chain_id')) +
  reserved +
  array_to_bytes(tx.dig('signers')) + array_to_bytes(tx.dig('actions')) +
  array_to_bytes(tx.dig('amount_limit')) + array_to_bytes(tx.dig('signatures'))
end

debug
# json = '{"actions":[{"action_name":"transfer","contract":"token.iost","data":"[\"iost\", \"testaccount\", \"anothertest\", \"100\", \"this is an example transfer\"]"}],"amount_limit":[{"token":"*","value":"unlimited"}],"delay":0,"chain_id":1024, "expiration": 1544709692318715000,"gas_limit":500000,"gas_ratio":1,"publisher":"testaccount","publisher_sigs":[{"algorithm":"ED25519","public_key":"lDS+SdM+aiVHbDyXapvrsgyKxFg9mJuHWPZb/INBRWY=","signature":"/K1HM0OEbfJ4+D3BmalpLmb03WS7BeCz4nVHBNbDrx3/A31aN2RJNxyEKhv+VSoWctfevDNRnL1kadRVxSt8CA=="}],"signatures":[],"signers":[],"time": 1544709662543340000}'

# json = '{
#     "time": 1544709662543340000,
#     "expiration": 1544709692318715000,
#     "gas_ratio": 1,
#     "gas_limit": 500000,
#     "delay": 0,
#     "chain_id": 1024,
#     "signers": [],
#     "actions": [
#         {
#             "contract": "token.iost",
#             "action_name": "transfer",
#             "data": "[\"iost\", \"testaccount\", \"anothertest\", \"100\", \"this is an example transfer\"]",
#         },
#     ],
#     "amount_limit": [
#         {
#             "token": "*",
#             "value": "unlimited",
#         },
#     ],
#     "signatures": [],
# }'

# puts tx.dig('time')
# puts tx.dig('expiration')
# puts tx.dig('gas_ratio')
# puts tx.dig('gas_limit')
# puts tx.dig('delay')
# puts tx.dig('chain_id')
# puts tx.dig('reserved')
# puts tx.dig('signers')
# puts tx.dig('actions')
# puts tx.dig('amount_limit')
# puts tx.dig('signatures')


# debug
# tx_to_bytes(tx)

# puts array = tx.dig('actions',0,'data') rescue nil

# transaction = JSON.parse(json)

# puts transaction.class
# puts transaction.dig('actions')

#     型    |変換メソッド                          |例
# ---     |--------------                                 |--------------------
# int     |バイト配列にビッグエンディアンに変換 |int64(1023)は \[0 0 0 0 0 0 3 255\]
# string  |文字列中の各文字をバイトに分けて、長さをその前に付与    |"iost" は \[0 0 0 4 105 111 115 116\]
# array   | 配列の各要素をバイト配列に変換し、長さを配列の前に付与 |\["iost" "iost"\] は \[0 0 0 2 0 0 0 4 105 111 115 116 0 0 0 4 105 111 115 116\]
# map     |ディクショナリ内のキーと値の各ペアをバイト配列に変換して分けておき、キーの昇順にして、各ペアの前に長さを付与 |\["b":"iost", "a":"iost"\] は \[0 0 0 2 0 0 0 1 97 0 0 0 4 105 111 115 116 0 0 0 1 98 0 0 0 4 105 111 115 116\] "

# トランザクションのパラメータは、 "time"、 "expiration"、 "gas_ratio"、 "gas_limit"、 "delay"、 "chain_id"、 "reserved"、　"signers"、 "actions"、 "amount_limit"、"signature"の順に宣言されています。そのため、トランザクション構造体をバイト配列に変換する疑似コードは次のようになります。
# ```
# func TxToBytes(t transaction) []byte {
#         return Int64ToBytes(t.time) + Int64ToBytes(t. expiration) +
#                 Int64ToBytes(int64(t.gas_ratio * 100)) + Int64ToBytes(int64(t.gas_limit * 100)) +     // Node that gas_ratio and gas_limit need to be multiplied by 100 and convert to int64
#                 Int64ToBytes(t.delay) + Int32ToBytes(t.chain_id) +
#                 BytesToBytes(t.reserved) + // reserved is a reserved field. It only needs to write an empty byte array when serialized. Don't send this field in RPC request parameters.
#                 ArrayToBytes(t.signers) + ArrayToBytes(t.actions)  +
#                 ArrayToBytes(t.amount_limit) + ArrayToBytes(t.signatures)
#     }
# ```
#
