module ApplicationHelper

  ## For breaking up words that are too long and might mess with our page formatting
  ## Taken from mihserf, profile at http://apidock.com/users/mihserf
  def breaking_word_wrap(text, *args)
    options = args.extract_options!
    options[:line_width] = args[0] || 80 unless args.blank?
    options.reverse_merge!(:line_width => 80)
    text = text.split(" ").collect do |word|
      word.length > options[:line_width] ? word.gsub(/(.{1,#{options[:line_width]}})/, "\\1 ") : word
    end * " "
    text.split("\n").collect do |line|
      line.length > options[:line_width] ? line.gsub(/(.{1,#{options[:line_width]}})(\s+|$)/, "\\1\n").strip : line
    end * "\n"
  end
  

end
