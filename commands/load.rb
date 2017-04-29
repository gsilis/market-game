class LoadCommand < Command
  def run(parts = nil)
    filename = parts[0]

    if filename.nil?
      print_files
    elsif load_file(filename)
      result("Loaded game.", true)
    else
      result("Could not load file. Try running 'load' without a filename to see all files.", true)
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
      wallet = data[:wallet].to_i
      account = data[:account].to_i
      location = data[:location]
      inventory = data[:inventory]

      @system.game = Game::Game.new(filename, wallet, account, inventory, location)
      true
    rescue
      false
    end
  end

  def print_files
    list = files.each_with_index.map do |name, index|
      "#{index + 1} - #{name}"
    end

    list.push('There are no save files') if list.size <= 0

    print_lines list, true
  end

  def files
    @list = @list || Dir.entries('./saves').reject do |name|
      name == '.' || name == '..'
    end
  end
end