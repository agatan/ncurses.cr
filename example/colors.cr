require "../src/ncurses"

NCurses.open do
  NCurses.cbreak
  NCurses.noecho
  NCurses.start_color
  NCurses.keypad(true)

  NCurses.use_default_colors

  pairs = [] of NCurses::ColorPair
  NCurses.colors.each_with_index do |color, i|
    begin
      pairs << NCurses::ColorPair.new(i + 1).init(color, NCurses::Color::BLACK)
    rescue
      NCurses.addstr("color: #{color}, index: #{i}")
      break
    end
  end

  pairs.each do |p|
    NCurses.addch('*', p.attr)
  end

  NCurses.notimeout(true)
  NCurses.getch
end
