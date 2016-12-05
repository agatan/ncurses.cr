require "./libncurses"

module NCurses
  enum KeyCode : Int32
    CTRL_A = 0x01
    CTRL_B = 0x02
    CTRL_C = 0x03
    CTRL_D = 0x04
    CTRL_E = 0x05
    CTRL_F = 0x06
    CTRL_G = 0x07
    CTRL_H = 0x08
    CTRL_I = 0x09
    CTRL_J = 0x0a
    CTRL_K = 0x0b
    CTRL_L = 0x0c
    CTRL_M = 0x0d
    CTRL_N = 0x0e
    CTRL_O = 0x0f
    CTRL_P = 0x10
    CTRL_Q = 0x11
    CTRL_R = 0x12
    CTRL_S = 0x13
    CTRL_T = 0x14
    CTRL_U = 0x15
    CTRL_V = 0x16
    CTRL_W = 0x17
    CTRL_X = 0x18
    CTRL_Y = 0x19
    CTRL_Z = 0x1a

    TAB = CTRL_I
    EOF = CTRL_D
    ESC = 0x01b

    # Copy from libncurses.cs
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

  record Key, key : KeyCode, ch : Char | Nil do
    def initialize(key : LibC::Int)
      @key = KeyCode.new(key)
    end

    def initialize(key : Char)
      @key = KeyCode.new(key.ord)
      @ch = key
    end
  end

  protected def self.utf8_bytes(c)
    case
    when c <= 0x7f
      1
    when 0xc1 <= c && c <= 0xdf
      2
    when 0xe0 <= c && c <= 0xef
      3
    when 0xf0 <= c && c <= 0xf4
      4
    else
      0
    end
  end

end
