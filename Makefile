.PHONY: g64 clean

CXXFLAGS:=-O2 -fPIC
CXXFLAGS+=-I/usr/include/SDL2 -Igmod-module-base/include -Ilibsm64/src

LDFLAGS:=--shared
LDFLAGS+=-Llibsm64/dist -lsm64 -lSDL2

g64: libsm64/dist/libsm64.so dist/bin/linux64/libsm64.so dist/garrysmod/lua/bin/gmcl_g64_linux64.dll

dist/bin/linux64/libsm64.so: libsm64/dist/libsm64.so
	mkdir -p $(dir $@)
	cp $< $@

libsm64/dist/libsm64.so:
	$(MAKE) -C libsm64 lib

dist/garrysmod/lua/bin/gmcl_g64_linux64.dll: build/g64/gamepad.o build/g64/utils.o build/g64/main.o
	mkdir -p $(dir $@)
	$(CXX) $(LDFLAGS) $^ -o $@

build/%.o: %.cpp
	mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	$(MAKE) -C libsm64 clean
	rm -rf build dist
