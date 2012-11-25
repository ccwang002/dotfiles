#!/usr/local/bin/python3
import os, sys, subprocess, termcolor
from time import strftime, localtime
msgtype = {'WARNING':	termcolor.colored('(Warning)', 'yellow'),
		   'ERROR':		termcolor.colored('(Error)', 'red'),
		   'NOTICE':	termcolor.colored('\n==>', 'cyan'),
		   'RESULT':	termcolor.colored('\nResult ==>', 'green')}
status = 'with errors'		
def getNow():
	return strftime('%Y-%m-%d %a %Z %H:%M:%S', localtime())
	
def linksetup(platform):
	global status
	filepaths = []
	filenames = ['.bash_profile', '.bash_aliases', '.screenrc', '.gitignore_global']
	print (msgtype['NOTICE'], 'Linking dot files:', ' '.join(filenames))
	userhome = os.environ['HOME']
	currentpath = os.path.abspath(os.getcwd())
	print ('Home directory:', userhome)
	print ('Current absolute directory:', currentpath)
	# create abs path for dot files		
	# bash_profile
	if platform == 'mac':
		filepaths.append(os.path.join(currentpath, '.bash_profile'))
	elif platform in ['centos', 'redhat']:
		filepaths.append(os.path.join(currentpath, '.bash_profile_centos'))
	else:
		print (msgtype['ERROR'], 'Wrong platform:', platform)
		return
	# bash_aliases, screenrc, and etc
	filepaths.extend([os.path.join(currentpath, f) for f in filenames[1:]]) 

	# linking 
	os.chdir(userhome)
	status = 'successfully'
	for i in range(len(filepaths)):
		# check if linked file exists
		print (msgtype['NOTICE'], 'Linking', filenames[i])
		if not os.path.isfile(filepaths[i]):
			print (msgtype['ERROR'], 'Cannot find file', filenames[i], '. Skipping')
			status = 'with error'
			break
		# check if linking file has existed
		elif os.path.islink(filenames[i]):
			# is a link
			print (msgtype['WARNING'], 'Link', filenames[i], 'has already existed.')
			print ('Originally links to', os.path.realpath(filenames[i]), 'will be deleted.')
			os.remove(filenames[i])

		elif os.path.isfile(filenames[i]):
			# is a file			
			bakfilename = filenames[i] + '_' + getNow().replace(' ', '_') + '.bak'
			print (msgtype['WARNING'], 'File', filenames[i], 'has existed. Rename it into', bakfilename)
			os.rename(filenames[i], bakfilename) 
		os.symlink(filepaths[i], filenames[i])
	return
def main():
	import platform
	print(msgtype['NOTICE'], "Setting up the dotfiles environment")	
	print(msgtype['NOTICE'], "Determining the system platform ...... ", end='')
	plat = sys.platform
	if plat.startswith('darwin'):
		print ('Mac OS X', platform.mac_ver()[0])
		linksetup('mac')
	elif plat.startswith('linux'):
		if platform.dist()[0] == 'redhat':
			print ('Redhat', platform.dist()[1])
			linksetup('redhat')
		elif platform.dist()[1] == 'centos':
			print ('Centos', platform.dist()[1])
			linksetup('centos')
		else:
			print ('Linux')
			print (msgtype['ERROR'], 'Unkown linux distrubtion:', ' '.join(platform.dist()))	
	else:
		print (msgtype['ERROR'], 'Unkown system platform:', plat)
	print (msgtype['RESULT'], 'Exiting', status)

if __name__ == '__main__':
	main()

