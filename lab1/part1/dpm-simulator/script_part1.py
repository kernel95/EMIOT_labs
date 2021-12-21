import os
import numpy as np
import matplotlib.pyplot as plt 

#from scipy.interpolate import interp1d

fig = plt.gcf() #variable created to manage size and characteristics of figures
fig.set_size_inches(35, 25, forward=True)

file = open("results_wl.txt","w+")
savings = list() #list that contains value of energy consumed with different timeout values
percentage_saved = list() #list of values of percentage of energy saved

for i in range (500):
    stream = os.popen('./dpm_simulator -t ' + str(i) + ' -psm example/psm.txt -wl example/wl.txt')
    output = stream.read() #output of the command saved in this variable
    file.write("simulator with timeout t=%d \r\n\n" % i)
    file.write(output)
    file.write("\n\n")

file.close()

file_savings = open("dpm_energy_wl.txt","w+")

#file_savings.write("timeout value,  Energy w DPM \n")

with open('results_wl.txt') as temp_f:
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

file_best = open("best_dpm_wl.txt","w")

file_best.write("Best DPM for the associated timeout value\n Timeout: "+str(min_pos)+", Energy consumed: " +str(min_value))

file_savings.close()
file_best.close()

x = list()
y1 = list()
y2 = list()

n = 0
with open('dpm_energy_wl.txt') as temp_f:   #for each line in the file that contains pair TIMEOUT, ENERGY W DPM
    datafile = temp_f.readlines()           #We copy the pair respectively in x and y
    for line in datafile:
        value_list = line.split(",")
        if ((n%10) == 0):
            x.append(value_list[0])         #add a value every 10 to reduce overhead in the printed figure
            y1.append(value_list[-1])
            y2.append((100 - ((100*(float(value_list[-1]))/float(Energy_wo_dpm))))) #energy saved in percentage
        n = n+1


x = np.array(x)
y1 = np.array(y1)
y2 = np.array(y2)

#cubic_interploation_model = interp1d(x, y1, kind = "cubic")
#cubic_interploation_model = interp1d(x, y2, kind = "cubic")

#x_final = np.linspace(x.min(), x.max(), 500)
#y1_final = cubic_interploation_model(x_final)
#y2_final = cubic_interploation_model(x_final)

#plt.subplot(nrows,ncols,nsubplot)
#plt.subplot(2, 1, 1)
plt.plot(x, y1)
plt.title('Power consumption associated to timeout value')
plt.xlabel('timeout')
plt.ylabel('Energy consumed')

plt.savefig('dpm_wl.png')

plt.clf()

#plt.subplot(2, 1, 2)
plt.plot(x, y2)
plt.title('Energy saved')
plt.xlabel('timeout')
plt.ylabel('energy saved')

plt.savefig('saved_energy_wl.png')

#plt.show()