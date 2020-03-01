 require 'openssl'

 ## 鍵を生成
 ec = OpenSSL::PKey::EC.new('secp256k1')
 key = ec.generate_key
 
 ## 秘密鍵
 p sk = key.private_key.to_i
 
 ## 公開鍵
 p pk = key.public_key.to_bn.to_i

