require 'readline'

class Command
  def initialize(system, game)
    @system = system
    @game = game
  end

  def prompt_for(prompt, clear_line = false)
    input = Readline.readline("#{prompt} > ", false)
    puts "\n" if clear_line
    input
  end

  def result(text, clear_line = false)
    text = "↳ #{text}"
    text += "\n\n" if clear_line
    puts text
  end
end
