require 'readline'
require './system'

system = Game::System.new
running = true;

puts [
  '',
  '+------------------+',
  '| Marketplace Game |',
  '+------------------+',
  '',
  ' Travel, buy, and sell things to make more and more.',
  ' Type \'help\' to see a list of commands.',
  '',
  ''
].join("\n")

while running
  line = Readline.readline(system.prompt, true)
  running = system.handle_input(line)
end
