import os

file = open("results_w2.txt","w+")
savings = list()

for i in range (100):
    stream = os.popen('./dpm_simulator -t ' + str(i) + ' -psm example/psm.txt -wl workloads/workload_2.txt')
    output = stream.read()
    #output_temp = stream.read()
    file.write("simulator with timeout t=%d \r\n\n" % i)
    file.write(output)
    file.write("\n\n")

file.close()

file_savings = open("dpm_energy_w2.txt","w+")

#file_savings.write("timeout value,  Energy w DPM \n")

with open('results_w2.txt') as temp_f:
    datafile = temp_f.readlines()
    i = 0
    for line in datafile:
        if "Energy w DPM" in line:
            value_list = line.split()
            dpm_energy = value_list[-1]
            value_energy = dpm_energy[:-1]
            file_savings.write(str(i) + ',' + str(value_energy))
            file_savings.write("\n")
            savings.append(float(value_energy))
            i += 1

min_value = min(savings)
min_pos = savings.index(min(savings))

#print(min_value)
#print(min_pos)

print("Best DPM  timeout=%d, Energy w DPM= %f" % (min_pos , min_value))

file_best = open("best_dpm_w2.txt","w")
file_best.write(str(min_pos)+"," +str(min_value))

file_savings.close()
file_best.close()