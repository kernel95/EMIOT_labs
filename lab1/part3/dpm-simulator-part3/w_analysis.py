import numpy as np
import matplotlib.pyplot as plt 


#fig = plt.gcf() #variable created to manage size and characteristics of figures
#fig.set_size_inches(30, 10, forward=True) #25 e 35 prima


start = 0
end = 0
old_end = 0

x = list() #active period
y = list() #idle period


n = 0
with open('workloads/workload_2.txt') as temp_f:   #for each line in the file that contains pair TIMEOUT, ENERGY W DPM
#with open('example/wl.txt') as temp_f:
    datafile = temp_f.readlines()           #We copy the pair respectively in x and y
    for line in datafile:
        value_list = line.split()

        start = int(value_list[0])
        end = int(value_list[1])
        
        if(n == 0):
            x.append(int(value_list[0]) - 1)
        else:
            x.append(int(value_list[0])- old_end)

        y.append(end - start)
        old_end = end

        #print(x[n], y[n])
    
        n = n+1

#x = np.array(x)
#y = np.array(y)

plt.plot(x, y, 'ro')
plt.title('L-curve')
plt.xlabel('Active period')
plt.ylabel('Idle period')

plt.savefig('workload_analysis/w2_curve.png')