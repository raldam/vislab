=begin
  Jekyll tag to include Markdown text from _includes directory preprocessing with Liquid.
  Usage:
    {% markdown <filename> %}
=end
module Jekyll

  class MarkdownTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text.strip
    end

    def render(context)
      source_dirname = File.dirname(__FILE__) + '/../'
      tmpl = File.read File.join source_dirname, "_includes", @text
      site = context.registers[:site]
      converter = site.getConverterImpl(Jekyll::Converters::Markdown)
      tmpl = (Liquid::Template.parse tmpl).render site.site_payload
      html = converter.convert(tmpl)
    end
  end
end
Liquid::Template.register_tag('markdown', Jekyll::MarkdownTag)
