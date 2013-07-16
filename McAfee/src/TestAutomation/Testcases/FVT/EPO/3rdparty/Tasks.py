'''
Tasks.py

Author:        Chris Tissell
Description:   This is a London Bridge's Helper Function module which is used by epo team.
               It contains all the **platform independent** classes pertaining to
               task creation.

'''
#Copyright (C) 2009 McAfee, Inc.  All rights reserved.

import datetime

class EPOTask:
    '''Represents a task in ePO'''
    def __init__(self):
        self.name = ""
        self.type = ""
        # list of tuples of the form ("Section", "Setting", "Value")
        self.taskSettings = []
        self.platforms = "WIN95|WIN98|WINME|WNTS|WNTW|WXPW|WXPS|WXPHE|" + \
                         "WNT7W|W2KS|W2KW|WVST|WVSTS|LINUX|MAC|SCM|SLR|HPUX"
    
    def getIBTExtensionString(self, extraSettings = []):                
        '''Create a string readable by the IBT extension'''
        string = ""     
        for tuple in self.taskSettings + extraSettings + [("General", "TaskType", self.type)]:
            string += "\t".join(tuple) + "`"        
        return string
    
    def setPlatforms(self, strPlatformMask):
        '''Set the platforms this task will run on.
        
            Input: 
                strPlatformMask - an OR bar separated list of ePO/Agent platform
                                  tags. See the manaagement SDK for a complete list.
                                  By default tasks run on agent supported platforms
        '''
        self.platforms = strPlatformMask

class AgentUpdateTask(EPOTask):
    '''Represents and Agent update task'''
    def __init__(self, strName="New Task"):
        '''Create an empty update task with the given name'''
        EPOTask.__init__(self)
        self.name = strName
        self.type = "Update"
        self.updateAll = "0"
        self.showUI = "0"
        self.allowPostpone = "0"
        self.numPostpones = "1"
        self.maxPostpones = "20"
        self.prodIDs = ["VSCANDAT1000", "VSCANENG1000"]    #these are defaults for every update task
        #default task settings
        self.taskSettings = [("InetManager", "RegenerateCacheEnabled", "0"),
                             ("InetManager", "szRegenerateCacheTimeoutMins", "0"),
                             ("InetManager", "EnabledSitesNum", "0"),
                             ("InetManager", "EnabledSites", "")]
    
    def setShowUI(self, bool):
        '''Set the "show UI" flag'''
        if bool:
            self.showUI = "1"
        else:
            self.showUI = "0"
    
    def setPostpones(self, bAllow, numPostpones, maxPostpones):
        '''Set the update postponement options'''
        if bAllow:
            self.allowPostpone = "1"
        else:
            self.allowPostpone = "0"
        self.numPostpones = str(numPostpones)
        self.maxPostpones = str(maxPostpones)
        
    def setUpdateAll(self, bool):
        '''Set the "update all packages" flag'''
        if bool:
            self.updateAll = "1"
        else:
            self.updateAll = "0"
            
    def addProductUpdate(self, strProdID):
        '''Add the given product ID to the update list. 
        By default dats and engine are updated'''
        self.prodIDs.append(strProdID)
    
    def getIBTExtensionString(self):                
        extraSettings = [("UpdateOptions", "bShowUI", self.showUI),
                         ("UpdateOptions", "bAllowPostpone", self.allowPostpone),
                         ("UpdateOptions", "nMaxPostpones", self.numPostpones),
                         ("UpdateOptions", "nPostponeTimeout", self.maxPostpones),
                         ("SelectedUpdates", "UpdateAll", self.updateAll),
                         ("SelectedUpdates", "NumOfUpdates", str(len(self.prodIDs)))]
        
        i = 1
        for id in self.prodIDs:
            extraSettings.append(("SelectedUpdates", "Update_" + str(id), id))
            extraSettings.append(("SelectedUpdates\\" + id, "Update", "1"))
            i += 1
        
        return EPOTask.getIBTExtensionString(self, extraSettings)
    
