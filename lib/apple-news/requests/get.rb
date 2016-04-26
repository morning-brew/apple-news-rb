module AppleNews
  module Request
    class Get
      attr_reader :url

      def initialize(url)
        @config = AppleNews.config
        @url = url
      end

      def call
        conn.get(url) do |req|
          req.headers = headers
        end
      end

      private

      def conn
        Faraday.new(url: @config.api_base) do |faraday|
          faraday.request :json
          faraday.response :json
          faraday.adapter Faraday.default_adapter
        end
      end

      def headers
        security = AppleNews::Security.new('GET', @url)
        { 'Authorization' => security.authorization }
      end
    end
  end
end
