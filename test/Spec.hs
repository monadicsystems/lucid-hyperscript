{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE OverloadedStrings #-}

import Lucid
import Lucid.Base (Attribute)
import Lucid.Hyperscript

main :: IO ()
main = do
    print $ renderText ex1
    print $ renderText ex2
    print $ renderText ex3
    print $ renderText ex4

ex1 :: Monad m => HtmlT m ()
ex1 = button_ [[__|on click call alert('You clicked me!')|]] "Click me!"

ex2 :: Monad m => HtmlT m ()
ex2 = [_hs|
on mousedown
  halt the event -- prevent text selection...
  -- do other stuff...
end
|]

ex3 :: Monad m => HtmlT m ()
ex3 = [_hs|
behavior Removable(removeButton)
  on click from removeButton
    remove me
  end
end
|]

ex4 :: Monad m => HtmlT m ()
ex4 = input_
    [ type_ "text"
    , placeholder_ "Search Quotes..."
    , [__|
        on keyup
          if the event's key is 'Escape'
            set my value to ''
            trigger keyup
          else
            show <blockquote/> in #quotes when its textContent contains my value
      |]
    ]
