module DNS
  module Monitor
    class Check
      def initialize(domain, status, diff={})
        @diff = diff
        @domain = domain
        @status = status
      end

      def ok?
        @status == :ok
      end

      def status
        case @status
          when :ok
            { domain: @domain, ok: true }
          when :changed
            { domain: @domain, changes: @diff }
          else
            :error
        end
      end

      def to_s
        status.inspect
      end
    end
  end
end
