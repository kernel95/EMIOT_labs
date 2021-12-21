import os
import numpy as np
import matplotlib.pyplot as plt 

fig = plt.gcf() #variable created to manage size and characteristics of figures
fig.set_size_inches(35, 25, forward=True)

file = open("results_w1.txt","w+")
savings = list() #list that contains value of energy consumed with different timeout values

for i in range (100):
    stream = os.popen('./dpm_simulator -t ' + str(i) + ' -psm example/psm.txt -wl workloads/workload_1.txt')
    output = stream.read() #output of the command saved in this variable
    file.write("simulator with timeout t=%d \r\n\n" % i)
    file.write(output)
    file.write("\n\n")

file.close()

file_savings = open("dpm_energy_w1.txt","w+")

#file_savings.write("timeout value,  Energy w DPM \n")

with open('results_w1.txt') as temp_f:
    datafile = temp_f.readlines()
    i = 0
    for line in datafile:                                        #for each line in the file
        if "Energy w DPM" in line:                               #that contains this string
            value_list = line.split()                            #split by space
            dpm_energy = value_list[-1]                          #save inside dpm energy the last value in the last string produced by the simulator
            value_energy = dpm_energy[:-1]                       #remove the character J
            file_savings.write(str(i) + ',' + str(value_energy)) #save the pair values TIMEOUT and associated ENERGY W DPM
            file_savings.write("\n") 
            savings.append(float(value_energy))                  #Save value of energy consumed for each timeout values in a list
            i += 1

min_value = min(savings)                                         #find the smallest amount of energy consumed
min_pos = savings.index(min(savings))                            #by searching its position we know also the value given to the associated timeout

print("Best DPM  timeout=%d, Energy w DPM= %f" % (min_pos , min_value))

file_best = open("best_dpm_w1.txt","w")

file_best.write("Best DPM for the associated timeout value\n Timeout: "+str(min_pos)+", Energy consumed: " +str(min_value))

file_savings.close()
file_best.close()

x = list()
y = list()

with open('dpm_energy_w1.txt') as temp_f:   #for each line in the file that contains pair TIMEOUT, ENERGY W DPM
    datafile = temp_f.readlines()           #We copy the pair respectively in x and y
    for line in datafile:
        value_list = line.split(",")
        x.append(value_list[0])
        y.append(value_list[-1])



plt.plot(x, y)
plt.title('Power consumption associated to timeout value')
plt.xlabel('timeout')
plt.ylabel('Energy consumed')

plt.savefig('dpm_W1.png')

#plt.show()