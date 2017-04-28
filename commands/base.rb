require 'readline'

class Command
  def initialize(system = nil, game = nil)
    @system = system
    @game = game
  end

  def prompt_for(prompt, responses, clear_line = false)
    allowed_responses = ''

    if responses.size > 0
      allowed_responses = "[#{responses.join('|')}]"
    end

    input = Readline.readline("#{prompt} #{allowed_responses} > ", false)
    puts "\n" if clear_line
    input
  end

  def result(text, clear_line = false)
    text = "↳ #{text}"
    text += "\n\n" if clear_line
    puts text
  end
end
