require "../src/ncurses"

NCurses.open do
  NCurses.cbreak
  NCurses.noecho
  NCurses.keypad(true)

  s = "Click around!"

  NCurses.mousemask(NCurses::MouseMask::ALL_MOUSE_EVENTS | NCurses::MouseMask::REPORT_MOUSE_POSITION)
  NCurses.notimeout(true)

  loop do
    NCurses.erase
    NCurses.move(y: 1, x: 2)
    NCurses.addstr(s)
    NCurses.refresh

    case key = NCurses.getch
    when NCurses::KeyCode::MOUSE
      event = NCurses.getmouse
      s = "x: #{event.x}, y: #{event.y}, z: #{event.z}, #{event.bstate}"
    end
  end
end
