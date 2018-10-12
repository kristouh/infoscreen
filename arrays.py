import os

def run_bash():
	os.system('sh skyss.sh')
	os.system('sh yr.sh')

def yr():
	regn_file = open('regn.txt', 'r').read()
	tid_file = open('tid.txt', 'r').read()
	vind_file = open('vind.txt', 'r').read()
	temp_file = open('temp.txt', 'r').read()
	regn = []
	tid = []
	vind = []
	temp = []

	for time in tid_file.split('kl'):
		time = time.strip()
		if (time != ''):
			tid.append(time)

	for rain in regn_file.split('mm'):
		rain = rain.strip()
		if (rain != ''):
			regn.append(rain)

	for wind in vind_file.split('.'):
		wind = wind.strip()
		if (wind != ''):
			vind.append(wind)

	for tmp in temp_file.split(' '):
		tmp = tmp.strip()
		if (tmp != ''):
			temp.append(tmp)
	return tid, regn, vind, temp

def skyss():
	file = open('straumebro.txt', 'r').read()
	sentrum_bool = True
	k = 0
	sentrum = []
	soreide = []
	for line in file.split('\n'):
		if (line == 'Søreide'):
			sentrum_bool = False
		if sentrum_bool:
			try:
				nr, dest, tid = line.split(' ')
				if (nr != ''):
					sentrum.append([nr, dest, tid])
			except ValueError:
				continue
		else:
			try:
				nr, dest, tid = line.split(' ')
				if (nr != ''):
					soreide.append([nr, dest, tid])
			except ValueError:
				continue
	return sentrum, soreide



def main():
	run_bash()
	sentrum, soreide = skyss()
	tid, regn, vind, temp = yr()

if __name__ == '__main__':
	main()