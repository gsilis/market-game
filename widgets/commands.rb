module Game
  class Commands
    def self.find_command_in(list, possible_command)
      found_command = nil
      base_name = nil

      list.each do |command|
        if command.include? possible_command
          found_command = command[0]
        end
      end

      Object.const_get(found_command.capitalize + 'Command') if found_command
    end
  end
end
