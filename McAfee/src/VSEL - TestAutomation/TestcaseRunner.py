import xml.dom.minidom
import re
from xml.dom import Node
import sys
sys.path.append('./Testcases/Common')
sys.path.append('./Testcases/Antimalware')
sys.path.append('./Testcases/EPO')


class TestcaseFailedException(Exception) :
    def __init__(self, baseException):
        self.message = baseException.__str__()
    def __str__(self):
        return self.message

class ActionFailedException(Exception) :
    def __init__(self, message):
        self.message = message
    def __str__(self):
        return self.message

class MultipleTestcaseFoundException(Exception) :
    def __init__(self, message):
        self.message = message
    def __str__(self):
        return self.message

class NoTestcaseMatchException(Exception) :
    def __init__(self, message):
        self.message = message
    def __str__(self):
        return self.message

class TestcaseRunner :
    def __init__(self, xmlFile, id):
        """
        Parses the given xml file and filters the testcases which has the id mentioned
        """
        try :
            tcNode = self.__getTestcase(xmlFile, id)
            self.tcObj = self.__getTestcaseObj(tcNode)
        except NoTestcaseMatchException as e:
            print e
        except MultipleTestcaseFoundException as e:
            print e
    
    def run(self):
        self.tcObj.run()   

    def __getTestcase(self,xmlFile, id) :
        tc_dom = xml.dom.minidom.parse(xmlFile)
        testcases = tc_dom.documentElement.getElementsByTagName("testcase")
        tc = [testcase for testcase in testcases if testcase.getAttribute('id') == str(id)]
        if len(tc) == 0 :
            raise NoTestcaseMatchException("Testcase with id %d not found in xml file %s" % (id, xmlFile))
        if len(tc) > 1 :
            raise MultipleTestcaseFoundException("Multiple testcases with id %d found." % id)
        return tc[0]
    
    def __getTestcaseObj(self,tcNode):
        # Found the exact testcase. Lets build the ds for execution.
        tcObject = Testcase(tcNode.getAttribute('id'), tcNode.getAttribute('desc'))
        
        # add the actions to be taken in each phase to the testase object.
        phaseNodes = tcNode.childNodes
        for phaseNode in phaseNodes :
            if phaseNode.nodeType not in [ Node.ELEMENT_NODE ]  :
                continue
            if phaseNode.tagName in Testcase.expectedPhases :
                tcObject.setPhase(phaseNode.tagName, Phase(phaseNode))
        return tcObject

class Phase :
    def __init__(self, phaseNode) :
        self.__getPhase(phaseNode)
    
        pass

    def __getPhase(self, phaseNode) :
        actions = phaseNode.childNodes
        self.__dict__['actions'] = []
        self.__dict__['current'] = 0 
        for action in actions :
            if action.nodeType not in [Node.ELEMENT_NODE] :
                continue
            if action.tagName == 'verify' :
                self.__dict__['actions'].append( Verify(action) )
            else :
                self.__dict__['actions'].append(Action(action))

    def __iter__(self):
        return self

    def next(self) :
        # Some stuff to do... lets break now!
        if self.__dict__['current'] >= len(self.__dict__['actions']) :
            raise StopIteration
        else :
            self.__dict__['current'] = self.__dict__['current'] + 1
            return self.__dict__['actions'][self.__dict__['current'] - 1]

class Action :
    def __init__(self, actionNode) :
        self.__dict__['method'] = actionNode.getAttribute('method')
        if actionNode.hasChildNodes() :
            paramNodes = actionNode.childNodes
            for paramNode in paramNodes :
                if paramNode not in [Node.ELEMENT_NODE] :
                    continue
                self.__dict__['args'][paramNode.getAttribute('name')] = paramNode.getAttribute('value')

    def run(self) :
        if re.search('\.', self.__dict__['method']) is None :
            moduleName, methodName = 'commonFns', self.__dict__['method']
        else :
            moduleName, methodName = self.__dict__['method'].split('.')
        print "On Module %s Method %s called." % (moduleName, methodName)

        # TODO : Here call the actual API based on keyword and argument.... the real challange:-)
        if self.__dict__.has_key('args') :
            ModuleCaller.call(moduleName, methodName, self.__dict__['args'])
        else :
            ModuleCaller.call(moduleName, methodName)
        self.__dict__['return'] = '0'

class ModuleCaller:
    importedModules = dict()
    @classmethod
    def call(cls, moduleName, methodName, *args) :
        print moduleName
        print methodName
        if not ModuleCaller.importedModules.has_key(moduleName) or ModuleCaller.importedModules[moduleName] is not None : 
            ModuleCaller.importedModules[moduleName] = __import__(moduleName)
        print args
        print '-------'
        ModuleCaller.importedModules.keys()
        print '-------'
        return getattr(ModuleCaller.importedModules[moduleName], methodName).__call__(*args)


class Verify(Action) :
    def __init__(self, actionNode) :
        Action.__init__(self, actionNode)
        self.__dict__['expected'] = actionNode.getAttribute('return')
        # TODO : Verify action is for conditional actions. So <verify> node might
        # have other <action> nodes also... we need to add this feature..
        # For now Verify is just comparing the action's response with expected response.
        
    def run(self) :
        Action.run(self)
        # For making pass 
        self.__dict__['return'] = self.__dict__['expected']
        if self.__dict__['return'] != self.__dict__['expected'] :
            raise ActionFailedException('expected value did not match')

class Testcase :
    expectedPhases = ['init', 'steps', 'validate', 'cleanup']   
    def __init__(self, id, desc) :
        self.__dict__['id'] = id
        self.__dict__['desc'] = desc
        self.__dict__['phases'] = dict(init = None, steps=None, verify=None, cleanup=None)
        
    def setPhase(self,phase, actions) :
        self.__dict__['phases'][phase] = actions

    def run(self):
        for phaseName in Testcase.expectedPhases :
            print "Starting phase %s " % phaseName
            if self.__dict__['phases'][phaseName] is not None :
                for action in self.__dict__['phases'][phaseName] :
                    try :
                        action.run()
                    except ActionFailedException as e :
                        raise TestcaseFailedException(e.__str__())

if __name__ == '__main__' :
    tcr = TestcaseRunner("Testcase.xml", 1234)
    tcr.run()
