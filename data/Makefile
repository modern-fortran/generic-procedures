.PHONY: download process clean

all: download process

download:
	./get_station_data.sh

process:
	./process_station_data.sh

clean:
	$(RM) raw/*.txt processed/*.csv
