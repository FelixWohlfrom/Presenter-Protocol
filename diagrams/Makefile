
# Generates pngs from puml files

# The puml files to convert
SRC_FILES := $(wildcard *.puml)
OBJ_FILES := $(patsubst %.puml,%.png,$(SRC_FILES))

# Will convert all files
all: $(OBJ_FILES)

# Convert a single file
%.png: %.puml
	plantuml $< -output gen -tpng

# Cleanup generated files
clean:
	rm -rf gen/*.png
