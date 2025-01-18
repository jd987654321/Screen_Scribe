# Screen Scribe

MacOS macro to take the text from a screenshot and then paste it anywhere, this ONLY works on MacOS

![Demo GIF](demo.gif)

All of this is powered by the Hammerspoon automation tool, the lua script replicates the screenshot function and then feeds the image into the Tesseract OCR model to extract the text into a txt file, then the text is put into the pasteboard.

## Setup

I did write a script to help with setup but I mainly just wanted to be able to say I wrote a bash script, I would reccomend installing homebrew first, it's real nice :D.

If you did want to unleash a **deadly** virus onto your pc
```
git clone https://github.com/jd987654321/Screen_Scribe
cd Screen_Scribe
chmod +x setup.sh
./setup.sh
```

If you don't.... Here are the steps to manually do everything 
1. You can install homebrew from [homebrew website](https://brew.sh)
2. then just run `brew install hammerspoon tesseract`
3. open the hammerspoon.app, make sure to allow it the privileges it's asking for or else it won't work
4. run `mkdir ~/.hammerspoon ~/.hammerspoon/Spoons ~/.hammerspoon/Screen_Scribe ~/.hammerspoon/Screen_Scribe/hs_images
        touch ~/.hammerspoon/init.lua`
5. copy the code from the init.lua here to the init.lua in `~/.hammerspoon` directory   
