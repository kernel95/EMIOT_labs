import os
import numpy as np
import matplotlib.pyplot as plt 

#from scipy.interpolate import interp1d

fig = plt.gcf() #variable created to manage size and characteristics of figures
fig.set_size_inches(35, 25, forward=True)

file = open("simulator_results/results_w2.txt","w+")
savings = list() #list that contains value of energy consumed with different timeout values
percentage_saved = list() #list of values of percentage of energy saved

for i in range (500):
    stream = os.popen('./dpm_simulator -t ' + str(i) + ' -psm example/psm.txt -wl workloads/workload_2.txt')
    output = stream.read() #output of the command saved in this variable
    file.write("simulator with timeout t=%d \r\n\n" % i)
    file.write(output)
    file.write("\n\n")

file.close()

file_savings = open("Energy_w_dpm/dpm_energy_w3.txt","w+")

#file_savings.write("timeout value,  Energy w DPM \n")

with open('simulator_results/results_w2.txt') as temp_f:
    datafile = temp_f.readlines()
    i = 0
    for line in datafile:                                        #for each line in the file
        if "Energy w DPM" in line:                               #that contains this string
            value_list = line.split()                            #split by space
            dpm_energy = value_list[-1]                          #save inside dpm energy the last value in the last string produced by the simulator
            if i == 0 :
                temp_en = value_list[5]                          #save the amount of energy consumed witouth dpm
                temp_en2 = temp_en[:-1]
                Energy_wo_dpm = temp_en2[:-1]

            value_energy = dpm_energy[:-1]                       #remove the character J
            file_savings.write(str(i) + ',' + str(value_energy)) #save the pair values TIMEOUT and associated ENERGY W DPM
            file_savings.write("\n")
            savings.append(float(value_energy))                  #Save value of energy consumed for each timeout values in a list
            i += 1

print (Energy_wo_dpm)

min_value = min(savings)                                         #find the smallest amount of energy consumed
min_pos = savings.index(min(savings))                            #by searching its position we know also the value given to the associated timeout

print("Best DPM  timeout=%d, Energy w DPM= %f" % (min_pos , min_value))

file_best = open("best_result/best_dpm_w2.txt","w")

file_best.write("Best DPM for the associated timeout value\n Timeout: "+str(min_pos)+", Energy consumed: " +str(min_value))

file_savings.close()
file_best.close()

x = list()
y1 = list()
y2 = list()

n = 0
with open('Energy_w_dpm/dpm_energy_w2.txt') as temp_f:   #for each line in the file that contains pair TIMEOUT, ENERGY W DPM
    datafile = temp_f.readlines()           #We copy the pair respectively in x and y
    for line in datafile:
        value_list = line.split(",")
        if ((n%10) == 0):                   #add a value every 10 to reduce overhead in the printed figure
            x.append(value_list[0])         #save in x value of timeout 
            y1.append(value_list[-1])       #save in y1 the value of the energy consumed with DPM
            y2.append((100 - ((100*(float(value_list[-1]))/float(Energy_wo_dpm))))) #energy saved in percentage
        n = n+1


x = np.array(x)     #transform them from list to array (maybe useless)
y1 = np.array(y1)
y2 = np.array(y2)

plt.plot(x, y1)
plt.title('Power consumption associated to timeout value')
plt.xlabel('timeout')
plt.ylabel('Energy consumed')

plt.savefig('printed_graphs/dpm_w2.png')

plt.clf() #clear the plt to print next figure

plt.plot(x, y2)
plt.title('Energy saved')
plt.xlabel('timeout')
plt.ylabel('energy saved')

plt.savefig('printed_graphs/saved_energy_w3.png')

#plt.show()