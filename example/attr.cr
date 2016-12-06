require "../src/ncurses"

NCurses.open do
  NCurses.cbreak
  NCurses.noecho
  NCurses.keypad(true)

  s = "Hello, world"
  h, w = NCurses.getmaxyx
  y = h / 2
  x = (w - s.size) / 2 # TODO(agatan): multibyte character

  NCurses.move(y, x)
  NCurses.attron(NCurses::Attribute::BOLD) do
    NCurses.addstr("BOLD")
  end

  y += 1
  NCurses.move(y, x)
  NCurses.start_color
  red = NCurses::ColorPair.new(2).init(NCurses::Color::RED, NCurses::Color::BLACK)
  NCurses.attron(NCurses::Attribute::BOLD | red.attr) do
    NCurses.addstr("BOLD")
  end

  y += 1
  NCurses.move(y, x)
  NCurses.addch('N', red.attr)
  NCurses.addch('O', NCurses::Attribute::BLINK)
  NCurses.addch('R', NCurses::Attribute::BOLD)
  NCurses.addch('M')
  NCurses.addstr("AL")

  NCurses.refresh
  NCurses.notimeout(true)
  NCurses.getch
end

