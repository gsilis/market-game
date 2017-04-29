class SaveCommand < Command
  def run(parts = nil)
    data = Marshal.dump @game.to_json

    if File.write("./saves/#{@game.filename}", data) > 0
      print_result("Saved game to #{@game.filename}", true)
    else
      print_result('Could not save the game', true)
    end

    true
  end
end
