module Main where
import Yesod
import Network.Wai.Handler.Warp (run)
import System.Environment
import Text.Blaze (preEscapedString)
import Text.Highlighting.Kate

mkYesod "()" [parseRoutes| / R GET |]

instance Yesod ()

getR = (\c -> defaultLayout $ setTitle "The Smallest Yesod App" >>
    [whamlet|
        <style>#{preEscapedString $ styleToCss pygments}
        <h3>I am the smallest yesod app!
        <p>Here is my source code:#{c}
        <a href="https://github.com/pbrisbin/thesmallestyesodapp.com">Make me smaller
    |]) =<< (liftIO $ fmap (formatHtmlBlock defaultFormatOpts {numberLines = True} . highlightAs "haskell") $ readFile "./site.hs")

main = getEnv "PORT" >>= ( \p -> run (read p) =<< toWaiApp () )
