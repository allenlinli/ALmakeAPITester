import json
import copy


def diffAPI(exampleAPI, outputAPI):
	outputJson = json.loads(outputAPI)
	templateJson = json.loads(exampleAPI)
	(boolean, structDiff) = compareStruct(copy.deepcopy(outputJson),copy.deepcopy(templateJson))
	if boolean: 
		return None
	else:
		return structDiff

def compareStruct(outputJson, templateJson):
#error handle
	if type(outputJson) == unicode:
		outputJson = outputJson.encode('ascii','ignore')
	if type(templateJson) == unicode:
		templateJson = templateJson.encode('ascii','ignore')
#main
	if type(outputJson) != type(templateJson):
		return (False,str(outputJson) + " <error: type should be {}>".format(type(templateJson).__name__))
	if type(templateJson) == str:
		return compareStr(outputJson, templateJson)
	elif type(templateJson)==int:
		return compareInt(outputJson, templateJson)
	elif type(templateJson) == dict:
		return compareDict(outputJson, templateJson)
	elif type(templateJson) == list:
		return compareList(outputJson, templateJson)
	elif type(templateJson) == float:
		return compareFloat(outputJson, templateJson)
	return (False,outputJson + "<error: unknown error>")


def compareDict(outputDic,templateDic):
#error
	if not type(outputDic) == type(templateDic) == dict:
		return (False,str(outputDic) + " <exception!! error: type should be {}>".format(type(templateDic).__name__))
	if not any(outputDic):
		return (False,outputDic + " <error: it has no key in dict>")
	if not any(templateDic):
		print "it has no key in dict:\n" + + str(templateDic) 
		return (False,"")
#main
	isSameDict = (True,outputDic)
	for key in templateDic:
		#error handle
		if not outputDic.has_key(key):
			outputDic[key] = ""
			isSameDict = (False,outputDic)
			pass
		#main
		(boolean,value) = compareStruct(outputDic[key],templateDic[key])
		if not boolean:
			outputDic[key] = value
			isSameDict = (False,outputDic)
	return isSameDict

def compareList(outputArray,templateArray):
#error handle
	if not type(outputArray) == type(templateArray) == list:
		return (False,str(outputArray) + " <exception!! error: type should be  {}>".format(type(templateArray).__name__))
	if not any(outputArray):
		return (True,str(outputArray) + " <error: it has no obj in list>")
	if not any(templateArray):
		return (False,str(outputArray) + "<exception!! error: it has no object in template List>")
#main
	isSameList = (True,outputArray)
	if len(templateArray)==len(outputArray):
		for index,value in enumerate(templateArray):
			(boolean, obj) = compareStruct(outputArray[index],value)
			if not boolean:
				outputArray[index] = obj
				isSameList = (False,outputArray)
		return isSameList
	else:
		templateObj = templateArray[0]
		for index,value in enumerate(outputArray):
			(boolean, obj) = compareStruct(outputArray[index],templateObj)
			if not boolean:
				outputArray[index] = obj
				isSameList = (False,outputArray)
		return isSameList

def compareStr(outputStr,templateStr):
#error handle
	if len(templateStr)==0:
		return (False,outputStr + " <exception!!: template error: should not be empty str>")
	if len(outputStr)==0:
		return (False,outputStr + " <error: should not be empty str>")
#main
	return (True,outputStr)
	

def compareInt(outputInt,templateInt):
	if type(templateInt)==int and type(outputInt)==int:
		return (True,outputInt)
	else:
		return (False,outputInt + " <error: should not be int>")

def compareFloat(outputFloat,templateFloat):
	return (True,outputFloat)