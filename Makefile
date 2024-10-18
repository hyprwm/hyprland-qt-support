.PHONY: all
all: build
	cmake --build build

build:
	cmake -GNinja -B build -DCMAKE_BUILD_TYPE=RelWithDebInfo

.PHONY: dev
dev:
	CMAKE_EXPORT_COMPILE_COMMANDS=1 cmake -GNinja -B build -DCMAKE_BUILD_TYPE=Debug
	ln -sf build/compile_commands.json .

.PHONY: fmt
fmt:
	find src -type f \( -name "*.cpp" -o -name "*.hpp" \) -print0 | xargs -0 clang-format -i

.PHONY: lint
lint:
	find src -type f -name "*.cpp" -print0 | parallel -q0 --eta clang-tidy

.PHONY: clean
clean:
	rm -rf build
	rm -f compile_commands.json
