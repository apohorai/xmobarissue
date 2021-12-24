import           Xmobar
import           System.Environment

baseConfig :: Config
baseConfig = defaultConfig
  { font             =
    "xft:Source Code Pro:size=11:regular:antialias=true"<>
    ",FontAwesome:pixelsize=13"<>
    ",Symbols Nerd Font:pixelsize=12"
  , overrideRedirect = False
  , lowerOnStart     = True
  , bgColor          = "#00192A"
  , fgColor          = "#D8DEE9"
  , alpha            = 200
  , sepChar          = "%"
  , alignSep         = "}{"
  , iconRoot         = "~/.config/xmobar/"
  }

topBar :: Config
topBar = baseConfig
 { 

    commands = myCommands
  , position = OnScreen 0 (TopSize L 100 18)
  , template =
      "%UnsafeXMonadLog%" <>
      "}{" <>
      "%volume%" <>
      "%date%" <> 
      "%cpu%" <> 
      "%memory%" <> 
      "%batt0%" <>
      "<fn=2>%echo%</fn>"
  }

myCommands :: [Runnable]
myCommands =
  [ Run $ Cpu
    [ "--template"
    , "<ipat><total>%"
    , "--Low"
    , "55" 
    , "--High"
    , "77"
    , "--high"
    , foreground "#CD3C66"
    , "--ppad"
    , "3"
    , "--width"
    , "3"
    , "--maxtwidth"
    , "4"
    , "--"
    , "--load-icon-pattern"
    , "<icon=cpu_%%.xpm/>"
    ]
    10
  , Run $ Memory
    [ "--template"
    , "<usedipat><usedratio>%"
    , "--Low"
    , "55"
    , "--High"
    , "77"
    , "--high"
    , foreground "#BF616A"
    , "--ppad"
    , "3"
    , "--width"
    , "3"
    , "--maxtwidth"
    , "4"
    , "--"
    ]
    10
  , Run $ Date "%a %b %_d | %H:%M" "date" 10
  , Run UnsafeXMonadLog
  , Run $ BatteryN ["BAT0"]
         ["-t", "<acstatus>"
         , "-S", "Off", "-d", "0", "-m", "3"
         , "-L", "10", "-H", "90", "-p", "3"
         , "-W", "0"
         , "-f", "\xf244\xf243\xf243\xf243\xf242\xf242\xf242\xf241\xf241\xf240"
         , "--"
         , "-P"
         , "-a", "notify-send -u critical 'Battery running out!!!!!!'"
         , "-A", "5"
         , "-i", "<fn=1>\xf1e6</fn>"
         , "-O", "<fn=1>\xf1e6</fn>"
         , "-o", "<fn=1><leftbar></fn>"
         , "-H", "10", "-L", "7"
         ] 50 "batt0"
  , Run $ Com "sh" ["/home/apohorai/.config/xmobar/.scripts/getVolume.sh"] "volume" 10
  , Run $ Com "sh" ["/home/apohorai/.config/xmobar/.scripts/echo.sh"] "echo" 10
  ]


foreground :: String -> String
foreground =  (<> ",#2E3440:0")

main :: IO ()
main = do
    xmobar topBar
