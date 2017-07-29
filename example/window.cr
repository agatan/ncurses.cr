require "../src/ncurses"

NCurses.open do
  NCurses.cbreak
  NCurses.noecho
  NCurses.keypad(true)

  NCurses.box(v: '|', h: '=')
  NCurses.mvaddstr("I'm the stdscr. Press any key to quit.", x: 10, y: 5)

  NCurses::Window.open(x: 10, y: 5, height: 10, width: 20) do |win|
    win.border
    win.mvaddstr("Press any key!", x: 1, y: 1)
    win.mvaddstr("I'm a subwindow", x: 1, y: 2)
    win.mvaddstr("x: #{win.maxx}, y: #{win.maxy}", x: 1, y: 3)
    win.refresh
    win.notimeout(true)
    win.getch
  end

  NCurses::Pad.open(height: 10, width: 20) do |pad|
    pad.border
    pad.mvaddstr("I'm a pad", x: 6, y: 4)
    pad.refresh(0, 0, 1, 1, 11, 21)
    pad.notimeout(true)
    pad.getch
  end

  NCurses.notimeout(true)
  NCurses.getch
end
