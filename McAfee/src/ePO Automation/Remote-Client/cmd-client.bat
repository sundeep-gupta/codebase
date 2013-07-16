@echo off

rem %~dp0 is expanded pathname of the current script under NT
set RUN_HOME=%~dp0
if "%RUN_HOME%"=="" set RUN_HOME=.
rem TODO: not using run_home; when this is in the cmd line it doesn't work:  "-Dant.home=%RUN_HOME%"

rem get the cmd line args
set CMD_LINE_ARGS=%1
if ""%1""=="""" goto doneCmdLine
shift
:setupArgs
if ""%1""=="""" goto doneCmdLine
set CMD_LINE_ARGS=%CMD_LINE_ARGS% %1
shift
goto setupArgs
:doneCmdLine

rem TODO: should the ant task just get the classpath instead of the .bat file? That seems a lot easier!
set CP=lib/ant.jar;lib/ant-launcher.jar;lib/activation.jar;lib/axis.jar;lib/orion-remote-client.jar;lib/commons-discovery.jar;lib/saaj.jar;lib/commons-httpclient-3.0.1.jar;lib/commons-codec-1.3.jar;lib/wsdl4j.jar;lib/axis-ant.jar;lib/jaxrpc.jar;lib/commons-logging-api.jar;/lib/clover.jar;lib/orion-core-common.jar
rem set CP=lib/ant.jar;lib/ant-launcher.jar
java.exe -Xms512M -Xmx1000M -classpath "%CP%" com.mcafee.orion.remote.client.CommandClient %CMD_LINE_ARGS%
