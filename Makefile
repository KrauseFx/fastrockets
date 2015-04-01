CXXFLAGS=-Wall -O3 -g
OBJECTS=minimal-example.o
BINARIES=minimal-example
ALL_BINARIES="$(BINARIES)"

# Where our library resides. It is split between includes and the binary
# library in lib
RGB_INCDIR=rpi-rgb-led-matrix/include
RGB_LIBDIR=rpi-rgb-led-matrix/lib
RGB_LIBRARY_NAME=rgbmatrix
RGB_LIBRARY=$(RGB_LIBDIR)/lib$(RGB_LIBRARY_NAME).a
LDFLAGS+=-L$(RGB_LIBDIR) -l$(RGB_LIBRARY_NAME) -lrt -lm -lpthread

minimal-example : minimal-example.o $(RGB_LIBRARY)
	$(CXX) $(CXXFLAGS) minimal-example.o -o $@ $(LDFLAGS)

clean:
	rm -f $(OBJECTS) $(ALL_BINARIES)
	$(MAKE) -C lib clean
