{-# LANGUAGE QuasiQuotes, TypeFamilies, TemplateHaskell, MultiParamTypeClasses #-}
module Main where
import Yesod
import Network.Wai.Handler.Warp (run)
import Text.Blaze (preEscapedString)
import Text.Highlighting.Kate

mkYesod "()" [parseRoutes| / R GET |]

instance Yesod () where defaultLayout w = (\c -> hamletToRepHtml [hamlet|
    $doctype 5
    <html lang="en">
        <title>The Smallest Yesod App
        <style>#{preEscapedString $ styleToCss pygments}
        <h3>I am the smallest yesod app!
        <p>Here is my source code:^{pageBody c}
        <a href="https://gist.github.com/2322845">Make me smaller
    |]) =<< widgetToPageContent w

getR = (liftIO $ readFile "./site.hs") >>= \c -> defaultLayout . toWidget
     . formatHtmlBlock defaultFormatOpts { numberLines = True } $ highlightAs "haskell" c

main = run 3000 =<< toWaiApp ()
