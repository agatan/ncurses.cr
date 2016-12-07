require "../src/ncurses"

NCurses.open do
  NCurses.cbreak
  NCurses.noecho
  NCurses.keypad(true)
  NCurses.start_color
  pair = NCurses::ColorPair.new(1).init(NCurses::Color::RED, NCurses::Color::BLACK)
  NCurses.bkgd(pair)

  NCurses.erase
  NCurses.move(x: 0, y: 1)
  NCurses.addstr(NCurses.longname)
  NCurses.move(x: 0, y: 2)
  NCurses.addstr(NCurses.curses_version)
  NCurses.move(y: 10, x: 20)
  NCurses.addstr("Hello, world!")
  NCurses.refresh

  NCurses.notimeout(true)
  NCurses.getch
end

