import os
import numpy as np
import matplotlib.pyplot as plt 

#from scipy.interpolate import interp1d

Tbe = 73 #Tbe has been calculated through formula explaind during lessons
fig = plt.gcf() #variable created to manage size and characteristics of figures
fig.set_size_inches(20, 10, forward=True) #25 e 35 prima


Energy_wo_dpm = 29.879

x_idle = list()
y1_idle = list()
y2_idle = list()

x_sleep = list()
y1_sleep = list()
y2_sleep = list()


#reading savings with only sleep transition
n = 0
i=0
with open('Energy_w_dpm/dpm_energy_sleep_w1.txt') as temp_f:   #for each line in the file that contains pair TIMEOUT, ENERGY W DPM
    datafile = temp_f.readlines()           #We copy the pair respectively in x and y
    for line in datafile:
        value_list = line.split(",")
        if ((n%200) == 0):                   #add a value every 10 to reduce overhead in the printed figure
            x_sleep.append(value_list[0])         #save in x value of timeout 
            y1_sleep.append(value_list[-1][:-8])       #save in y1 the value of the energy consumed with DPM
            #print(y1_sleep[i])
            y2_sleep.append((100 - ((100*(float(value_list[-1]))/float(Energy_wo_dpm))))) #energy saved in percentage
            #print(y2_sleep[i])
            i += 1
        n = n+1

#reading savings with only idle transition
j = 0
i = 0
with open('Energy_w_dpm/dpm_energy_idle_w1.txt') as temp_f2:   #for each line in the file that contains pair TIMEOUT, ENERGY W DPM
    datafile2 = temp_f2.readlines()           #We copy the pair respectively in x and y
    for line2 in datafile2:
        value_list2 = line2.split(",")
        if ((j%200) == 0):                   #add a value every 10 to reduce overhead in the printed figure
            x_idle.append(value_list2[0])         #save in x value of timeout 
            y1_idle.append(value_list2[-1][:-8])       #save in y1 the value of the energy consumed with DPM
            y2_idle.append((100 - ((100*(float(value_list2[-1]))/float(Energy_wo_dpm))))) #energy saved in percentage
            #print(y2_idle[i])
            i += 1
        j = j+1



x_sleep = np.array(x_sleep)     #transform them from list to array (maybe useless)
y1_sleep = np.array(y1_sleep)
y2_sleep = np.array(y2_sleep)

x_idle = np.array(x_idle)
y1_idle = np.array(y1_idle)
y2_idle = np.array(y2_idle)

plt.plot(x_sleep, y2_sleep, label = "sleep_policy")
plt.plot(x_idle, y2_idle, label = "idle_policy")

plt.xlabel('timeout (ms)')
plt.ylabel('Energy saved (%)')

plt.title('Energy saved sleep vs idle')

plt.legend()


#plt.show()
plt.savefig('printed_graphs/w1_difference.png')