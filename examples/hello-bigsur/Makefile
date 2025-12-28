SRC = hello.go
TARGET = hello-bigsur
CGO_ENABLED = 1
CGO_CFLAGS ?=
CGO_LDFLAGS ?=
GOFLAGS ?= -tags=sectrust_compat

$(TARGET): $(SRC)
	CGO_CFLAGS=$(CGO_CFLAGS) \
	CGO_LDFLAGS=$(CGO_LDFLAGS) \
	GOFLAGS=$(GOFLAGS) \
		go build -o $(TARGET) $(SRC)

all: $(TARGET)

clean:
	rm -f hello-bigsur

.PHONY: all clean