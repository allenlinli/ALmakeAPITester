import exceptions, unittest
import urllib2
import os
import APITester
import json
from os.path import abspath, expanduser
import syslog

import Examples

class TestMyAPI(unittest.TestCase):

	def setUp(self):
		pass

	def testAPI_1(self):

		output = urllib2.urlopen('http://api.openweathermap.org/data/2.5/weather?q=London').read()
		template = Examples.exampleLondonWeather
		
		diff = APITester.diffAPI(output,template)
		if diff != None:
			print json.dumps(diff,indent=4, separators=(',', ': '))
		self.assertIsNone(diffStr)


#################################################################################################################################


	def writeDiffToFileOrDeleteIfNone(self,diff,output,template,filepath):
		if os.path.isfile(filepath) and os.access(filepath, os.R_OK):
			os.remove(filepath)
		if diff:
			self.writeDiffToFile(diff,output,template,filepath)
			return False
		else:
			return True

	def makeDiffFilepath(self,fileName):
		return abspath(expanduser("~/") + '/Desktop/'+ fileName +'+Diff.txt')

	def writeDiffToFile(self,diff,output,template,filepath):
		f = open(filepath, 'w')
		f.write("\n================= Diff =================\n")
		f.write(diff)
		f.close()
		f = open(filepath, 'a')
		f.write("\n=================  Template =================\n")
		f.write(json.dumps(template,indent=4, separators=(',', ': ')))
		f.write("\n=================  Output =================\n")
		result = json.dumps(output,indent=4, separators=(',', ': '))
		f.write(result)
		f.close()

if __name__ == '__main__':
	unittest.main()