class AgentDeploymentTask(EPOTask):
    '''Represents an agent deployment task'''
    
    LANG_NEUTRAL = "0000"
    LANG_ENGLISH = "0409"
    
    def __init__(self, strName="New Task"):
        '''Create an empty deployment task with the given name'''
        EPOTask.__init__(self)
        self.name = strName
        self.type = "Deployment"
        self.runEveryEnforcement = "0"
        self.updateAfterDeploy = "0"
        self.numInstalls = 0
        self.numRemoves = 0
        #default settings
        self.taskSettings = [("DeploymentOptions", "DummyPolicy", "0")]
        
    def addProduct(self, strProdID, strBuildVer, strAction="Install", strBranch="Current", 
                          strLang=LANG_ENGLISH, strCmdLine=""):
        '''Add a product to be removed or installed
            
            Input:
                strProdID - The product id for the product being deployed. i.e. "VIRUSCAN8600"
                strBuildVer - The MAJOR build number of the product. i.e. 8.5.0
                strAction - "Install" or "Remove"
                strBranch - "Current" or "Previous"
                strLang - one of the language IDs. i.e. AgentDeploymentTask.LANG_NEUTRAL
                strCmdLine - command line options to pass to the deployment 
                
            Returns True if successful, otherwise False
        '''
        if strAction == "Install":
            self.numInstalls += 1
            self.taskSettings.append(("Install", "Install_" + str(self.numInstalls), strProdID))
            section = "Install\\" + strProdID 
            self.taskSettings.append((section, "Language", strLang))
            self.taskSettings.append((section, "BuildVersion", strBuildVer))
            self.taskSettings.append((section, "PackagePathType", strBranch))
            self.taskSettings.append((section, "InstallCommandLine", strCmdLine))           
        elif strAction == "Remove":
            self.numRemoves += 1
            self.taskSettings.append(("Uninstall", "Uninstall_" + str(self.numRemoves), strProdID))
            section = "Uninstall\\" + strProdID 
            self.taskSettings.append((section, "Language", strLang))
            self.taskSettings.append((section, "BuildVersion", strBuildVer))
            self.taskSettings.append((section, "PackagePathType", strBranch))
            self.taskSettings.append((section, "InstallCommandLine", strCmdLine))            
        else:
            return False
        return True
        
    def setRunAtEveryPolicyEnforcement(self, bool):
        '''Set the "Run at every policy enforcement" flag'''
        if bool:
            self.runEveryEnforcement = "1"
        else:
            self.runEveryEnforcement = "0"
            
    def setUpdateAfterDeploy(self, bool):
        '''Set the "Run update after deployment" flag'''
        if bool:
            self.updateAfterDeploy = "1"
        else:
            self.updateAfterDeploy= "0"
        
    def getIBTExtensionString(self):                
        extraSettings = [("Install", "NumInstalls", str(self.numInstalls)),
                         ("Uninstall", "NumUninstalls", str(self.numRemoves)),
                         ("DeploymentOptions", "UpdateAfterDeployment", self.updateAfterDeploy),
                         ("DeploymentOptions", "DummyPolicy", "0"),
                         ("SchedulerExtraData", "RunAtEnforcementEnabled", self.runEveryEnforcement),
                         ("Settings", "RunAtEnforcementEnabled", self.runEveryEnforcement)]
        
        return EPOTask.getIBTExtensionString(self, extraSettings)

