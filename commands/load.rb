class LoadCommand < Command
  def run(parts = nil)
    filename = parts[0]

    if filename.nil?
      print_files
    elsif load_file(filename)
      print_result("Loaded game.", true)
    else
      print_result("Could not load file. Try running 'load' without a filename to see all files.", true)
    end

    true
  end

  private
  def load_file(filename)
    if filename.match(/^\d+$/)
      filename = files[filename.to_i - 1]
    end

    begin
      contents = File.read("./saves/#{filename}")
      data = Marshal.load contents
      options = {
        wallet: data[:wallet].to_i,
        account: data[:account].to_i,
        location: data[:location],
        interest_rate: data[:interest_rate].to_f,
        inventory: data[:inventory],
        cycles: data[:cycles].to_i,
        space: data[:space].to_i,
      }

      @system.game = Game::Game.new(options)
      true
    rescue
      false
    end
  end

  def print_files
    list = files.each_with_index.map do |name, index|
      "#{index + 1} - #{name}"
    end

    if list.size > 0
      print_lines list, true
    else
      print_result 'There are no save files.', true
    end
  end

  def files
    @list = @list || Dir.entries('./saves').reject do |name|
      name == '.' || name == '..'
    end
  end
end
