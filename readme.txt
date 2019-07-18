Fenarinarsa presents

##############################################
                                              
                  LATECOMER                   
                   (final)                    
                                              
##############################################

An Apple II demo released at REVISION 2019

Party version 20/04/2019
Final version 17/07/2019
   
music: Big Alec/Delta Force
code: Fenarinarsa
      Grouik/French Touch
gfx: Made/bomb
     Raccoon

Web      https://fenarinarsa.com/latecomer
Twitter  @fenarinarsa
Mastodon @fenarinarsa@shelter.moe

Huge thanks to GROUIK/FRENCH TOUCH for releasing the source code for his demos under GPL
Huge thanks to BIG ALEC for allowing me to use his wonderful tune from the Punish Your Machine demo (Atari ST)

This is my first real 8-bits release.
I bought an Apple IIc in 2018 to dump my old floppy disks with the BASIC programs I did when I was a kid.
Then I started exploring the 6502 and found the French Touch source archive... and voila, a demo!

I know it works only under certain conditions (the most "annoying" being the 65C02),
that's because I started to write it on my Apple IIc.
Most of times I can't watch demos either :p

I hope you enjoy it anyway.


Source code released under GPLv3 available at https://fenarinarsa.com/latecomer


System requirements:
65C02 CPU
128k RAM
Mockingboard 2 or Mockingboard 4c

Apple IIc PAL
Apple IIc NTSC (untested on real hardware, will generate tearing)
Apple IIe 65C02 PAL
Apple IIe 65C02 NTSC (untested on real hardware, will generate tearing)

It really looks better on a PAL machine because the first part locks on a 50Hz sync.
Also the end graphic looks better on a Le Chat Mauve RGB card because I asked
Made/bomb to use this card's color palette (where for instance GREY1 != GREY2)

Best setups to watch this demo:
Apple IIe enhanced, PAL, Mockingboard, Le Chat Mauve RGB card
Apple IIc, PAL, Mockingboard 4c, Le Chat Mauve RGB adapter

Party > Final changelog:
- Better compatibility, now should work on NTSC IIc
- Mockingboard slot detection
- Many bugfixes
- Buffer overflows corrected, should fix some hardware crashes
- Added sinewaves debug mode (see below)
- Fixed missing characters in the scrolltext
- Improved greetings part
- Improved rotozoom with new graphics
- Improved endscreen in DLGR
- The demo loops after a few seconds

Sinewaves debug mode:
When the first dots appear, press any key. The demo will not continue.
You enter the debug mode where you can change the eight parameters
with the following keys:
AZERTYUI (+)
QSDFGHJK (-)
Space => reset parameters to zero
Return => switch to fullscreen
