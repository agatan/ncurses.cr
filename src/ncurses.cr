require "./ncurses/*"

module NCurses
  extend self

  alias KeyCode = LibNCurses::KeyCode

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

end

NCurses.open do
  NCurses.cbreak
  NCurses.noecho
  NCurses.keypad(true)
  NCurses.notimeout(true)
  loop do
    x = NCurses.getch
    if x == 0x04 # CTRL_D
      break
    end
  end
end

