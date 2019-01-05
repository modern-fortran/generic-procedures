#!/usr/bin/env python3

import argparse
parser = argparse.ArgumentParser()
parser.add_argument('filename', help='Data file to process')
args = parser.parse_args()

filename = args.filename

data = [line.strip() for line in open(filename).readlines()[1:]]
for line in data:
    line = line.split(',')
    temp = float(line[4]) if line[4] != 'M' else 'NaN'
    rh = float(line[6]) if line[6] != 'M' else 'NaN'
    wspd = int(float(line[8])) if line[8] != 'M' else 'NaN'
    clear = False if any([x in line[14:18] for x in ['SCT', 'BKN', 'OVC', 'VV']])\
        else 'NaN' if all([x == 'M' for x in line[14:18]])\
        else True
    print(','.join(map(str, [temp, rh, wspd, clear])))
