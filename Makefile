
USERNAME := de7ec7ed

BINARIESDIR := binaries
OBJECTSDIR := objects

.PHONY : all
.PHONY : build
.PHONY : includes
.PHONY : clean

all:
	@$(MAKE) -s check
	@mkdir -p $(OBJECTSDIR)
	@mkdir -p $(BINARIESDIR)
	@$(MAKE) -s --directory libraries all
	@$(MAKE) -s --directory kernel all
	@$(MAKE) -s --directory modules all
	#@$(MAKE) -s --directory doxygen all
	
build:
	@$(MAKE) -s check
	@mkdir -p $(OBJECTSDIR)
	@mkdir -p $(BINARIESDIR)
	@$(MAKE) -s --directory libraries build
	@$(MAKE) -s --directory kernel build
	@$(MAKE) -s --directory modules build
	#@$(MAKE) -s --directory doxygen build

check:
	@echo "checking toolchain"
	@if test "$(PREFIX)" = "" ; then echo "A toolchain has not been specified. Define PREFIX, for example \"make PREFIX=arm-linux-gnueabi-\""; exit 2; fi
	@echo "checking toolchain"
	@$(MAKE) -s --directory libraries check
	@$(MAKE) -s --directory kernel check
	@$(MAKE) -s --directory modules check
	@echo "toolchain resolved"

includes:
	@$(MAKE) -s --directory libraries includes
	@$(MAKE) -s --directory kernel includes
	@$(MAKE) -s --directory modules includes

clean:
	@$(MAKE) -s --directory libraries clean
	@$(MAKE) -s --directory kernel clean
	@$(MAKE) -s --directory modules clean
	#@$(MAKE) -s --directory doxygen clean
	@rm -rf $(OBJECTSDIR)
	@rm -rf $(BINARIESDIR)

submodules:
	git submodule update --init

