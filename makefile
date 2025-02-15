RM=rm
FORCE=-f
PYTHON=python3
CARTBLOCK=cartridge.bin
FLASHLOADER=flashloader.bin
ONBOARD_PREFIX=chars_
BASIC_SOURCE=allchars.bas

ifdef WIN
RM=del
FORCE=
PYTHON=python
endif


.PHONY: all
all: $(CARTBLOCK)	


.PHONY: clean
clean: 
	$(RM) $(FORCE) $(CARTBLOCK)
	$(RM) $(FORCE) $(FLASHLOADER)
	$(RM) $(FORCE) $(ONBOARD_PREFIX)*.bin


$(CARTBLOCK): flashloader.asm $(BASIC_SOURCE)
	64tass --nostart  -o $(FLASHLOADER) flashloader.asm
	$(PYTHON) pad_binary.py $(FLASHLOADER) $(BASIC_SOURCE) $(CARTBLOCK)
	$(PYTHON) split8k.py $(CARTBLOCK) $(ONBOARD_PREFIX)