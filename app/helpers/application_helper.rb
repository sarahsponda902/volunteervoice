module ApplicationHelper

  ## For breaking up words that are too long and might mess with our page formatting
  ## Taken from mihserf, profile at http://apidock.com/users/mihserf
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



  ####### TEXTILE & NO-TEXTILE #######

  # for un-textilizing textile/html text
  # so that it can be edited without the html tags in a textarea box
  def untextilized(textile)
    return Nokogiri::HTML.fragment(textile).text
  end

  # for textilizing plain text from a textarea box
  # so that newlines and formatting are preserved
  def textilized(text)
    return RedCloth.new( ActionController::Base.helpers.sanitize( text ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
  end

end
