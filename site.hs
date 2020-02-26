module Main where
import Data.FileEmbed
import Data.ByteString.Char8 (unpack)
import Yesod
import Network.Wai.Handler.Warp (run)
import System.Environment
import Text.Highlighting.Kate

data App = App
mkYesod "App" [parseRoutes| / R GET |]
instance Yesod App
getR = (\c -> defaultLayout $ setTitle "The Smallest Yesod App" >>
    [whamlet|
        <style>#{preEscapedToMarkup $ styleToCss pygments}
        <h3>I am The Smallest Yesod App!
        <p>Here is my source code:#{c}
        <a href="https://github.com/pbrisbin/thesmallestyesodapp.com">Make me smaller
    |]) $ formatHtmlBlock defaultFormatOpts {numberLines = True} $ highlightAs "haskell" $ unpack $(embedFile "./site.hs")
main = getEnv "PORT" >>= \p -> toWaiApp App >>= run (read p)
