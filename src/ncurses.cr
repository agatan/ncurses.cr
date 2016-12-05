require "./ncurses/*"

module NCurses
  extend self

  @@stdscr : Window | Nil = nil

  def open
    @@stdscr = Window.new(LibNCurses.initscr)
    begin
      yield
    ensure
      LibNCurses.endwin
    end
  end

  def stdscr
    scr = @@stdscr
    raise "ncurses not yet initialized" unless scr
    scr
  end

  macro defwrapper(*names)
    {% for name in names %}
    def {{name}}
      result = LibNCurses.{{name}}
      if result == LibNCurses::Result::ERR
        raise "ncurses failure: #{ {{name.stringify}} }"
      end
      result
    end
    {% end %}
  end

  defwrapper raw, noraw, echo, noecho, cbreak, nocbreak

  def keypad(enable)
    stdscr.keypad(enable)
  end

  def notimeout(enable)
    stdscr.notimeout(enable)
  end

  def getch
    stdscr.getch
  end

  def getkey
    stdscr.getkey
  end

end

keys = Array(NCurses::Key).new

NCurses.open do
  NCurses.cbreak
  NCurses.noecho
  NCurses.keypad(true)
  NCurses.notimeout(true)
  loop do
    x = NCurses.getkey
    if x.key == NCurses::KeyCode::EOF || x.key == NCurses::KeyCode::ESC # Ctrl-D
      break
    end
    keys << x
  end
end

pp keys
