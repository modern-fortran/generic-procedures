# generic-procedures Makefile

.PHONY: all clean

all: weather_average

weather_average: src/*.f90
	$(MAKE) --directory=src $@
	cp src/$@ .

clean:
	$(MAKE) --directory=src $@
	$(RM) weather_average
