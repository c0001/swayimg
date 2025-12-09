PREFIX := "$(HOME)/Temp/temp-install"
BUILD_PATH := build
clean:
	if [[ -e .git ]] ; then git clean -xfd . ; fi

bootstrap:
	meson setup                 \
		--auto-features=enabled \
		--prefix="$(PREFIX)"    \
		--werror                \
		-D compositor=enabled   \
		-D wayland=enabled      \
		-D drm=enabled          \
		-D man=true             \
		-D desktop=true         \
		-D bash=enabled         \
		-D zsh=enabled          \
		-D exif=enabled         \
		-D exr=auto             \
		-D gif=enabled          \
		-D heif=enabled         \
		-D jpeg=enabled         \
		-D jxl=enabled          \
		-D raw=enabled          \
		-D sixel=enabled        \
		-D svg=enabled          \
		-D webp=enabled         \
		"$(BUILD_PATH)"

compile:
	meson compile --clean -C "$(BUILD_PATH)" && \
	meson compile -C "$(BUILD_PATH)"

build: bootstrap compile

install:
	env DESKDIR="$(PREFIX)" meson install -C "$(BUILD_PATH)"
