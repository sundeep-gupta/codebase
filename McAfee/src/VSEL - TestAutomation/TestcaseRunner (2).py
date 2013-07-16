import xml.dom.minidom
import re
from xml.dom import Node
import sys
sys.path.append('./Testcases/Common')
sys.path.append('./Testcases/AntiMalware')
sys.path.append('./Testcases/AppProtection')


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
class InvalidTestcaseMappingFile(Exception) :
    def __init__(self, message) :
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
            self.tcObj = Testcase(tcNode)
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
    

class Phase :
    def __init__(self, phaseNode, tcRef) :
        self.__dict__['tcref'] = tcRef
        self.__getPhase(phaseNode)
        pass

    def __getPhase(self, phaseNode) :
        actions = phaseNode.childNodes
        self.__dict__['actions'] = []
        self.__dict__['current'] = 0 
        for action in actions :
            if action.nodeType not in [Node.ELEMENT_NODE] :
                continue
            if action.tagName == 'action' :
                self.__dict__['actions'].append(Action(action))
            elif action.tagName == 'verify' :
                self.__dict__['actions'].append( Verify(action) )
            elif action.tagName == 'property' :
                self.__addProperty(self.__dict__['tcref'], action)


    def __addProperty(self, tcref, propTag) :
        """
        Method to add property to the testcase from the <property> tag
        """
        propName = propTag.getAttribute('name')
        if propTag.hasAttribute('value') :
            val = propTag.getAttribute('value')
            regex = '$\{(.*)\}'
            while True :
                pass
                # TODO : parse the value to read references and substitute the values...
        elif propTag.hasAttribute('arg') :
            try :
                propValue = sys.argv[int(propTag.getAttribute('arg')]
            except ValueError as e :
                raise InvalidTestcaseMappingFileException('Value Error occured for property tag with arg attribute')
            except IndexError as e :
                raise InvalidTestcaseMappingFileException('Index Error occured for property tag with arg attribute')
        elif propTag.hasAttribute('ref') :
            try :
                propValue = tcref.__dict__[propTag.getAttrubute('ref')]
            except KeyError as e :
                raise InvalidTestcaseMappingFileException('Key Error occured for property tag with ref attribute')

        tcref.__dict__[propName] = propValue


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
            self.__dict__['return'] = ModuleCaller.call(moduleName, methodName, self.__dict__['args'])
        else :
            self.__dict__['return'] = ModuleCaller.call(moduleName, methodName)
        print "Return is "
        print self.__dict__['return']
class ModuleCaller:
    importedModules = dict()
    @classmethod
    def call(cls, moduleName, methodName, *args) :
        """
        'import's the given module and calls the given method of the module passing the parameters provided.
        For better performance, a map is maintained to avoid importing already loaded modules.
        
        raises 'ActionFailedException' if module import fails or if the given method does not exist in the module.
        """
        if not ModuleCaller.importedModules.has_key(moduleName) or ModuleCaller.importedModules[moduleName] is not None : 
            try :
                ModuleCaller.importedModules[moduleName] = __import__(moduleName)
            except ImportError as e :
                raise ActionFailedException('Failed to import ' + moduleName +'.')
        if not hasattr(ModuleCaller.importedModules[moduleName], methodName) :
            raise ActionFailedException("Method %s does not exist in module %s" % (methodName, moduleName))
        return getattr(ModuleCaller.importedModules[moduleName], methodName).__call__(*args)


class Verify(Action) :
    def __init__(self, actionNode) :
        Action.__init__(self, actionNode)
        self.__dict__['expected'] = actionNode.getAttribute('return')
        if re.match('true', self.__dict__['expected'], flags=re.IGNORECASE) :
            self.__dict__['expected'] = True
        elif re.match('false', self.__dict__['expected'], flags=re.IGNORECASE) :
            self.__dict__['expected'] = False
        # TODO : Verify action is for conditional actions. So <verify> node might
        # have other <action> nodes also... we need to add this feature..
        # For now Verify is just comparing the action's response with expected response.
        
    def run(self) :
        Action.run(self)
        # For making pass 
        #self.__dict__['return'] = self.__dict__['expected']
        if self.__dict__['return'] != self.__dict__['expected'] :
            raise ActionFailedException('expected value did not match')

class Testcase :
    expectedPhases = ['init', 'steps', 'validate', 'cleanup']   
    def __init__(self, tcNode) :
        self.__dict__['id'] = tcNode.getAttribute('id')
        self.__dict__['desc'] = tcNode.getAttribute('desc')

        self.__dict__['phases'] = dict(init = None, steps=None, verify=None, cleanup=None)

        # add the actions to be taken in each phase to the testase object.
        phaseNodes = tcNode.childNodes
        for phaseNode in phaseNodes :
            if phaseNode.nodeType not in [ Node.ELEMENT_NODE ]  :
                continue
            if phaseNode.tagName in Testcase.expectedPhases :
                self.__dict__['phases'][phaseNode.tagName] = Phase(phaseNode, self)
        

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
