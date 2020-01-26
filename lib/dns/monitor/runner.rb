module DNS
  module Monitor
    class Runner
      def initialize(params)
        @params = params
      end

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
        GChat.new(@params[:gchat]).message(message) if @params[:gchat] && checks.any? { |check| !check.ok? }
      end

      def entries
        puts db.entries(@params[:domain]).map{|row| row.to_parsed_h}.to_json
      end

      private
        
        def db
          @db ||= Database.new(@params[:db_path])
        end
    end
  end
end
