require 'pp'

module IostRuby
  class Api

    @client ||= IostRuby::Client.new
    
    def node_info
      @client.request :get, 'getNodeInfo'
    end

    def chain_info
      @client.request :get, 'getChainInfo'
    end

    def gas_ratio
      @client.request :get, 'getGasRatio'
    end

    def ram_info
      @client.request :get, 'getRAMInfo'
    end

    def tx_by_hash(hash)
      @client.request :get, "getTxByHash/#{hash}"
    end

    def tx_receipt_by_tx_hash(hash)
      @client.request :get, "getTxReceiptByTxHash/#{hash}"
    end

    # true: ブロック内のトランザクションの詳細情報を表示、false: 表示しない
    def block_by_hash(hash, complete = false)
      @client.request :get, "getBlockByHash/#{hash}/#{complete}"
    end

    def block_by_number(number, complete = false)
      @client.request :get, "getBlockByNumber/#{number}/#{complete}"
    end

    # true: 最長のチェーンからデータを取得、false: 不可逆ブロックからデータを取得
    def account(name, by_longest_chain = true)
      @client.request :get, "getAccount/#{name}/#{by_longest_chain}"
    end

    # true: 最長のチェーンからデータを取得、false: 不可逆ブロックからデータを取得
    def token_balance(account, token, by_longest_chain = true)
      @client.request :get, "getTokenBalance/#{account}/#{token}/#{by_longest_chain}"
    end

    def producer_vote_info(name, by_longest_chain = true)
      @client.request :get, "GetProducerVoteInfo/#{name}/#{by_longest_chain}"
    end

    # true - get data from longest chain; false - get data from irreversible blocks
    def contract(id, by_longest_chain = true)
      @client.request :get, "getContract/#{id}/#{by_longest_chain}"
    end

    # true - get data from the longest chain; false - get data from irreversible blocks
    def contract_storage(id, key, field, by_longest_chain = true)
      @client.request :post, "getContractStorage", "{\"id\":\"#{id}\",\"key\":\"#{key}\",\"field\":\"#{field}\",\"by_longest_chain\":#{by_longest_chain}}"
    end

    def contract_storage_field(id, key, field, by_longest_chain = true)
      @client.request :post, "getContractStorageFields", "{\"id\":\"#{id}\",\"key\":\"#{key}\",\"field\":\"#{field}\",\"by_longest_chain\":#{by_longest_chain}}"
    end

    def batch_contract_storage
      @client.request :post, "getBatchContractStorage"
    end
  end
end
