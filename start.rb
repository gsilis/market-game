require 'readline'
require './system'

system = Game::System.new
running = true;

while running
  line = Readline.readline(system.prompt, true)
  running = system.handle_input(line)
end
