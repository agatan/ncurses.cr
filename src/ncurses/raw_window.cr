require "./libncurses"

module NCurses
  module RawWindow
    private def check_error(r, msg)
      if r == LibNCurses::Result::ERR
        raise "ncurses failure: #{msg}"
      end
      r
    end

    def keypad(enable)
      check_error(LibNCurses.keypad(raw_win, enable), "keypad")
    end

    def nodelay(enable : Bool)
      check_error(LibNCurses.nodelay(raw_win, enable), "nodelay")
    end

    def notimeout(enable : Bool)
      check_error(LibNCurses.notimeout(raw_win, enable), "notimeout")
    end

    def touch
      check_error(LibNCurses.touchwin(raw_win), "touchwin")
    end

    def getch
      key = check_error(LibNCurses.wgetch(raw_win), "wgetch")
      KeyCode.from_value?(key) || key
    end

    def erase
      check_error(LibNCurses.werase(raw_win), "werase")
    end

    def curs_set(value : Int)
      check_error(LibNCurses.curs_set(value), "curs_set")
    end

    private def to_chtype(x : Char | Attribute | Int)
      case x
      when Char
        x.ord.to_u32
      when Attribute
        x.value.to_u32
      else
        x.to_u32
      end
    end

    private def addch(ch : LibNCurses::Chtype)
      check_error(LibNCurses.waddch(raw_win, ch), "waddch")
    end

    private def mvaddch(y, x, ch : LibNCurses::Chtype)
      check_error(LibNCurses.mvwaddch(raw_win, y, x, ch), "mvwaddch")
    end

    def addch(ch : Char)
      addch(to_chtype(ch))
    end

    def addch(ch : Char, attr : Attribute)
      addch(to_chtype(ch) | to_chtype(attr))
    end

    def mvaddch(ch : Char, y, x)
      mvaddch(y, x, to_chtype(ch))
    end

    def mvaddch(ch : Char, attr : Attribute, y, x)
      mvaddch(y, x, to_chtype(ch) | to_chtype(attr))
    end

    def bkgd(cpair : ColorPair)
      check_error(LibNCurses.wbkgd(raw_win, cpair.attr), "wbkgd")
    end

    def move(y, x)
      check_error(LibNCurses.wmove(raw_win, y, x), "wmove")
    end

    def addstr(s)
      addnstr(s, s.bytesize)
    end

    def addnstr(s, i : Int32)
      check_error(LibNCurses.waddnstr(raw_win, s.to_unsafe, i), "waddnstr")
    end

    def mvaddstr(s, y, x)
      check_error(LibNCurses.mvwaddnstr(raw_win, y, x, s, s.bytesize), "mvwaddnstr")
    end

    def border(left = 0, right = 0, top = 0, bottom = 0,
               top_left = 0, top_right = 0, bottom_left = 0, bottom_right = 0)
      check_error(
        LibNCurses.wborder(
          raw_win,
          to_chtype(left), to_chtype(right), to_chtype(top), to_chtype(bottom),
          to_chtype(top_left), to_chtype(top_right), to_chtype(bottom_left), to_chtype(bottom_right)
        ),
        "wborder"
      )
    end

    def box(v, h)
      border(v, v, h, h, 0, 0, 0, 0)
    end

    def hline(ch, n)
      check_error(LibNCurses.whline(raw_win, to_chtype(ch), n), "whline")
    end

    def mvhline(ch, n, y, x)
      check_error(LibNCurses.mvwhline(raw_win, y, x, to_chtype(ch), n), "mvwhline")
    end

    def vline(ch, n)
      check_error(LibNCurses.wvline(raw_win, to_chtype(ch), n), "wvline")
    end

    def mvvline(ch, n, y, x)
      check_error(LibNCurses.mvwvline(raw_win, y, x, to_chtype(ch), n), "mvwvline")
    end

    def attron(attr : Attribute)
      check_error(LibNCurses.wattron(raw_win, attr.value), "wattron")
    end

    def attron(attr : Attribute, &blk)
      check_error(LibNCurses.wattron(raw_win, attr.value), "wattron")
      begin
        yield
      ensure
        attroff(attr)
      end
    end

    def attroff(attr : Attribute)
      check_error(LibNCurses.wattroff(raw_win, attr.value), "wattron")
    end

    def attrset(attr : Attribute)
      check_error(LibNCurses.wattrset(raw_win, attr.value), "wattron")
    end

    def maxx
      check_error(LibNCurses.getmaxx(raw_win), "getmaxx")
    end

    def maxy
      check_error(LibNCurses.getmaxy(raw_win), "getmaxy")
    end

    def maxyx
      {maxy, maxx}
    end

    def resize(height, width)
      check_error(LibNCurses.wresize(raw_win, height, width), "wresize")
    end

    def mousemask(newmask : MouseMask, oldmask : MouseMask? = nil)
      mask = oldmask || MouseMask.new(0)
      check_error(LibNCurses.mousemask(newmask, pointerof(mask)), "mousemask")
    end

    def getmouse
      check_error(LibNCurses.getmouse(out event), "getmouse")
      event
    end

    def mouseinterval(interval : Int32)
      check_error(LibNCurses.mouseinterval(interval), "mouseinterval")
    end
  end
end
