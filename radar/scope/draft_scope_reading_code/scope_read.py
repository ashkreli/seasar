import time # std module
import pyvisa # http://github.com/hgrecco/pyvisa
import matplotlib.pyplot as plt # http://matplotlib.org/
import numpy as np # http://www.numpy.org/

#input - how many seconds?  n seconds
seconds = int(input("How many seconds to log?"))

results = []

#Connect to scope/VISA

#rm = pyvisa.ResourceManager()

#inst = rm.list_resources()[0]

#inst = rm.open_resource(inst)

visa_address = 'USB::0x0699::0x0401::C002176::INSTR'

rm = pyvisa.ResourceManager()
#resources = rm.list_resources()
scope = rm.open_resource(visa_address)
scope.timeout = 10000 # ms
scope.encoding = 'latin_1'
scope.read_termination = '\n'
scope.write_termination = None
scope.write('*cls') # clear ESR

print("CHECKPOINT 1")

print(scope.query('*idn?'))

#set up scope - autoset
scope.write('*rst') # reset
r = scope.query('*opc?') # sync

print("CHECKPOINT 2")

scope.write('autoset EXECUTE') # autoset
r = scope.query('*opc?') # sync

print("CHECKPOINT 3")

scope.write('acquire:state 0') # stop
scope.write('acquire:stopafter SEQUENCE') # single

print("CHECKPOINT 4")

#set up measurements
scope.write("MEASUREMENT:ADDMEAS FREQUENCY")

print("CHECKPOINT 5")

for x in range(seconds):
    print("Second: " + str(x))
    #acquire
    scope.write('acquire:state 1') # run

    print("Second: " + str(x))
    r = scope.query('*opc?') # sync
    print("Second: " + str(x))
    #query measurement
    meas = float(scope.query("measu:meas1:resu:curr:mean?"))
    print(meas)

    #wait 1000ms
    time.sleep(1)

    #log result
    results.append(meas)

#loop back to acquire n times

scope.close()
rm.close()

#plot result
plt.plot(range(seconds), results)
plt.title('frequency over time') # plot label
plt.xlabel('time (seconds)') # x label
plt.ylabel('frequency (Hz)') # y label
print("look for plot window...")
plt.show()