class EPOTaskSchedule:
    '''Contains EPO client task schedule data'''
    
    #schedule types
    SCHED_TYPE_DAILY = "0"
    SCHED_TYPE_WEEKLY = "1"
    SCHED_TYPE_MONTHLY = "2"
    SCHED_TYPE_ONCE = "3"
    SCHED_TYPE_AT_STARTUP = "4"
    SCHED_TYPE_AT_LOGIN = "5"
    SCHED_TYPE_IDLE = "6"
    SCHED_TYPE_RUN_IMMEDIATELY = "7"
    SCHED_TYPE_ON_DIALUP = "8"
    
    SCHED_REPEAT_OPTION_DISABLED = "-1"
    SCHED_REPEAT_OPTION_HOURS = "0"
    SCHED_REPEAT_OPTION_MINUTES = "1"
    
    SCHED_UNTIL_OPTION_TIME = "0"
    SCHED_UNTIL_OPTION_DURATION = "1"
    
    SCHED_MONTHLY_OPTION_BY_DAY_NUMBER = "0"
    SCHED_MONTHLY_OPTION_BY_WEEK_DAY = "1"
    
    SCHED_DAY_SUNDAY = 0x01
    SCHED_DAY_MONDAY = 0x02
    SCHED_DAY_TUESDAY = 0x04
    SCHED_DAY_WEDNESDAY = 0x08
    SCHED_DAY_THURSDAY = 0x10
    SCHED_DAY_FRIDAY = 0x20
    SCHED_DAY_SATURDAY = 0x40
    
    SCHED_MONTH_JANUARY = 0x01
    SCHED_MONTH_FEBRUARY = 0x02
    SCHED_MONTH_MARCH = 0x04
    SCHED_MONTH_APRIL = 0x08
    SCHED_MONTH_MAY = 0x10
    SCHED_MONTH_JUNE = 0x20
    SCHED_MONTH_JULY = 0x40
    SCHED_MONTH_AUGUST = 0x80
    SCHED_MONTH_SEPTEMBER = 0x100
    SCHED_MONTH_OCTOBER = 0x200
    SCHED_MONTH_NOVEMBER = 0x400
    SCHED_MONTH_DECEMBER = 0x800

    
    def __init__(self, schedType):
        '''Creates a EPOTaskSchedule of the given type. The types are:
        
            SCHED_TYPE_DAILY
            SCHED_TYPE_WEEKLY
            SCHED_TYPE_MONTHLY
            SCHED_TYPE_ONCE
            SCHED_TYPE_AT_STARTUP
            SCHED_TYPE_AT_LOGIN
            SCHED_TYPE_IDLE
            SCHED_TYPE_RUN_IMMEDIATELY
            SCHED_TYPE_ON_DIALUP        
        '''
        self.sectionSettings  = {}
        self.scheduleSettings = {}
        
        #section settings
        self.sectionSettings["Enabled"] = "1"
        self.sectionSettings["StopAfterMinutes"] = "0"
        
        #Schedule section
        #common settings
        self.scheduleSettings["Type"] = str(schedType)
        self.scheduleSettings["GMTTime"] = "0"
        self.scheduleSettings["RunIfMissed"] = "0"
        self.scheduleSettings["RunIfMissedDelayMins"] = "0"
        self.scheduleSettings["RandomizationEnabled"] = "0"
        self.scheduleSettings["RandomizationWndMins"] = "0"
        self.scheduleSettings["StartDateTime"] = \
            self.getEPODateTimeStr(datetime.datetime.now().replace(hour=12, minute=0, second=0))
            
        #advanced settings
        self.scheduleSettings["StopDateValid"] = "0"
        self.scheduleSettings["TaskRepeatable"] = "0"
        
        if schedType == self.SCHED_TYPE_DAILY:
            self.scheduleSettings["RepeatDays"] = "1"
        elif schedType == self.SCHED_TYPE_WEEKLY:
            self.scheduleSettings["RepeatWeeks"] = "1"
            self.scheduleSettings["MaskDaysOfWeek"] = str(0x01)
        elif schedType == self.SCHED_TYPE_MONTHLY:
            self.scheduleSettings["MonthOption"] = str(self.SCHED_MONTHLY_OPTION_BY_DAY_NUMBER)
            self.scheduleSettings["DayNumOfMonth"] = "1"
            self.scheduleSettings["MaskMonthsOfYear"] = "0"
        elif schedType == self.SCHED_TYPE_IDLE:
            self.scheduleSettings["IdleMinutes"] = "5"
        elif schedType == self.SCHED_TYPE_AT_STARTUP or schedType == self.SCHED_TYPE_AT_LOGIN:
            self.scheduleSettings["AtStartupDelay"] = "5"
        elif schedType == self.SCHED_TYPE_ON_DIALUP:
            self.scheduleSettings["EnableRunTaskOnceADay"] = "1"
        
        return
    
    def setGeneralOptions(self, bUTCTime=False, bRunIfMissed=False, iRunIfMissedDelayMins=0,
                          bRandomizeEnabled=False, iRandomizationMins=0, iStopAfterRunningMins=0):
        '''Set general options for all client task schedules
        
        Input:
            bUTCTime - tasks uses UTC time?
            bRunIfMissed - enable the task to run if missed
            iRunIfMissedDelayMins - number of minutes to wait after missed task before restart
            bRandomizeEnabled - enable task start time randomization
            iRandomizationMins - minutes within which to randomize
            iStopAfterRunningMins - stop the task after running this many minutes
        '''
        self.sectionSettings["StopAfterMinutes"] = str(iStopAfterRunningMins)
        
        self.scheduleSettings["GMTTime"] = "1" if bUTCTime else "0"
        self.scheduleSettings["RunIfMissed"] = "1" if bRunIfMissed else "0"
        self.scheduleSettings["RunIfMissedDelayMins"] = \
                                    iRunIfMissedDelayMins if bRunIfMissed else "0"
        self.scheduleSettings["RandomizationEnabled"] = "1" if bRandomizeEnabled else "0"
        self.scheduleSettings["RandomizationWndMins"] = \
                                    iRandomizationMins if bRandomizeEnabled else "0"
    
    def setStartDateTime(self, dtStartTime):
        '''Sets the start date option for the task to the given datetime object'''
        self.scheduleSettings["StartDateTime"] = self.getEPODateTimeStr(dtStartTime)
        
    def setStopDateTime(self, dtStopTime):
        '''Sets the stop date time option for the task to the given datetime object'''
        self.scheduleSettings["StopDateValid"] = "1"
        self.scheduleSettings["StopDateTime"] = self.getEPODateTimeStr(dtStopTime)
        return
    
    def setDailySettings(self, iRepeatDays):
        '''Set the day repeat interval for Daily tasks'''
        self.scheduleSettings["RepeatDays"] = str(iRepeatDays)
    
    def setWeeklySettings(self, iRepeatWeeks, daysMask):
        '''Set the days of the week for a weekly task.
        
        Input:
            iRepeatWeeks - Run every this many weeks
            iDaysMask - This integer is created by OR'ing together
                        weekday constants like so:
                        
                        setWeeklySettings(2, SCHED_DAY_FRIDAY | SCHED_DAY_MONDAY)'''
        
        self.scheduleSettings["RepeatWeeks"] = str(iRepeatWeeks)
        self.scheduleSettings["MaskDaysOfWeek"] = str(daysMask)
        
    def setMonthlySettings(self, monthMask, monthOption, day, iWeekNum=None):
        '''Set tasks options for monthly tasks
        
        Input:
            monthMask - This integer is created by OR'ing together
                        month constants like so: 
                            
                            SCHED_MONTH_FEBRUARY | SCHED_MONTH_JUNE
                            
            monthOption - Must be SCHED_MONTHLY_OPTION_BY_DAY_NUMBER or
                          SCHED_MONTHLY_OPTION_BY_WEEK_DAY. The former means
                          that the task is set to run on the X'th day of every
                          month as indicated by the day parameter. 
                          
                          The latter means the task will run on a given
                          weekday during week of the month indicated by weekNum.
                          
            day - If monthOption is SCHED_MONTHLY_OPTION_BY_DAY_NUMBER then this
                  parameter must be an integer indicating what day of the month to
                  run the task. i.e. a value of 4 means the fourth day of every month.
                  
                  If monthOption is SCHED_MONTHLY_OPTION_BY_WEEK_DAY then this parameter
                  must be a number between 1 and 7 indicating the day of the week the 
                  task should run, starting with Sunday. i.e. 4 means the task will 
                  run on Wednesdays of the week given by the weekNum parameter.
                  
            iWeekNum - If monthOption is SCHED_MONTHLY_OPTION_BY_WEEK_DAY then this
                      parameter indicates the week of the month during which the
                      task will run. It must be an integer between 1 and 5. 5
                      indicates the last week of the month.
                      
        Examples:
                Run a task the second Thursday of June.
                    setMonthlySettings(SCHED_MONTH_JUNE, SCHED_MONTHLY_OPTION_BY_WEEK_DAY,
                                       SCHED_DAY_THURSDAY, 2)
                                       
                Run a task the 15th day of December
                    setMonthlySettings(SCHED_MONTH_DECEMBER, 
                                       SCHED_MONTHLY_OPTION_BY_DAY_NUMBER, 15)
        '''
        self.scheduleSettings["MaskMonthsOfYear"] = monthMask
        self.scheduleSettings["MonthOption"] = monthOption
        
        if monthOption == self.SCHED_MONTHLY_OPTION_BY_DAY_NUMBER:
            self.scheduleSettings["DayNumOfMonth"] = day
        elif monthOption == self.SCHED_MONTHLY_OPTION_BY_WEEK_DAY:
            self.scheduleSettings["WeekNumOfMonth"] = iWeekNum
            self.scheduleSettings["DayOfWeek"] = day
            
    def setLoginAndStartupSettings(self, iStartupDelay, bRunOnceADay):
        '''Set how many minutes to delay task and whether to run once-a-day'''
        self.scheduleSettings["AtStartupDelayMinutes"] = str(iStartupDelay)
        self.scheduleSettings["EnableRunTaskOnceADay"] = "1" if bRunOnceADay else "0"
        
    def setDialupSettings(self, bRunOnceADay):
        '''Set the once-a-day flag for dial up tasks'''
        self.scheduleSettings["EnableRunTaskOnceADay"] = "1" if bRunOnceADay else "0"
        
    
    def setRepeatOptions(self, repeatOption, repeatInterval, untilOption, untilInterval):
        '''Sets the repeat option for the task
        
        Input:
            repeatOption - must be SCHED_REPEAT_OPTION_MINUTES, self.SCHED_REPEAT_OPTION_HOURS,
                           or SCHED_REPEAT_OPTION_DISABLED
            iInterval - the interval of minutes or hours to repeat
            
            untilOption - must be SCHED_UNTIL_OPTION_TIME or SCHED_UNTIL_OPTION_DURATION
            untilInterval - If untilOption is set to SCHED_UNTIL_OPTION_DURATION, then
                            untilInterval must be an integer for the number of minutes the 
                            task should continue to repeat. Otherwise untilInterval
                            should be datetime object indicating when the repeat period ends.
        '''
        self.scheduleSettings["TaskRepeatable"] = "1"
        self.scheduleSettings["RepeatOption"] = repeatOption
        self.scheduleSettings["RepeatInterval"] = str(repeatInterval)
        self.scheduleSettings["UntilOption"] = untilOption
        
        if untilOption == self.SCHED_UNTIL_OPTION_TIME:
            self.scheduleSettings["UntilTime"] = self.getEPODateTimeStr(untilInterval)
        elif untilOption == self.SCHED_UNTIL_OPTION_DURATION:
            self.scheduleSettings["UntilDuration"] = str(untilInterval)
            
        return
    
    def GetConstFromString(self, strMonthOrDay):
        '''Takes a string for a month or day and returns the appropriate schedule constant'''
        if strMonthOrDay.lower() == "sunday":
            return self.SCHED_DAY_SUNDAY
        if strMonthOrDay.lower() == "monday":
            return self.SCHED_DAY_MONDAY
        if strMonthOrDay.lower() == "tuesday":
            return self.SCHED_DAY_TUESDAY
        if strMonthOrDay.lower() == "wednesday":
            return self.SCHED_DAY_WEDNESDAY
        if strMonthOrDay.lower() == "thursday":
            return self.SCHED_DAY_THURSDAY
        if strMonthOrDay.lower() == "friday":
            return self.SCHED_DAY_FRIDAY
        if strMonthOrDay.lower() == "saturday":
            return self.SCHED_DAY_SATURDAY
        
        if strMonthOrDay.lower() == "january":
            return self.SCHED_MONTH_JANUARY
        if strMonthOrDay.lower() == "february":
            return self.SCHED_MONTH_FEBRUARY
        if strMonthOrDay.lower() == "march":
            return self.SCHED_MONTH_MARCH
        if strMonthOrDay.lower() == "april":
            return self.SCHED_MONTH_APRIL
        if strMonthOrDay.lower() == "may":
            return self.SCHED_MONTH_MAY
        if strMonthOrDay.lower() == "june":
            return self.SCHED_MONTH_JUNE
        if strMonthOrDay.lower() == "july":
            return self.SCHED_MONTH_JULY
        if strMonthOrDay.lower() == "august":
            return self.SCHED_MONTH_AUGUST
        if strMonthOrDay.lower() == "september":
            return self.SCHED_MONTH_SEPTEMBER
        if strMonthOrDay.lower() == "october":
            return self.SCHED_MONTH_OCTOBER
        if strMonthOrDay.lower() == "november":
            return self.SCHED_MONTH_NOVEMBER
        if strMonthOrDay.lower() == "december":
            return self.SCHED_MONTH_DECEMBER
        
        return None        
    
    def getEPODateTimeStr(self, objDateTime):
        '''Returns and epo DB compatible string for the given datetime object'''
        return objDateTime.strftime("%Y%m%d%H%M%S")
        
    def getIBTExtensionString(self):
        '''Return schedule string for the IBT extension for ePO
        
        The returned string can replace the 'Schedule' settings
        of a client task schedule string'''
        
        schedStr = ""
        for (k, v) in self.sectionSettings.iteritems():
            schedStr += "Settings\t" + str(k) + "\t" + str(v) + "`"
            
        for (k, v) in self.scheduleSettings.iteritems():
            schedStr += "Schedule\t" + str(k) + "\t" + str(v) + "`"
                 
        return schedStr 
    
