import os
import matplotlib.pyplot as plt
from matplotlib import cm
from matplotlib.ticker import LinearLocator
import numpy as np

Tbe = 73

# fig = plt.gcf() #variable created to manage size and characteristics of figures
# fig.set_size_inches(18, 18, forward=True) #25 e 35 prima

file = open("simulator_results/results_extra_wl.txt","w+")
savings = list() #list that contains value of energy consumed with different timeout values
percentage_saved = list() #list of values of percentage of energy saved

for i in range (20):
    for j in range (50):
        #stream = os.popen('./dpm_simulator -t ' + str(i) + str(j+Tbe) + ' -psm example/psm.txt -wl example/wl.txt')
        stream = os.popen('./dpm_simulator -t ' + str(i) + str(j) + ' -psm example/psm.txt -wl example/wl.txt')
        output = stream.read() #output of the command saved in this variable
        #file.write("simulator with timeout idle t=%d and sleep t=%d \r\n\n" % (i, j+Tbe))
        file.write("simulator with timeout idle t=%d and sleep t=%d \r\n\n" % (i, j))
        file.write(output)
        file.write("\n\n")

file.close()

file_savings = open("Energy_w_dpm/dpm_energy_extra_wl.txt","w+")

#file_savings.write("timeout value,  Energy w DPM \n")
min_energy = 0
with open('simulator_results/results_extra_wl.txt') as temp_f:
    datafile = temp_f.readlines()
    i = 0
    #j = Tbe
    j = 0
    
    for line in datafile:                                        #for each line in the file
        if "Energy w DPM" in line:                               #that contains this string
            value_list = line.split()                            #split by space
            dpm_energy = value_list[-1]                          #save inside dpm energy the last value in the last string produced by the simulator
            if i == 0 :
                temp_en = value_list[5]                          #save the amount of energy consumed witouth dpm
                temp_en2 = temp_en[:-1]
                Energy_wo_dpm = temp_en2[:-1]
                min_energy = Energy_wo_dpm
            
            value_energy = dpm_energy[:-1]                       #remove the character J
            file_savings.write(str(i) + ',' + str(j) + ',' + str(value_energy)) #save the values TIMEOUT_idle + Timeout_sleep + associated ENERGY W DPM
            file_savings.write("\n")
            savings.append(float(value_energy))                  #Save value of energy consumed for each timeout values in a list

            if(value_energy < min_energy):
                min_energy = value_energy
                min_idle = i
                min_sleep = j
            
            if(j < (100)): #aggiungere TBE se si considera
                j += 1
            else:
                #j = Tbe
                j = 0
                i += 1


#print("Best DPM  timeout_idle=%d, timeout_sleep=%d and Energy w DPM= %f" % (min_idle , min_sleep, min_energy))

file_best = open("best_result/best_dpm_extra_wl.txt","w")

file_best.write("Best DPM for the associated policy is value\n Timeout_idle: "+str(min_idle)+ "Timeout_sleep: "+str(min_sleep)+ ", Energy consumed: " +str(min_energy))

file_savings.close()
file_best.close()

x1 = list() #value for timeout_idle
x2 = list() #value for timeout_sleep
y1 = list() #value for energy consumed
y2 = list() #value for energy saved

n = 0
with open('Energy_w_dpm/dpm_energy_extra_wl.txt') as temp_f:   #for each line in the file that contains pair TIMEOUT, ENERGY W DPM
    datafile = temp_f.readlines()           #We copy the pair respectively in x and y
    for line in datafile:
        value_list = line.split(",")
        #if ((n%10) == 0):                   #add a value every 10 to reduce overhead in the printed figure
        x1.append(float(value_list[0]))         #save in x1 value of timeout_idle
        x2.append(float(value_list[1]))         #save in x2 value for timeout_sleep
        y1.append(float(value_list[-1][:-8]))       #save in y1 the value of the energy consumed with DPM
        y2.append(float((100 - ((100*(float(value_list[-1]))/float(Energy_wo_dpm)))))) #energy saved in percentage
        n = n+1


y1 = np.array(y1)

x = np.array(x1)     #transform them from list to array (maybe useless) #timeout_idle
y = np.array(x2)     #timeout_sleep
z = np.array(y2)     #energy_saved values


fig = plt.figure(figsize=(50,50))

# #fig = plt.figure()

ax = fig.add_subplot(111, projection='3d')

ax.scatter(x,y,z)
plt.savefig('printed_graphs/saved_energy_extra_wl.png')

plt.show()

# plt.plot(x1, y1)
# plt.title('Power consumption associated to timeout value')
# plt.xlabel('timeout')
# plt.ylabel('Energy consumed')
# #plt.show()
# plt.savefig('printed_graphs/dpm_extra_wl.png')

# plt.clf() #clear the plt to print next figure

# plt.plot(x1, y2)
# plt.title('Energy saved')
# plt.xlabel('timeout')
# plt.ylabel('energy saved')

# #plt.show()
# plt.savefig('printed_graphs/saved_energy_extra_wl.png')