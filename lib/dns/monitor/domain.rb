module DNS
  module Monitor

    # It's handy to be able to refer to Domains as objects
    Domain = Struct.new(:name, :rdap, :created_at) do
      def to_parsed_h
        to_h.merge(rdap: JSON.parse(self.rdap))
      end

      def to_s
        to_parsed_h.to_json
      end
    end
  end
end
