require "./ncurses/*"

module NCurses
  extend self

  alias KeyCode = LibNCurses::KeyCode
  alias MouseMask = LibNCurses::MouseMask

  @@stdscr : Window | Nil = nil

  def init
    @@stdscr = Window.new(LibNCurses.initscr)
  end

  def endwin
    return unless @@stdscr
    LibNCurses.endwin
    @@stdscr = nil
  end

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

  macro ncurses_bits(mask, shift)
    ({{mask}} << ({{shift}} + LibNCurses::ATTR_SHIFT))
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

  defwrapper raw, noraw, echo, noecho, cbreak, nocbreak, start_color, nl, nonl, clear, erase

  delegate curs_set, to: stdscr
  delegate keypad, to: stdscr
  delegate notimeout, to: stdscr
  delegate nodelay, to: stdscr
  delegate getch, to: stdscr
  delegate addch, to: stdscr
  delegate addch, to: stdscr
  delegate mvaddch, to: stdscr
  delegate mvaddch, to: stdscr
  delegate erase, to: stdscr
  delegate move, to: stdscr
  delegate addstr, to: stdscr
  delegate mvaddstr, to: stdscr
  delegate refresh, to: stdscr
  delegate maxx, to: stdscr
  delegate maxy, to: stdscr
  delegate maxyx, to: stdscr
  delegate attroff, to: stdscr
  delegate attrset, to: stdscr
  delegate border, to: stdscr
  delegate box, to: stdscr
  delegate hline, vline, to: stdscr
  delegate mvhline, mvvline, to: stdscr
  delegate attron, to: stdscr
  delegate bkgd, to: stdscr
  delegate mousemask, to: stdscr
  delegate getmouse, to: stdscr
  delegate mouseinterval, to: stdscr

  def longname
    String.new(LibNCurses.longname)
  end

  def curses_version
    String.new(LibNCurses.curses_version)
  end
end
