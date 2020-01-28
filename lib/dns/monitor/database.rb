module DNS
  module Monitor
    class Database
      # This is the general DB structure
      TABLE = 'domains'

      def initialize(db_path)
        @db_path = db_path
        initialize_db
      end

      # Returns a Check object, or nothing if the params were empty
      def check(domain, rdap)
        return if domain.nil? || rdap.nil?

        changes = diff(most_recent(domain).rdap, rdap)

        if changes.empty?
          Check.new domain, :ok
        else
          insert(domain, rdap)
          Check.new domain, :changed, changes
        end
      end

      # This is mostly for testing
      def clear
        query { |db| db.execute "DELETE FROM #{TABLE} WHERE 1" }
      end

      # Compare two different RDAP values
      # NOTE: We have to do a JSON conversion because the values come
      #   back from the server in arbitrary JSON key order.
      def diff(previous_rdap, rdap)
        JSON.parse(previous_rdap).easy_diff(JSON.parse(rdap)).last
      end

      # Return all entries for a given domain as a Domain struct
      def entries(domain)
        sql = "SELECT * FROM #{TABLE} WHERE domain=? ORDER BY created_at DESC"
        query {|db| db.execute(sql, [domain]) }.map{ |row| Domain.new(*row) }
      end

      # Just the latest entry plz
      def most_recent(domain)
        entries(domain).first || Domain.new
      end

      private

        def initialize_db
          query do |db| db.execute <<~SQL
            CREATE TABLE IF NOT EXISTS #{TABLE} (
              domain VARCHAR(255),
              rdap TEXT,
              created_at TIMESTAMP DEFAULT (DATETIME('now','localtime'))
            );
          SQL
          end
        end

        def insert(domain, rdap)
          query do |db|
            db.execute "INSERT INTO #{TABLE} (domain, rdap) VALUES (?,?)", [ domain, rdap ]
          end
        end

        def query
          db = SQLite3::Database.new @db_path
          result = yield db
          db.close if db
          result
        end
    end
  end
end
