
# DEBUG_BUILD ?= 0
# EXTRA_CXXFLAGS ?=
# EXTRA_LDFLAGS ?=
# BIND_LEVELDB ?= 0
# BIND_ROCKSDB ?= 0


#----------------------------------------------------------

# ifeq ($(DEBUG_BUILD), 1)
# 	CXXFLAGS += -g
# else
# 	CXXFLAGS += -O2
# 	CPPFLAGS += -DNDEBUG
# endif

# ifeq ($(BIND_LEVELDB), 1)
# 	LDFLAGS += -lleveldb
# 	SOURCES += $(wildcard leveldb/*.cc)
# endif

# ifeq ($(BIND_ROCKSDB), 1)
# 	LDFLAGS += -lrocksdb
# 	SOURCES += $(wildcard rocksdb/*.cc)
# endif



# CXXFLAGS += -std=c++17 -Wall -pthread $(EXTRA_CXXFLAGS) -I./
# LDFLAGS += $(EXTRA_LDFLAGS) -lpthread
# SOURCES += $(wildcard core/*.cc)
# OBJECTS += $(SOURCES:.cc=.o)
# DEPS += $(SOURCES:.cc=.d)
# EXEC = ycsb


CC=g++
CFLAGS=-std=c++11 -g -Wall -pthread -I./
LDFLAGS= -lpthread -ltbb -lhiredis
SUBDIRS=core db redis
SUBSRCS=$(wildcard core/*.cc) $(wildcard db/*.cc)
OBJECTS=$(SUBSRCS:.cc=.o)
EXEC=ycsbc

all: $(SUBDIRS) $(EXEC)

$(SUBDIRS):
	$(MAKE) -C $@

$(EXEC): $(wildcard *.cc) $(OBJECTS)
	$(CC) $(CFLAGS) $^ $(LDFLAGS) -o $@

clean:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir $@; \
	done
	$(RM) $(EXEC)

.PHONY: $(SUBDIRS) $(EXEC)

