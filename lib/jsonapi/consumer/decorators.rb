module JSONAPI
  module Consumer
    ResultSet.class_eval do
      def each_total
        results = pages.first
        loop do
          results.each do |result|
            yield(result)
          end
          results = results.pages.next
          break unless results
        end
      end
    end
  end
end
