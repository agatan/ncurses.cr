require "./libncurses"

module NCurses
  class Window
    def initialize(@win : LibNCurses::Window)
      @closed = false
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
      check_error(LibNCurses.wgetch(@win), "wgetch")
    end

    def erase
      check_error(LibNCurses.werase(@win), "werase")
    end

    def addch(ch : LibNCurses::Chtype)
      check_error(LibNCurses.waddch(@win, ch), "addch")
    end

    def addch(ch : Char)
      addch(ch.ord)
    end

    def addch(ch : Int32)
      addch(ch.to_u32)
    end

    def bkgd(cid)
      check_error(LibNCurses.wbkgd(@win, cid), "wbkgd")
    end
  end
end
