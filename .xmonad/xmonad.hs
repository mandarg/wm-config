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

myWorkspaces = ["code", "shell", "browser", "chat", "vm", "etc"]

myManageHook = composeAll
             [ className =? "Gimp" --> doFloat
             ]
main = do
     xmproc <- spawnPipe "/usr/bin/xmobar /home/mandar/.xmobarrc"
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
            [ ((0, 0x1008FF11), spawn "amixer set Master 2-"),
              ((0, 0x1008FF13), spawn "amixer set Master 2+")
            ]

