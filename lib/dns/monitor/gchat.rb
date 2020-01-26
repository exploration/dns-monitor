module DNS
  module Monitor
    class GChat
      def initialize(webhook_url)
        @webhook_url = webhook_url
      end

      def message(text)
        Net::HTTP.post(
          URI(@webhook_url), 
          {text: text}.to_json, 
          'Content-Type' => 'application/json'
        )
      end
    end
  end
end
