#!/bin/sh

CP=lib/ant.jar:lib/ant-launcher.jar:lib/activation.jar:lib/axis.jar:lib/orion-remote-client.jar:lib/commons-discovery.jar:lib/saaj.jar:lib/commons-httpclient-3.0.1.jar:lib/commons-codec-1.3.jar:lib/wsdl4j.jar:lib/axis-ant.jar:lib/jaxrpc.jar:lib/commons-logging-api-1.1.jar:lib/orion-core-common.jar
java -Xms512M -Xmx1000M -classpath "$CP" com.mcafee.orion.remote.client.CommandShellClient $@
