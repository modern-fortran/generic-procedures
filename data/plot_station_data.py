#!/usr/bin/env python3

import argparse
parser = argparse.ArgumentParser()
parser.add_argument('filename', help='Data file to process')
args = parser.parse_args()

from datetime import datetime
import matplotlib.pyplot as plt
import numpy as np
import os

plt.rcParams.update({'font.size': 10})

filename = args.filename

time, temp, rh, wspd, clear = [], [], [], [], []

data = [line.strip() for line in open(filename).readlines()[1:]]
for line in data:
    line = line.split(',')
    time.append(datetime.strptime(line[1], '%Y-%m-%d %H:%M'))
    temp.append(float(line[4]) if line[4] != 'M' else np.nan)
    rh.append(float(line[6]) if line[6] != 'M' else np.nan)
    wspd.append(float(line[8]) if line[8] != 'M' else np.nan)
    clear.append(False if any([x in line[14:18] for x in ['SCT', 'BKN', 'OVC', 'VV']])\
        else np.nan if all([x == 'M' for x in line[14:18]])\
        else True)

fig = plt.figure(figsize=(8, 10))
ax1 = plt.subplot2grid((3, 1), (0, 0), colspan=1, rowspan=1)
ax2 = plt.subplot2grid((3, 1), (1, 0), colspan=1, rowspan=1)
ax3 = plt.subplot2grid((3, 1), (2, 0), colspan=1, rowspan=1)
ax1.plot(time, temp, 'k.', ms=1)
ax2.plot(time, rh, 'k.', ms=1)
ax3.plot(time, wspd, 'k.', ms=1)
ax1.set_ylabel('Temperature [F]')
ax2.set_ylabel('Relative humidity [%]')
ax3.set_ylabel('Wind speed [kts]')
ax1.set_title('MIA')
plt.tight_layout()
plt.savefig(os.path.basename(filename)[:-3] + 'png', dpi=300)
plt.savefig(os.path.basename(filename)[:-3] + 'svg')
plt.close(fig)
