require "../src/ncurses"

NCurses.open do
  NCurses.cbreak
  NCurses.noecho
  NCurses.keypad(true)
  NCurses.start_color
  NCurses.init_pair(1, LibNCurses::Color::RED, LibNCurses::Color::BLUE)
  NCurses.bkgd(NCurses.color_pair(1))

  NCurses.erase
  NCurses.move(10, 20)
  NCurses.addstr("Hello, world!")
  NCurses.refresh

  NCurses.notimeout(true)
  NCurses.getch
end

