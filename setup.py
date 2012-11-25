#!/usr/local/bin/python3
import os, sys, termcolor

msgtype = {'WARNING':	termcolor.colored('(Warning)', 'yellow'),
		   'ERROR':		termcolor.colored('(Error)', 'red'),
		   'NOTICE':	termcolor.colored('==>', 'cyan')}
			
def getNow():
	from time import strftime, localtime
	return strftime('%Y-%m-%d %a %Z %H:%M:%S', localtime())

def macsetup():
	return
def linuxsetup(distribution):
	return
def main():
	import platform
	print(msgtype['NOTICE'], "Setting up the dotfiles environment")	
	
	print(msgtype['NOTICE'], "Determining the system platform ...... ", end='')
	plat = sys.platform
	if plat.startswith('darwin'):
		print ('Mac OS X', platform.mac_ver()[0])
		macsetup()
	elif plat.startswith('linux'):
		if platform.dist()[0] == 'redhat':
			print ('Redhat', platform.dist()[1])
			linuxsetup('redhat')
		elif platform.dist()[1] == 'centos':
			print ('Centos', platform.dist()[1])
			linuxsetup('centos')
		else:
			print ('Linux')
			print (msgtype['ERROR'], 'Unkown linux distrubtion:', ' '.join(platform.dist()))	
	else:
		print (msgtyp['ERROR'], 'Unkown system platform:', plat)
	print ('Exiting')

if __name__ == '__main__':
	main()

