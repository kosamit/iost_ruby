require 'faraday'
require 'faraday_middleware'
require 'uri'
require 'json'
require 'time'

module IostRuby
  class Client
    DEFAULTS = {
      url:     -> { ENV['IOST_URL'] },
      scheme:  'http',
      host:    '127.0.0.1',
      port:    30001,
      timeout: 5
    }.freeze

    attr_reader :options

    # @param [hash] options HTTP Client connection information
    # @option options [Symbol] :url URL
    # @option options [Symbol] :scheme default http (http only)
    # @option options [Symbol] :host default 127.0.0.1
    # @option options [Symbol] :port default 30001
    # @option options [Symbol] :timeout default 5
    def initialize(options = {})
      @options = parse_options(options)
    end

    def request(method, path, params = {})
      if params.is_a?(Hash) && !params.empty?
        params.reject! { |_, value| value.nil? }
      end

      res = connection.send(method, path, params)
      body = res.body
      hash = parse_body(body) unless body.empty?
      block_given? ? yield(hash) : hash
    end

    def request!(method, path, params = {})
      hash = request(method, path, params)
      raise error_handling(hash) if hash && hash.key?(:error)
      block_given? ? yield(hash) : hash
    end

    private

    def error_handling(hash)
      error_klass = case hash[:error]
      when 'Not Found' then Iost::NotFoundError
      when 'Bad Request' then Iost::BadRequestError
      when 'Internal Server Error' then Iost::InternalServerError
      else Iost::Error
      end
      error_klass.new(hash[:message])
    end

    def connection
      @connection ||= Faraday.new(url: @options[:url]) do |f|
        f.options[:timeout] = @options[:timeout]
        f.request :json
        f.adapter Faraday.default_adapter
      end
    end

    def parse_body(body)
      JSON.parse(body, symbolize_names: true)
    end

    def parse_options(options = {})
      defaults = DEFAULTS.dup
      options  = options.dup

      defaults[:url] = defaults[:url].call if defaults[:url].respond_to?(:call)

      defaults.keys.each do |key|
        options[key] = options[key.to_s] if options.key?(key.to_s)
      end

      url = options[:url] || defaults[:url]

      if url
        uri = URI(url)
        defaults[:scheme] = uri.scheme
        defaults[:host]   = uri.host
        defaults[:port]   = uri.port
      end

      defaults.keys.each do |key|
        options[key] = defaults[key] if options[key].nil?
      end

      options[:url] = URI::Generic.build(
        scheme: options[:scheme],
        host:   options[:host],
        port:   options[:port]
      ).to_s

      options
    end
  end
end
