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

    def getkey
      key = check_error(LibNCurses.wgetch(@win), "wgetch")
      if key > 0xff
        Key.new(key)
      else
        nbytes = NCurses.utf8_bytes(key)
        bytes = Slice(UInt8).new(nbytes)
        bytes[0] = key.to_u8
        (1...nbytes).each do |i|
          bytes[i] = check_error(LibNCurses.wgetch(@win), "wgetch").to_u8
        end
        Key.new(String.new(bytes).at(0))
      end
    end
  end
end
