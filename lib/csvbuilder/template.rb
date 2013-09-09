module CsvBuilder
  class ColumnArray < Array
    def initialize(*args)
      if args.size == 1 && args[0].is_a? Array then
        super(args[0].uniq)
      else
        super(*args)
      end
    end

    def insert(index, object)
      super(index, object) unless include?(object)
    end

    def <<(object)
      super(object) unless include?(object)
    end

    def []=(*args)
      object = case args.size
        when 3 then args[2]
        when 2 then args[1]
        else nil
      end

      super(*args) if object.nil? || !include?(object)
    end
  end

  class CsvTemplate
    def initialize(context)
      @context  = context
      @columns  = ColumnArray.new
      @rows     = []
    end

    def array!(resources, &block)
      return if resources.nil?

      @rows = resources.map do |row|
        yield
      end
    end

    def column!(key, value = nil)
      @columns << key.to_s
    end

    def target!
      CSV.generate do |csv|
        csv << @columns
        @rows.each {|row| csv << row }
      end
    end

    alias_method :method_missing, :column!
    private :method_missing
  end

  class CsvTemplateHandler
    cattr_accessor :default_format
    self.default_format = Mime::CSV

    def self.call(template)
    %{__already_defined = defined?(csv); csv||=CsvTemplate.new(self); #{template.source}
        csv.target! unless __already_defined}
    end
  end
end
