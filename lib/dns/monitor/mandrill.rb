module DNS
  module Monitor
    class Mandrill
      API_URL = 'https://mandrillapp.com/api/1.0/messages/send.json'

      attr_reader :from_email, :recipient_email

      def initialize(api_key, recipient_email)
        @api_key = api_key
        @recipient_email = recipient_email
        @from_email = "dns-monitor@#{@recipient_email.split('@').last}"
      end

      def message(text)
        Net::HTTP.post(
          URI(API_URL), 
          request(domain, text).to_json, 
          'Content-Type' => 'application/json'
        )
      end

      def request(text)
        {
          "key" => @api_key,
          "message" => {
              #"html" => "<p>Example HTML content</p>",
              "text" => text,
              "subject" => "DNS Change Alert",
              "from_email" => @from_email,
              "from_name" => "DNS Monitor",
              "to" => [
                  {
                      "email" => @recipient_email,
                      "name" => @recipient_email,
                      "type" => "to"
                  }
              ],
              #"headers" => {
                  #"Reply-To" => "message.reply@example.com"
              #},
              #"important" => false,
              #"track_opens" => null,
              #"track_clicks" => null,
              #"auto_text" => null,
              #"auto_html" => null,
              #"inline_css" => null,
              #"url_strip_qs" => null,
              #"preserve_recipients" => null,
              #"view_content_link" => null,
              #"bcc_address" => "message.bcc_address@example.com",
              #"tracking_domain" => null,
              #"signing_domain" => null,
              #"return_path_domain" => null,
              #"merge" => true,
              #"merge_language" => "mailchimp",
              #"global_merge_vars" => [
                  #{
                      #"name" => "merge1",
                      #"content" => "merge1 content"
                  #}
              #],
              #"merge_vars" => [
                  #{
                      #"rcpt" => "recipient.email@example.com",
                      #"vars" => [
                          #{
                              #"name" => "merge2",
                              #"content" => "merge2 content"
                          #}
                      #]
                  #}
              #],
              #"tags" => [
                  #"password-resets"
              #],
              #"subaccount" => "customer-123",
              #"google_analytics_domains" => [
                  #"example.com"
              #],
              #"google_analytics_campaign" => "message.from_email@example.com",
              #"metadata" => {
                  #"website" => "www.example.com"
              #},
              #"recipient_metadata" => [
                  #{
                      #"rcpt" => "recipient.email@example.com",
                      #"values" => {
                          #"user_id" => 123456
                      #}
                  #}
              #],
              #"attachments" => [
                  #{
                      #"type" => "text/plain",
                      #"name" => "myfile.txt",
                      #"content" => "ZXhhbXBsZSBmaWxl"
                  #}
              #],
              #"images" => [
                  #{
                      #"type" => "image/png",
                      #"name" => "IMAGECID",
                      #"content" => "ZXhhbXBsZSBmaWxl"
                  #}
              #]
          },
          #"async" => false,
          #"ip_pool" => "Main Pool",
          #"send_at" => "example send_at"
        }
      end
    end
  end
end
