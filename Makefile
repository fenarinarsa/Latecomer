# The best way to use this Makefile under Windows is to install
# the git SDK bash
# because it uses MINGW with all env variables correctly set

ACME = acme.exe -f apple -o
APPLECOMMANDER = /c/retrodev/bin/ac.jar
DISKNAME = latecomer.dsk
PRODOS_TEMPLATE = /c/retrodev/template_prodos.dsk

all:	loader.b player main $(DISKNAME)

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
	/c/jac/wudsn/Tools/EMU/AppleWin/Applewin.exe -d1 $(DISKNAME)

# copying to SD card for testing on real hardware, thanks to Floppy Emu
copy:
	cp $(DISKNAME) /e/
	
run:
	/c/jac/wudsn/Tools/EMU/AppleWin/Applewin.exe -d1 $(DISKNAME)

clean:	
	rm -f *.b

