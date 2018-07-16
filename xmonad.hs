import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.WindowBringer
import XMonad.Layout.LimitWindows
import XMonad.Layout.Minimize
import XMonad.Layout.BoringWindows as B
import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import qualified XMonad.StackSet as W

import System.IO
import System.Process
import Control.Monad
import System.Exit
import qualified Data.Map as M

-- The entry point for XMonad
main :: IO ()
main =  do
  systemSetup
  xmonad conf

-- My custom XMonad settings
conf = def
  -- Appearance
  { borderWidth = 2
  , normalBorderColor = "#000000"
  , focusedBorderColor = "#880000"

  , terminal = "xterm"

  -- Mouse clicking (not moving) sets focus, but doesn't click the window
  , focusFollowsMouse = False
  , clickJustFocuses = True

  -- mod = super
  , modMask = mod4Mask

  , keys = bindings

  -- Standard workspaces for keys 1 - 0, plus a workspace to keep the
  -- hidden buffers (hide with mod+d)
  , workspaces = map show [1..10] ++ ["hidden"]

  -- Custom layout
  , layoutHook         = myLayout
  }


-- Run general system setup
-- catchIO stops any errors crashing the whole winodw manager
systemSetup :: IO ()
systemSetup = catchIO $ do
  callProcess "startup.sh" []

lockScreen :: X ()
lockScreen = spawn "i3random.sh"

-- Key bindings. Add, modify or remove key bindings here.
bindings conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    -- launch dmenu
    , ((modm,               xK_r     ), spawn "dmenu_run")
    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)
     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)
    -- Move focus to the next window
    , ((modm,               xK_Tab   ), B.focusDown)
    -- Move focus to the next window
    , ((modm,               xK_j     ), B.focusDown)
    -- Move focus to the previous window
    , ((modm,               xK_k     ), B.focusUp  )
    -- Move focus to the master window
    , ((modm,               xK_m     ), B.focusMaster  )
    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)
    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)
    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)
    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    -- Lock the screen
    , ((modm .|. shiftMask, xK_l     ), lockScreen)
    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))

    , ((modm, xK_b ), swapBring)
    , ((modm, xK_g ), gotoMenu)

    --, ((modm, xK_d), withFocused minimizeWindow)
    , ((modm, xK_d), windows $ W.shift "hidden")
    ]
    ++
    -- mod-[0..9], Switch to workspace N
    -- mod-shift-[0..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_0 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- mod-{w,e}, Switch to physical/Xinerama screens 1, 2
    -- mod-shift-{w,e}, Move client to screen 1, 2
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

swapBring =
--  bringMenu
--  --minimizeWindow f
--  withFocused $ \f' -> do
--    if f /= f' then windows $ W.shiftWin "hidden" f else return ()

  withWindowSet $ \w -> case (W.peek w) of
    Just f -> do
      bringMenu
      withFocused $ \f' -> do
        if f /= f' 
        then windows $ W.shiftWin "hidden" f 
        else return ()
    Nothing -> bringMenu

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = smartBorders $ boringWindows $ minimize 
  (Grid ||| limitWindows 3 vert ||| limitWindows 1 Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio
     vert    = Mirror $ Tall 0 delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 5/100

------------------------------------------------------------------------

help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
