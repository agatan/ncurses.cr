@[Link("ncursesw")]
lib LibNCurses
  type Window = Void*
  type Screen = Void*

  struct MEvent
    id : LibC::Short
    x, y, z : LibC::Int
    bstate : MouseMask
  end

  alias Chtype = LibC::UInt
  alias AttrT = Chtype

  ATTR_SHIFT = 8_u32

  @[Flags]
  enum Attribute : AttrT
    NORMAL     = 1_u32 - 1_u32
    ATTRIBUTES = 1_u32 << (0_u32 + ATTR_SHIFT)
    CHARTEXT   = (1_u32 << (0_u32 + ATTR_SHIFT)) - 1_u32
    COLOR      = ((1_u32 << 8_u32) - 1_u32) << (0_u32 + ATTR_SHIFT)
    STANDOUT   = 1_u32 << (8_u32 + ATTR_SHIFT)
    UNDERLINE  = 1_u32 << (9_u32 + ATTR_SHIFT)
    REVERSE    = 1_u32 << (10_u32 + ATTR_SHIFT)
    BLINK      = 1_u32 << (11_u32 + ATTR_SHIFT)
    DIM        = 1_u32 << (12_u32 + ATTR_SHIFT)
    BOLD       = 1_u32 << (13_u32 + ATTR_SHIFT)
    ALTCHARSET = 1_u32 << (14_u32 + ATTR_SHIFT)
    INVIS      = 1_u32 << (15_u32 + ATTR_SHIFT)
    PROTECT    = 1_u32 << (16_u32 + ATTR_SHIFT)
    HORIZONTAL = 1_u32 << (17_u32 + ATTR_SHIFT)
    LEFT       = 1_u32 << (18_u32 + ATTR_SHIFT)
    LOW        = 1_u32 << (19_u32 + ATTR_SHIFT)
    RIGHT      = 1_u32 << (20_u32 + ATTR_SHIFT)
    TOP        = 1_u32 << (21_u32 + ATTR_SHIFT)
    VERTICAL   = 1_u32 << (22_u32 + ATTR_SHIFT)
    ITALIC     = 1_u32 << (23_u32 + ATTR_SHIFT)
  end

  NCURSES_BUTTON_RELEASED = 0o01_u32
  NCURSES_BUTTON_PRESSED  = 0o02_u32
  NCURSES_BUTTON_CLICKED  = 0o04_u32
  NCURSES_DOUBLE_CLICKED  = 0o10_u32
  NCURSES_TRIPLE_CLICKED  = 0o20_u32
  NCURSES_RESERVED_EVENT  = 0o40_u32

  @[Flags]
  enum MouseMask : LibC::UInt
    BUTTON1_RELEASED       = NCURSES_BUTTON_RELEASED << (0_u32 * 5_u32)
    BUTTON1_PRESSED        = NCURSES_BUTTON_PRESSED << (0_u32 * 5_u32)
    BUTTON1_CLICKED        = NCURSES_BUTTON_CLICKED << (0_u32 * 5_u32)
    BUTTON1_DOUBLE_CLICKED = NCURSES_DOUBLE_CLICKED << (0_u32 * 5_u32)
    BUTTON1_TRIPLE_CLICKED = NCURSES_TRIPLE_CLICKED << (0_u32 * 5_u32)

    BUTTON2_RELEASED       = NCURSES_BUTTON_RELEASED << (1_u32 * 5_u32)
    BUTTON2_PRESSED        = NCURSES_BUTTON_PRESSED << (1_u32 * 5_u32)
    BUTTON2_CLICKED        = NCURSES_BUTTON_CLICKED << (1_u32 * 5_u32)
    BUTTON2_DOUBLE_CLICKED = NCURSES_DOUBLE_CLICKED << (1_u32 * 5_u32)
    BUTTON2_TRIPLE_CLICKED = NCURSES_TRIPLE_CLICKED << (1_u32 * 5_u32)

    BUTTON3_RELEASED       = NCURSES_BUTTON_RELEASED << (2_u32 * 5_u32)
    BUTTON3_PRESSED        = NCURSES_BUTTON_PRESSED << (2_u32 * 5_u32)
    BUTTON3_CLICKED        = NCURSES_BUTTON_CLICKED << (2_u32 * 5_u32)
    BUTTON3_DOUBLE_CLICKED = NCURSES_DOUBLE_CLICKED << (2_u32 * 5_u32)
    BUTTON3_TRIPLE_CLICKED = NCURSES_TRIPLE_CLICKED << (2_u32 * 5_u32)

    BUTTON4_RELEASED       = NCURSES_BUTTON_RELEASED << (3_u32 * 5_u32)
    BUTTON4_PRESSED        = NCURSES_BUTTON_PRESSED << (3_u32 * 5_u32)
    BUTTON4_CLICKED        = NCURSES_BUTTON_CLICKED << (3_u32 * 5_u32)
    BUTTON4_DOUBLE_CLICKED = NCURSES_DOUBLE_CLICKED << (3_u32 * 5_u32)
    BUTTON4_TRIPLE_CLICKED = NCURSES_TRIPLE_CLICKED << (3_u32 * 5_u32)

    BUTTON5_RELEASED       = NCURSES_BUTTON_RELEASED << (4_u32 * 5_u32)
    BUTTON5_PRESSED        = NCURSES_BUTTON_PRESSED << (4_u32 * 5_u32)
    BUTTON5_CLICKED        = NCURSES_BUTTON_CLICKED << (4_u32 * 5_u32)
    BUTTON5_DOUBLE_CLICKED = NCURSES_DOUBLE_CLICKED << (4_u32 * 5_u32)
    BUTTON5_TRIPLE_CLICKED = NCURSES_TRIPLE_CLICKED << (4_u32 * 5_u32)

    BUTTON_CTRL           = 0o01_u32 << (5_u32 * 5_u32)
    BUTTON_SHIFT          = 0o02_u32 << (5_u32 * 5_u32)
    BUTTON_ALT            = 0o04_u32 << (5_u32 * 5_u32)
    REPORT_MOUSE_POSITION = 0o10_u32 << (5_u32 * 5_u32)
    ALL_MOUSE_EVENTS      = REPORT_MOUSE_POSITION - 1_u32
  end

  enum Color : Chtype
    BLACK   = 0
    RED     = 1
    GREEN   = 2
    YELLOW  = 3
    BLUE    = 4
    MAGENTA = 5
    CYAN    = 6
    WHITE   = 7
  end

  enum Result : LibC::Int
    OK  =  0
    ERR = -1
  end

  enum KeyCode : LibC::Int
    ESC       =    27
    RETURN    =    10
    CODE_YES  = 0o400
    MIN       = 0o401
    BREAK     = 0o401
    SRESET    = 0o530
    RESET     = 0o531
    DOWN      = 0o402
    UP        = 0o403
    LEFT      = 0o404
    RIGHT     = 0o405
    HOME      = 0o406
    BACKSPACE = 0o407
    F0        = 0o410
    F1        = 0o411
    F2        = 0o412
    F3        = 0o413
    F4        = 0o414
    F5        = 0o415
    F6        = 0o416
    F7        = 0o417
    F8        = 0o420
    F9        = 0o421
    F10       = 0o422
    F11       = 0o423
    F12       = 0o424
    DL        = 0o510
    IL        = 0o511
    DC        = 0o512
    IC        = 0o513
    EIC       = 0o514
    CLEAR     = 0o515
    EOS       = 0o516
    EOL       = 0o517
    SF        = 0o520
    SR        = 0o521
    NPAGE     = 0o522
    PPAGE     = 0o523
    STAB      = 0o524
    CTAB      = 0o525
    CATAB     = 0o526
    ENTER     = 0o527
    PRINT     = 0o532
    LL        = 0o533
    A1        = 0o534
    A3        = 0o535
    B2        = 0o536
    C1        = 0o537
    C3        = 0o540
    BTAB      = 0o541
    BEG       = 0o542
    CANCEL    = 0o543
    CLOSE     = 0o544
    COMMAND   = 0o545
    COPY      = 0o546
    CREATE    = 0o547
    END       = 0o550
    EXIT      = 0o551
    FIND      = 0o552
    HELP      = 0o553
    MARK      = 0o554
    MESSAGE   = 0o555
    MOVE      = 0o556
    NEXT      = 0o557
    OPEN      = 0o560
    OPTIONS   = 0o561
    PREVIOUS  = 0o562
    REDO      = 0o563
    REFERENCE = 0o564
    REFRESH   = 0o565
    REPLACE   = 0o566
    RESTART   = 0o567
    RESUME    = 0o570
    SAVE      = 0o571
    SBEG      = 0o572
    SCANCEL   = 0o573
    SCOMMAND  = 0o574
    SCOPY     = 0o575
    SCREATE   = 0o576
    SDC       = 0o577
    SDL       = 0o600
    SELECT    = 0o601
    SEND      = 0o602
    SEOL      = 0o603
    SEXIT     = 0o604
    SFIND     = 0o605
    SHELP     = 0o606
    SHOME     = 0o607
    SIC       = 0o610
    SLEFT     = 0o611
    SMESSAGE  = 0o612
    SMOVE     = 0o613
    SNEXT     = 0o614
    SOPTIONS  = 0o615
    SPREVIOUS = 0o616
    SPRINT    = 0o617
    SREDO     = 0o620
    SREPLACE  = 0o621
    SRIGHT    = 0o622
    SRSUME    = 0o623
    SSAVE     = 0o624
    SSUSPEND  = 0o625
    SUNDO     = 0o626
    SUSPEND   = 0o627
    UNDO      = 0o630
    MOUSE     = 0o631
    RESIZE    = 0o632
    EVENT     = 0o633

    MAX = 0o777
  end

  $stdscr : Window

  $colors = COLORS : LibC::Int
  $color_pairs = COLOR_PAIRS : LibC::Int

  fun initscr : Window
  fun endwin : Result
  fun raw : Result
  fun noraw : Result
  fun echo : Result
  fun noecho : Result
  fun cbreak : Result
  fun nocbreak : Result
  fun nodelay(w : Window, flag : Bool) : Result
  fun keypad(w : Window, flag : Bool) : Result
  fun nl : Result
  fun nonl : Result
  fun clear : Result
  fun erase : Result

  # Color
  fun start_color : Result
  fun init_pair(id : LibC::Short, fg : LibC::Short, bg : LibC::Short) : Result
  fun wbkgd(w : Window, color_id : Chtype) : Result

  # Input
  fun notimeout(w : Window, bf : Bool) : Result
  fun wgetch(w : Window) : LibC::Int

  # Output
  fun werase(w : Window) : Result
  fun wrefresh(w : Window) : Result
  fun waddch(w : Window, ch : Chtype) : Result
  fun waddnstr(w : Window, s : Pointer(UInt8), n : LibC::Int) : Result
  fun whline(w : Window, ch : Chtype, n : LibC::Int) : Result
  fun wvline(w : Window, ch : Chtype, n : LibC::Int) : Result

  # Window
  fun newwin(height : LibC::Int, width : LibC::Int, y : LibC::Int, x : LibC::Int) : Window
  fun wborder(w : Window, ls : Chtype, rs : Chtype, ts : Chtype, bs : Chtype,
              tl : Chtype, tr : Chtype, bl : Chtype, br : Chtype) : Result
  fun touchwin(w : Window) : Result
  fun subwin(parent : Window, height : LibC::Int, width : LibC::Int, y : LibC::Int, x : LibC::Int) : Window
  fun derwin(parent : Window, height : LibC::Int, width : LibC::Int, y : LibC::Int, x : LibC::Int) : Window

  # Pad
  fun newpad(height : LibC::Int, width : LibC::Int) : Window
  fun prefresh(w : Window, pminrow : LibC::Int, pmincol : LibC::Int,
               sminrow : LibC::Int, smincol : LibC::Int,
               smaxrow : LibC::Int, smaxcol : LibC::Int) : Result

  # Cursor
  fun curs_set(i : LibC::Int) : Result
  fun wmove(w : Window, y : LibC::Int, x : LibC::Int) : Result

  # mv prefix
  fun mvwaddch(w : Window, y : LibC::Int, x : LibC::Int, ch : Chtype) : Result
  fun mvwaddnstr(w : Window, y : LibC::Int, x : LibC::Int, s : Pointer(UInt8), n : LibC::Int) : Result
  fun mvwhline(w : Window, y : LibC::Int, x : LibC::Int, ch : Chtype, n : LibC::Int) : Result
  fun mvwvline(w : Window, y : LibC::Int, x : LibC::Int, ch : Chtype, n : LibC::Int) : Result

  # Size
  fun getmaxx(w : Window) : LibC::Int
  fun getmaxy(w : Window) : LibC::Int
  fun wresize(w : Window, height : LibC::Int, width : LibC::Int) : Result

  fun delwin(w : Window)

  # Attribute
  fun wattron(w : Window, attr : LibC::Int) : Result
  fun wattroff(w : Window, attr : LibC::Int) : Result
  fun wattrset(w : Window, attr : LibC::Int) : Result
  fun use_default_colors : Result

  # Mouse
  fun has_mouse : Bool
  fun getmouse(e : MEvent*) : LibC::Int
  fun mousemask(newmask : MouseMask, oldmask : MouseMask*) : MouseMask
  fun mouseinterval(interval : LibC::Int) : LibC::Int

  # misc
  fun longname : Pointer(LibC::Char)
  fun curses_version : Pointer(LibC::Char)

  # for multibyte char...
  fun setlocale(category : LibC::Int, locale : Pointer(LibC::Char))
end
