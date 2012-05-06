#This function encodes an analog signal as an integrate and fire neuron would
#The signal is a list of values of the same length as the list of times.
#dt specifies the distance between each time, bias is used to make the
#signal have a posotive integral
#threshold is the threshold value at which the neuron will output a spike
#and reset it's value
node IAF_encode(signal,times,dt,bias,threshold)
	y=[] #integral of the signal over time
	spike=[] #records spike times

	y=y+[(dt*(signal[0]+bias))] #set the initial value of the integral

	spikecount = 0 # will keep track of the number of spikes produced and
	for index in 1..(times.size)
			j = index - 1
			y[index] = y[j] + dt * (signal[index] + bias)
			#Here we approximate the integral for each time step
			time=index*dt

			#if the threshold is passed, then we make a spike
			if y[i] >= threshold
				spike[spikecount] = time  #store the spike data
				y[i] -= threshold                 #reset the variable
				spikecount += 1           #increment the spike index
			else
				continue
			end

	end

	return spike #return the spike times/time-encoded signal
end

dt= 1.0 / 1000000.0 #seconds
duration = 0.25 #seconds
times=[]
t=0

#assign the times
while (t*dt) <= duration
	times[t] = t*dt
	t += 1
end


bandwidth = 25
#create bandlimited signal
signal=[]
for index in 0..(times.size)
	c=2*bandwidth*times[index]
	a=Math.sin c
	signal[index] = 2 * bandwidth * a
end
#########


bias = signal.min.abs

#determined experimentally
threshold = 0.007

#print the spiketimes that represent the signal
IAF_encode signal times dt bias threshold | Println
