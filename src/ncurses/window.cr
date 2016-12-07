require "./libncurses"

module NCurses
  class Window
    def initialize(@win : LibNCurses::Window)
      @closed = false
    end

    def initialize(height, width, y, x)
      @win = LibNCurses.newwin(height, width, y, x)
      @closed = false
    end

    def self.open(height, width, y, x, &blk)
      win = new(height, width, y, x)
      begin
        yield win
      ensure
        win.close
      end
    end

    def to_unsafe
      @win
    end

    def finalize
      close
    end

    def close
      return if @closed
      LibNCurses.delwin(@win)
      @closed = true
    end

    private def check_error(r, msg)
      if r == LibNCurses::Result::ERR
        raise "ncurses failure: #{msg}"
      end
      r
    end

    def keypad(enable)
      check_error(LibNCurses.keypad(@win, enable), "keypad")
    end

    def notimeout(enable : Bool)
      check_error(LibNCurses.notimeout(@win, enable), "notimeout")
    end

    def getch
      key = check_error(LibNCurses.wgetch(@win), "wgetch")
      KeyCode.from_value?(key) || key
    end

    def erase
      check_error(LibNCurses.werase(@win), "werase")
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
      check_error(LibNCurses.waddch(@win, ch), "waddch")
    end

    private def mvaddch(y, x, ch : LibNCurses::Chtype)
      check_error(LibNCurses.mvwaddch(@win, y, x, ch), "mvwaddch")
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
      check_error(LibNCurses.wbkgd(@win, cpair.attr), "wbkgd")
    end

    def move(y, x)
      check_error(LibNCurses.wmove(@win, y, x), "wmove")
    end

    def addstr(s)
      check_error(LibNCurses.waddnstr(@win, s.to_unsafe, s.bytesize), "waddnstr")
    end

    def mvaddstr(s, y, x)
      check_error(LibNCurses.mvwaddnstr(@win, y, x, s, s.bytesize), "mvwaddnstr")
    end

    def border(left = 0, right = 0, top = 0, bottom = 0,
               top_left = 0, top_right = 0, bottom_left = 0, bottom_right = 0)
      check_error(
        LibNCurses.wborder(
          @win,
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
      check_error(LibNCurses.whline(@win, to_chtype(ch), n), "whline")
    end

    def mvhline(ch, n, y, x)
      check_error(LibNCurses.mvwhline(@win, y, x, to_chtype(ch), n), "mvwhline")
    end

    def vline(ch, n)
      check_error(LibNCurses.wvline(@win, to_chtype(ch), n), "wvline")
    end

    def mvvline(ch, n, y, x)
      check_error(LibNCurses.mvwvline(@win, y, x, to_chtype(ch), n), "mvwvline")
    end

    def refresh
      check_error(LibNCurses.wrefresh(@win), "wrefresh")
    end

    def attron(attr : Attribute)
      check_error(LibNCurses.wattron(@win, attr.value), "wattron")
    end

    def attron(attr : Attribute, &blk)
      check_error(LibNCurses.wattron(@win, attr.value), "wattron")
      begin
        yield
      ensure
        attroff(attr)
      end
    end

    def attroff(attr : Attribute)
      check_error(LibNCurses.wattroff(@win, attr.value), "wattron")
    end

    def attrset(attr : Attribute)
      check_error(LibNCurses.wattrset(@win, attr.value), "wattron")
    end

    def maxx
      check_error(LibNCurses.getmaxx(@win), "getmaxx")
    end

    def maxy
      check_error(LibNCurses.getmaxy(@win), "getmaxy")
    end

    def maxyx
      { maxy, maxx }
    end
  end
end
