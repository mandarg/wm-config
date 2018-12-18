import XMonad
import XMonad.Operations
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Actions.CycleWS
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.WindowNavigation
import XMonad.Actions.WindowGo
import System.IO
import Graphics.X11.ExtraTypes.XF86

myWorkspaces = ["code", "shell", "browser", "chat", "vm", "etc"]

myManageHook = composeAll
             [ className =? "Gimp" --> doFloat
             ]
main = do
     xmproc <- spawnPipe "/usr/bin/xmobar /home/mandarg/.xmobarrc"
     xmonad $ withUrgencyHook NoUrgencyHook defaultConfig
            { manageHook = manageDocks <+> myManageHook
                                       <+> manageHook defaultConfig
            , layoutHook = avoidStruts $ windowNavigation(layoutHook defaultConfig)
            , startupHook = setWMName "LG3D"
            , logHook = dynamicLogWithPP xmobarPP
                      { ppOutput = hPutStrLn xmproc
                      , ppTitle = xmobarColor "green" "" . shorten 50
                      , ppUrgent = xmobarColor "yellow" "red"
                      }
            , modMask = mod4Mask
            , terminal = "gnome-terminal --hide-menubar"
            , workspaces = myWorkspaces
            } `additionalKeys`
            [ ((0, xF86XK_AudioMute), spawn "amixer -D pulse set Master 1+ toggle"),
              ((0, xF86XK_AudioLowerVolume), spawn "amixer -q sset Master 5%- unmute"),
              ((0, xF86XK_AudioRaiseVolume), spawn "amixer -q sset Master 5%+ unmute"),
              ((0, xF86XK_MonBrightnessUp), spawn "lux -a 10%"),
              ((0, xF86XK_MonBrightnessDown), spawn "lux -s 10%")
            ]
