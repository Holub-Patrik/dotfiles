# PidgyDots
This is a project implementing a quickshell shell for my linux setup.
And hyprland dots.

Main parts:
- Hyprland
- Quickshell
- SDDM


## Main Design Considerations
- OLED design first (0xFFFFFF), IPS will make black into gray anyways
- Minimalism at it's core. I don't need distractions.
- Performance first -> Minimal polling. Components which might need to poll should be opt-in/in a popup menu
- Transparency is king.
- Shadow always before blur.
- Least applications as possible
- No faff for r/unixporn
- Small is good

## Considerations explanations

### OLED
This is fucking annoying about the entire ricing community. Your material design and shit. Fuck off.
All this design that's supposed to be easy on the eyes is fucking bullshit.
Gray is not easy on the eyes when it is an OLED screen. If the screen is not an OLED, then the black
will become a gray. But if the design is IPS first, then it only directly hurts OLED.
No light > Low light

### Minimalism
Minimalism is something which means completely different things for different people.
What minimalism means here is this:
Niceties and pretty animations are fine when they are fast and active, only when you want them to be.
Example: Cava. I want to fucking tear out the throat of anyone who puts cava on their bar.
Install it and run it in a terminal if you want. If you really want it in the bar, make it in a way
it can be hidden. For work, I need to know which workspaces are open, time and that's about it.
Maybe it can show the current program, if it is implemented well.

### Performance
This is about as straight forward as possible.
Hassle in programing to have a more performant and less resource hungry setup
trumps easy scriptability. Scripting is usefull, but it shouldn't be overused.

### Shadow before blur
This is something more important for me. I am using black wallpaper with only as few elements as possible.
(I still do like a pretty picture, I just want it to be black first and clean)

Thus a shadow is all I need. Blur is ineffective in most of the wallpaper, so it only eats up processing power
without doing anything.

### Least applications / No faff
This setup is to be efficient when things need to be done, not when showing how cool it is
on r/unixporn. This means that theme switching, wallpaper switching and such is just bloat.
The things are nice when setting up the desktop, but after that, they are more or less useless.
Thus I choose to configure it once with more hassle, rather than introduce more apps into the
dotfiles

This also includes things like wallust. I don't need wallust. This is a cool thing when
someone switches wallpapers often. I want one style and make it good enough.
If I want to change it, I can change it in a config file.

### Small is good
My eyes work and they work good. I don't need 20px margins around windows,
I don't need rounding that eats half my window. I don't need fonts/bars sizes
which take up 10% of my screen. I can comfortably read 12px font on a 1440p screen.
This is a bit similar to the minimalism part. I want my screen to be used for what I want to see,
not the rice. I want the main dish, not the side dish.


## Rules for agents
### Work rules
This is project where working in git branches is very benefitial
Thus what it'd like to see is a robust start, and then merge in new features.
My current idea for this workflow is to use separate files in a branch when
developing. Then when the branch gets merged, depending on the size of the file
the file can be coppied into the main file, or kept as an import

### Expectations
This is a visual project so files will be saved, formatters will be run
and the user will very often give you feedback on the visuals.
So when you are using search and replace tools, use them on very granuraly
as they will most likely not work, if you try to replace big blocks of code.
Similarly, update the files often, as they may be changed in between prompts.
Do not assume the file looks the same as it did last time.

## Other notes
Other notes will be expanded when they come
