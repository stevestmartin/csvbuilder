module CsvBuilder
  class TemplateHandler
    cattr_accessor :default_format
    self.default_format = Mime::CSV

    def self.call(template)
    %{__already_defined = defined?(csv); csv||=CsvBuilder::Template.new(self); #{template.source}
        csv.target! unless __already_defined}
    end
  end
end

ActionView::Template.register_template_handler :csvbuilder, CsvBuilder::TemplateHandler
