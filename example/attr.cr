require "../src/ncurses"

NCurses.open do
  NCurses.cbreak
  NCurses.noecho
  NCurses.keypad(true)

  s = "Hello, world"
  h, w = NCurses.maxyx
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
  NCurses.mvaddch('N', red.attr, x: x, y: y)
  NCurses.addch('O', NCurses::Attribute::BLINK)
  NCurses.addch('R', NCurses::Attribute::BOLD)
  NCurses.attron(NCurses::Attribute::UNDERLINE)
  NCurses.addch('M')
  NCurses.attroff(NCurses::Attribute::UNDERLINE)
  NCurses.addstr("AL")

  y += 1
  NCurses.attron(red.attr) do
    NCurses.mvaddstr("RED STRING", x: x, y: y)
  end

  NCurses.refresh
  NCurses.notimeout(true)
  NCurses.getch
end
