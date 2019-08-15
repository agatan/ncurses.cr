require "../src/ncurses"

LibNCurses.setlocale(0, "")

NCurses.open do
  NCurses.cbreak
  NCurses.noecho
  NCurses.keypad(true)

  s = "あいう"
  h, w = NCurses.maxyx
  y = h / 2
  x = (w - s.size) / 2

  NCurses.notimeout(true)

  loop do
    NCurses.erase
    NCurses.move(y, x)
    NCurses.addstr(s)
    NCurses.refresh

    key = NCurses.getch
    break if key == 'q'.ord
    y += 1
    y = 0 if y >= h
  end
end
