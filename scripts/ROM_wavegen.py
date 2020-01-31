import numpy as np
import matplotlib.pyplot as plt

N=2**(16-1)
M=41*2
h=np.linspace(0,N-1,M).astype(int)
bh = []
if False:
    plt.plot(h)
    plt.show()
wave = open('sawtooth.txt','w')
print("(",end="",file=wave)
for v in h[:-1]:
    print("\"{:016b}\",".format(int(v)), end=" ", file=wave)
print("\"{:016b}\"".format(int(h[-1])), end=");", file=wave)
wave.close()
