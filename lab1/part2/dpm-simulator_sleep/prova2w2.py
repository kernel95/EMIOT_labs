import os
import numpy as np
import matplotlib.pyplot as plt 

#from scipy.interpolate import interp1d

Tbe = 73 #Tbe has been calculated through formula explaind during lessons
fig = plt.gcf() #variable created to manage size and characteristics of figures
fig.set_size_inches(30, 10, forward=True) #25 e 35 prima

file = open("simulator_results/results_sleep_w1_prova.txt","w+")
savings = list() #list that contains value of energy consumed with different timeout values
percentage_saved = list() #list of values of percentage of energy saved

for i in range (200):
    
    stream = os.popen('./dpm_simulator -t ' + str(i+Tbe) + ' -psm example/psm.txt -wl workloads/workload_1.txt')
    output = stream.read() #output of the command saved in this variable
    file.write("simulator with timeout t=%d \r\n\n" % (i+Tbe))
    #file.write("simulator with timeout t=%d \r\n\n" % i)
    file.write(output)
    file.write("\n\n")

file.close()

file_savings = open("Energy_w_dpm/dpm_energy_sleep_w1_prova.txt","w+")

#file_savings.write("timeout value,  Energy w DPM \n")

with open('simulator_results/results_sleep_w1_prova.txt') as temp_f:
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
            file_savings.write(str((i+Tbe)) + ',' + str(value_energy)) #save the pair values TIMEOUT and associated ENERGY W DPM
            #file_savings.write(str(i*50) + ',' + str(value_energy)) #save the pair values TIMEOUT and associated ENERGY W DPM
            file_savings.write("\n")
            savings.append(float(value_energy))                  #Save value of energy consumed for each timeout values in a list
            i += 1

min_value = min(savings)                                         #find the smallest amount of energy consumed
min_pos = (savings.index(min(savings)) + 73 )                          #by searching its position we know also the value given to the associated timeout
best = (100 - ((100*(float(0.481))/float(30.141))))

print("Best DPM  timeout=%d, Energy w DPM= %f" % (min_pos , min_value))
print(best)

file_best = open("best_result/best_dpm_sleep_w1_prova.txt","w")

file_best.write("Best DPM for the associated timeout value\n Timeout: "+str(min_pos)+", Energy consumed: " +str(min_value))

file_savings.close()
file_best.close()