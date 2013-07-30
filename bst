#!/usr/bin/env python

# Set Up
import argparse, os, shelve, urllib2


d = shelve.open('db_bst')

# Arguments

parser = argparse.ArgumentParser(description="A better way to use BrowserStackTunnel.jar")
parser.add_argument("-a",
					"--access_key",
					help="specify the BrowserStack access key to use. Saved until overwritten")
parser.add_argument("-c",
					"--clear_access_key",
					action="store_true",
					help="erases your Browserstack access key")
parser.add_argument("-g",
					"--get_access_key",
					action="store_true",
					help="checks the value of your Browserstack access key")
parser.add_argument("-j",
					"--jar",
					action="store_true",
					help="locate or download BrowserStackTunnel.jar")
parser.add_argument("-s",
					"--server",
					help="specify the local server to pass to BrowserStack")
parser.add_argument("-f",
					"--file",
					help="specify the local folder to pass to BrowserStack")

args = parser.parse_args()

# Functions

def noKey():
	user_has_key = raw_input("You need to specify your access key. Do you have it now? yes/no\n >> ")
	if user_has_key == 'yes' or user_has_key == 'y':
		user_inputted_key = raw_input("Please input your access key:\n >> ")
		if user_inputted_key:
			d['access'] = user_inputted_key
			print "Thank you. Please try to run bst again."
		else:
			print "You need to input your access key before you can connect to BrowserStack. Please run 'bst -h' for further assistance"
	else:
		print "You can retrieve your access key from the BrowserStack website."

def checkForJar():
	if not d.has_key('jar'):
		user_wants_to_download = raw_input("You have not told me where BrowserStackTunnel.jar lives yet. Do you need me to download it for you? yes/no\n >> ")
		if user_wants_to_download == 'yes' or user_wants_to_download == 'y':
			# Thanks to Pablo G at Stackoverflow for the code to download a file
			# http://stackoverflow.com/a/22776/2250435
			url = "http://www.browserstack.com/BrowserStackTunnel.jar"
			file_name = url.split('/')[-1]
			u = urllib2.urlopen(url)
			f = open(file_name, 'wb')
			meta = u.info()
			file_size = int(meta.getheaders("Content-Length")[0])
			print "Downloading: %s Bytes: %s" % (file_name, file_size)

			file_size_dl = 0
			block_sz = 8192
			while True:
			    buffer = u.read(block_sz)
			    if not buffer:
			        break

			    file_size_dl += len(buffer)
			    f.write(buffer)
			    status = r"%10d  [%3.2f%%]" % (file_size_dl, file_size_dl * 100. / file_size)
			    status = status + chr(8)*(len(status)+1)
			    print status,

			f.close()
			path = os.path.realpath(__file__)
			path = path.replace(' ', '')[:-3]
			d['jar'] = path + 'BrowserStackTunnel.jar'
		else:
			user_provided_jar = raw_input("Please provide the full path to BrowserStackTunnel.jar\n >> ")
			d['jar'] = user_provided_jar
			print "\nThe location of BrowserStackTunnel.jar was set to " +  d['jar']
	else:
		print "You already have provided the location of BrowserStackTunnel.jar. It is " + d['jar']
		user_wants_to_clear_jar = raw_input("Do you want to clear this value? yes/no\n >> ")
		if user_wants_to_clear_jar == "yes" or user_wants_to_clear_jar == "y":
			del d['jar']
			print "The location of BrowserStackTunnel.jar has been cleared."
		else:
			print "Okay, the location of BrowserStackTunnel.jar has been retained."

# Action

if args.access_key:
	d['access'] = args.access_key
	print "You specified an access key. It is " + d['access'] + "."
elif args.get_access_key:
	try:
		print "Your access key is " + d['access']
	except KeyError:
		noKey()
elif args.clear_access_key:
	try:
		del d['access']
		print "Your access key has been cleared."
	except KeyError:
		noKey()
elif args.jar:
	checkForJar()
else:
	if d.has_key('access'):
		if not d.has_key('jar'):
			checkForJar()
		else:
			if args.server:
				os.system("java -jar " + d['jar'] + " " + d['access'] + " " + args.server)
			elif args.file:
				os.system("java -jar " + d['jar'] + " -f " + d['access'] + " " + args.file)
			else:
				os.system("java -jar " + d['jar'] + " " + d['access'] + " " + "localhost,3000,0")
	else:
		noKey()
		