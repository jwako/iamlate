# encoding: UTF-8

module Iamlate

  # The only real class that ever needs to be instantiated.
  class API
    attr_accessor :api_host
    attr_accessor :client_info

    # Creates a new API handler to shuttle calls/jobs/etc over to the Gengo translation API.
    #
    # Options:
    # <tt>opts</tt> - A hash containing the api key, the api secret key, the API version (defaults to 1), whether to use
    # the sandbox API, and an optional custom user agent to send.
    def initialize(opts)
      # Consider this an example of the object you need to pass.
      @opts = {
        :consumer_key => 'your_access_key',
        :api_version => '2'
      }.merge(opts)

      # Let's go ahead and separate these out, for clarity...
      @api_host = Iamlate::Config::API_HOST

      # More of a public "check this" kind of object.
      @client_info = {"VERSION" => Iamlate::Config::VERSION}
    end

    # Use CGI escape to escape a string
    def urlencode(string)
      CGI::escape(string)
    end

    def get_from_metro(endpoint, params = {})
      query = params.reduce({}) do |hash_thus_far, (param_key, param_value)|
        hash_thus_far.merge(param_key.to_sym => param_value.to_s)
      end
      query["acl:consumerKey"] = @opts[:consumer_key]
      endpoint << '?' + query.map { |k, v| "#{k}=#{urlencode(v)}" }.join('&')
      uri = "/api/v#{@opts[:api_version]}/" + endpoint
      conn = Faraday.new(url: @api_host) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end
      resp = conn.get(uri)
      json = JSON.parse(resp.body)
      return json
    end

    def getTrainInfo(params = {})
      self.get_from_metro('datapoints', {"rdf:type" => "odpt:TrainInformation"}.merge(params))
    end

  end

end
