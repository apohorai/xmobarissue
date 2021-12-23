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
    "%thisIsTheIssue%" 
  }

myCommands :: [Runnable]
myCommands =
  [
    Run UnsafeXMonadLog
  , Run $ Com "uname" ["-s","-r"] "thisIsTheIssue" 36000
  ]

foreground :: String -> String
foreground =  (<> ",#ffffff:0")

main :: IO ()
main = do
    xmobar topBar
