CC = gcc
CFLAGS = -Wall -Wextra -Werror -std=c11

BUILD_DIR = build
SRC_DIR = src
SRC = $(wildcard $(SRC_DIR)/*.c)
OBJ = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(SRC))
TARGET = $(BUILD_DIR)/graph

default: purge format analyze all run clean | $(BUILD_DIR)
all: $(TARGET) | $(BUILD_DIR)

$(TARGET): $(OBJ) | $(BUILD_DIR)
	$(CC) $(CFLAGS) -o $@ $^ -lm

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

leaks: all | $(BUILD_DIR)
	leaks -atExit -- $(BUILD_DIR)/graph

run: all | $(BUILD_DIR)
	$(TARGET)

purge:
	rm -f $(BUILD_DIR)/graph $(BUILD_DIR)/*.o

clean:
	rm -f $(BUILD_DIR)/*.o

format:
	find . -name "*.c" -o -name "*.h" | xargs clang-format -i
	find . -name "*.c" -o -name "*.h" | xargs clang-format -n

analyze:
	find . -name "*.c" -o -name "*.h" | xargs cppcheck --enable=all --suppress=missingIncludeSystem

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

.PHONY: purge default all leaks run clean format analyze

