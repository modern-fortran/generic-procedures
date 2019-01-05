# stock-prices Makefile

FC = gfortran
OBJS = mod_arrays.o mod_average.o mod_io.o mod_weather_data.o

all: weather_average

.SUFFIXES: .f90 .o

# general rule
.f90.o:
	$(FC) -c $<

# programs
weather_average: weather_average.f90 $(OBJS)
	$(FC) $< $(OBJS) -o $@

# modules
mod_arrays.o: mod_arrays.f90
mod_average.o: mod_average.f90
mod_io.o: mod_io.f90
mod_weather_data.o: mod_weather_data.f90 mod_io.o

.PHONY:
clean:
	$(RM) *.o *.mod weather_average
