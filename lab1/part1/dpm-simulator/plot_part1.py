import numpy as np
import matplotlib.pyplot as plt
fig = plt.gcf()
fig.set_size_inches(35, 25, forward=True)

x = list()
y = list()

with open('dpm_energy_w2.txt') as temp_f:
    datafile = temp_f.readlines()
    for line in datafile:
        value_list = line.split(",")
        #print(value_list)
        #print(value_list[0])
        #print("\n")
        #print(value_list[-1])
        x.append(value_list[0])
        y.append(value_list[-1])



plt.plot(x, y)
plt.title('Power consumption associated to timeout value')
plt.xlabel('timeout')
plt.ylabel('Energy consumed')

plt.savefig('dpm_W2.png')

#plt.show()
