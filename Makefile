# The best way to use this Makefile under Windows is to install
# the git SDK bash
# because it uses MINGW with all env variables correctly set

ACME = acme.exe -f apple -o
ACMEPLAIN = acme.exe -f plain -o
DISKNAME = latecomer.dsk
DISKNAME_TRACK = latecomer_trackload.dsk
PRODOS_TEMPLATE = assets/template_prodos.dsk
APPLECOMMANDER = /c/retrodev/bin/ac.jar
DIRECTWRITE = python /c/retrodev/bin/dw.py # http://fr3nch.t0uch.free.fr/
EMULATOR = /c/retrodev/bin/AppleWin/Applewin.exe -rgb-card-type feline

all: prodos trackload

prodos:	loader.b player main $(DISKNAME)

trackload: $(DISKNAME_TRACK)

main: main.b

player: player.b player2.b
	
player.b: player.a
	$(ACME) player.b player.a

player2.b: player2.a
	$(ACME) player2.b player2.a

main.b: main.a dotwaves.a starfield.a scrolltext.a tools.a tables.a roto.a mult16.a dotwaves_debug.a
	$(ACME) main.b main.a

loader.b: loader.a
	$(ACME) loader.b loader.a

$(DISKNAME): main.b player.b player2.b HELLO.bas PARTY.bas SOFA.bas DATA_copper.fym loader.b font7.bin
	cp $(PRODOS_TEMPLATE) $(DISKNAME)
	java -jar $(APPLECOMMANDER) -bas $(DISKNAME) STARTUP < HELLO.bas
	java -jar $(APPLECOMMANDER) -bas $(DISKNAME) PARTY < PARTY.bas
	java -jar $(APPLECOMMANDER) -bas $(DISKNAME) SOFA < SOFA.bas
	java -jar $(APPLECOMMANDER) -p $(DISKNAME) MUSIC BIN 0x3000 < DATA_copper.fym
	java -jar $(APPLECOMMANDER) -dos $(DISKNAME) PLAYER BIN 0x1800 < player.b
	java -jar $(APPLECOMMANDER) -dos $(DISKNAME) PLAYER2 BIN 0x1800 < player2.b
	java -jar $(APPLECOMMANDER) -dos $(DISKNAME) LOADER BIN 0x1000 < loader.b
	java -jar $(APPLECOMMANDER) -p $(DISKNAME) FONT BIN 0x2000 < font7.bin
	java -jar $(APPLECOMMANDER) -dos $(DISKNAME) MAIN BIN 0x6000 < main.b
#	$(EMULATOR) -d1 $(DISKNAME)

boot.b: boot.a
	$(ACMEPLAIN) boot.b boot.a

fload.b: boot.a
	$(ACMEPLAIN) fload.b fload.a

player2_plain.b: player2.a
#select player.a for stereo or player2.a for mono
	$(ACMEPLAIN) player2_plain.b player.a

main_plain.b: main.a
	$(ACMEPLAIN) main_plain.b main.a

$(DISKNAME_TRACK): boot.b fload.b player2_plain.b main_plain.b font7.bin DATA_copper.fym
# boot T0 S0
	$(DIRECTWRITE) $(DISKNAME_TRACK) boot.b 0 0 + p
# fload T0 S2
	$(DIRECTWRITE) $(DISKNAME_TRACK) fload.b 0 2 + p
# font7.bin (5) T1 S0-4 > $ 2000
	$(DIRECTWRITE) $(DISKNAME_TRACK) font7.bin 1 0 + D
# player2_plain.b (4) T1 S5-9 > $1800
	$(DIRECTWRITE) $(DISKNAME_TRACK) player2_plain.b 1 5 + D
# DATA_copper.fym (49) T2 S0 - T5 > $3000
	$(DIRECTWRITE) $(DISKNAME_TRACK) DATA_copper.fym 2 0 + D
# main_plain.b (42) T6 S0 > $6000
	$(DIRECTWRITE) $(DISKNAME_TRACK) main_plain.b 6 0 + D
	$(EMULATOR) -d1 $(DISKNAME_TRACK)

# copying to SD card for testing on real hardware, thanks to Floppy Emu
copy:
	cp $(DISKNAME) /e/
	cp $(DISKNAME_TRACK) /e/
	
run:
	$(EMULATOR) -d1 $(DISKNAME_TRACK)

clean:	
	rm *.b

