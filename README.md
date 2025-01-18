# Screen Scribe

MacOS macro to take the text from a screenshot and then paste it anywhere, this ONLY works on MacOS

![Demo GIF](demo.gif)

All of this is powered by the Hammerspoon automation tool, the lua script replicates the screenshot function and then feeds the image into the Tesseract OCR model to extract the text into a txt file, then the text is put into the pasteboard.

Setup

Installation List
-homebrew
-hammerspoon
-tesseract

I highly reccomend using brew to install tesseract and hammerspoon as it's just one command, I did also make a bash script to help with that but I lowkey just wanted to be able to say I wrote a bash script so if your computer gets nuked its not my fault (I originally had a while loop in there and almost crashed my pc don't ask why).

