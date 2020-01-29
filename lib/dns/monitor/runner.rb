module DNS
  module Monitor
    class Runner
      # The "Runner" is the back-end for the command-line utility
      def initialize(params)
        @params = params
      end

      # This is the main action we do with this app - check all of the domains
      def check
        begin
          domains = File.read(@params[:domains_path]).split
        rescue Errno::ENOENT 
          STDERR.puts "File #{@params[:domains_path]} does not exist"
          exit 1 
        end

        checks = domains.map do |domain|
          rdap = Net::HTTP.get(URI("#{@params[:rdap_url]}/domain/#{domain}"))
          db.check domain, rdap 
        end

        message = checks.map {|check| check.status}.to_json
        STDOUT.puts message

        if @params[:gchat] 
          # GChat gets every status update
          GChat.new(@params[:gchat]).message(message) 
        end
        if @params[:mandrill_key] && @params[:mandrill_email] && checks.any?(&:changed?)
          # We only email changed domains
          Mandrill.new(@params[:mandrill_key], @params[:mandrill_email]).message(message)
        end
      end

      # This is an alternative app action - check the history for a particular domain.
      def entries
        STDOUT.puts db.entries(@params[:domain]).map{|row| row.to_parsed_h}.to_json
      end

      private
        
        def db
          @db ||= Database.new(@params[:db_path])
        end
    end
  end
end
