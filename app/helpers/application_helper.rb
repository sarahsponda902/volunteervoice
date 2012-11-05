module ApplicationHelper


def breaking_word_wrap(text, *args)
   options = args.extract_options!
   unless args.blank?
     options[:line_width] = args[0] || 80
   end
   options.reverse_merge!(:line_width => 80)
   text = text.split(" ").collect do |word|
     word.length > options[:line_width] ? word.gsub(/(.{1,#{options[:line_width]}})/, "\\1 ") : word
   end * " "
   text.split("\n").collect do |line|
     line.length > options[:line_width] ? line.gsub(/(.{1,#{options[:line_width]}})(\s+|$)/, "\\1\n").strip : line
   end * "\n"
end

    
    def untextilized(textile)
      return Nokogiri::HTML.fragment(textile).text
    end
    
    def textilized(text)
      return RedCloth.new( ActionController::Base.helpers.sanitize( text ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    end



end
