{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_day04 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/tim/sciebo/Dokumente/git/aoc/2021/day04/.stack-work/install/x86_64-linux-nix/c4e9682402ae961fcb7e0f366c8542caa8a4af51948e20d166b479bac83e1687/8.10.4/bin"
libdir     = "/home/tim/sciebo/Dokumente/git/aoc/2021/day04/.stack-work/install/x86_64-linux-nix/c4e9682402ae961fcb7e0f366c8542caa8a4af51948e20d166b479bac83e1687/8.10.4/lib/x86_64-linux-ghc-8.10.4/day04-0.1.0.0-4wQws44K1ovDddRJfQ3waA-day04"
dynlibdir  = "/home/tim/sciebo/Dokumente/git/aoc/2021/day04/.stack-work/install/x86_64-linux-nix/c4e9682402ae961fcb7e0f366c8542caa8a4af51948e20d166b479bac83e1687/8.10.4/lib/x86_64-linux-ghc-8.10.4"
datadir    = "/home/tim/sciebo/Dokumente/git/aoc/2021/day04/.stack-work/install/x86_64-linux-nix/c4e9682402ae961fcb7e0f366c8542caa8a4af51948e20d166b479bac83e1687/8.10.4/share/x86_64-linux-ghc-8.10.4/day04-0.1.0.0"
libexecdir = "/home/tim/sciebo/Dokumente/git/aoc/2021/day04/.stack-work/install/x86_64-linux-nix/c4e9682402ae961fcb7e0f366c8542caa8a4af51948e20d166b479bac83e1687/8.10.4/libexec/x86_64-linux-ghc-8.10.4/day04-0.1.0.0"
sysconfdir = "/home/tim/sciebo/Dokumente/git/aoc/2021/day04/.stack-work/install/x86_64-linux-nix/c4e9682402ae961fcb7e0f366c8542caa8a4af51948e20d166b479bac83e1687/8.10.4/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "day04_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "day04_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "day04_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "day04_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "day04_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "day04_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
