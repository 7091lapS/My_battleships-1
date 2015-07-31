module UserInput

  def request_cell
    puts "Please enter the co-ordinates for your next attack:"
    puts "(co-ordinates should be entered in the form x,y "
    puts " where x & y are numerical digits between 0 - 9)"
    gets.chomp
  end

  def coordinates1
    return [ [ [0,0], :horizontal]]#,
            #  [ [0,2], :horizontal],
            #  [ [0,4], :horizontal],
            #  [ [0,6], :horizontal],
            #  [ [0,8], :horizontal] ]
  end

end
