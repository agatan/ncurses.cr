require "../src/ncurses"

NCurses.open do
  NCurses.cbreak
  NCurses.noecho
  NCurses.keypad(true)
  NCurses.start_color
  pair = NCurses::ColorPair.new(1).init(NCurses::Color::RED, NCurses::Color::BLACK)
  NCurses.bkgd(pair)

  NCurses.erase
  NCurses.addstr(NCurses.longname)
  NCurses.move(10, 20)
  NCurses.addstr("Hello, world!")
  NCurses.refresh

  NCurses.notimeout(true)
  NCurses.getch
end

