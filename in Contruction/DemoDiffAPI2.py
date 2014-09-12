import exceptions, unittest
import urllib2
import os
import APITester
import json
from os.path import abspath, expanduser
import syslog

import Examples



def testAPI_1():

	output = urllib2.urlopen('http://api.openweathermap.org/data/2.5/weather?q=London').read()
	template = Examples.exampleLondonWeather
	
	diff = APITester.diffAPI(output,template)
	print json.dumps(diff,indent=4, separators=(',', ': '))



testAPI_1()

