module CsvBuilder
  class Template
    def initialize(context)
      @context  = context
      @columns  = []
      @rows     = []
      @row      = {}
    end

    def array!(resources, &block)
      return if resources.empty?

      @rows = resources.map do |resource|
        @row = {}
        yield(resource)
        @row
      end
    end

    def set!(key, value = nil)
      @columns << key.to_s unless @columns.include?(key.to_s)
      @row[key.to_s] = value.to_s
    end

    def target!
      CSV.generate(headers: @columns, write_headers: true, skip_blanks: true, force_quotes: true) do |csv|
        @rows.each {|row| csv << @columns.map {|column| row[column].to_s }}
      end
    end

    alias_method :method_missing, :set!
    private :method_missing
  end
end
