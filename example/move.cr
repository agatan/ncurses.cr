require "../src/ncurses"

NCurses.open do
  NCurses.cbreak
  NCurses.noecho
  NCurses.keypad(true)

  s = "Hello, world"
  h, w = NCurses.maxy, NCurses.maxx
  y = h / 2
  x = (w - s.size) / 2 # TODO(agatan): multibyte character

  NCurses.notimeout(true)

  loop do
    NCurses.erase
    NCurses.move(y, x)
    NCurses.addstr(s)
    NCurses.refresh

    key = NCurses.getch
    case key
    when 'q', NCurses::KeyCode::ESC
      break
    when NCurses::KeyCode::LEFT
      x -= 1
    when NCurses::KeyCode::RIGHT
      x += 1
    when NCurses::KeyCode::UP
      y -= 1
    when NCurses::KeyCode::DOWN
      y += 1
    end
  end
end
