require 'readline'

class Command
  def initialize(system = nil, game = nil)
    @system = system
    @game = game
  end

  def run(parts = nil)
    true
  end

  def print(line)
    puts "    #{line}"
  end

  def print_result(text, clear_line = false)
    text = "↳ #{text}"
    text += "\n\n" if clear_line
    print text
  end

  def print_lines(lines, clear_line = false)
    lines.each do |line|
      print line.to_s + "\n"
    end

    print "\n" if clear_line
  end

  def print_title(text, clear_line = false, padding = 60)
    print_lines ['', text, '-' * padding], clear_line
  end

  def print_table(lines, clear_line = false)
    spacer = '-' * lines.inject(0) do |max_length, part|
      max_length = part.size if part.size > max_length
      max_length
    end

    combined_lines = []

    lines.each do |line|
      combined_lines << line
      combined_lines << spacer
    end

    print_lines combined_lines, clear_line
  end

  def prompt_for(prompt, responses, clear_line = false)
    allowed_responses = ''

    if responses.size > 0
      allowed_responses = "[#{responses.join('|')}]"
    end

    input = Readline.readline("#{prompt} #{allowed_responses} > ", false)
    print "\n" if clear_line
    input
  end

  def format_line(columns)
    formatted = columns.map do |config|
      text = config[:text]
      align = config[:align] || :left
      padding = config[:padding]

      spacing = ' ' * (padding - text.size)

      if align == :right
        "#{spacing}#{text}"
      else
        "#{text}#{spacing}"
      end
    end.join('')
  end
end
