/************************************************************************
* ServerConfigData.h - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
* Copyright (C) 2010 McAfee Inc. All rights reserved. 
************************************************************************/


#include <string>
using namespace std;

namespace TestAutomationFramework
{
/** \brief This class will capture al lthe prefernece items of the 
     server */
     
class ServerConfigData
{
    public:

    /** \brief Empty constructor */
    ServerConfigData(){}
    
    /** \brief Empty Destructor */
    ~ServerConfigData(){}
    
    /** \brief returns the port number*/
    int getServerPort()
    {
        return m_serverPort;
    }
    
    /** \brief sets the port number*/
    void setServerPort(int port)
    {
        m_serverPort = port;
    }
     /** \brief returns the port ip*/
    string getServerIP()
    {
        return m_serverIP;
    }
    
    /** \brief sets the IP*/
    void setServerIP(string ip)
    {
        m_serverIP = ip;
    }   
    /** \brief gets the testlink URL*/
    string getTestLinkURL()
    {
        return m_testLinkURL;
    }
    
    /** \brief set Testlink URL*/
    void setTestLinklURL(string url)
    {
        m_testLinkURL=url;
    }
    /** \brief gets the SVN username*/
    string getSVNUsername()
    {
        return m_svnUsername;
    }
    
    /** \brief set SVN username*/
    void setSVNUsername(string user)
    {
        m_svnUsername=user;
    }
    /** \brief gets the SVN passwd*/
    string getSVNPassword()
    {
        return m_svnPasswd;
    }
    
    /** \brief set SVN username*/
    void setSVNPassword(string pass)
    {
        m_svnPasswd=pass;
    }
    /** \brief returns the log level*/
    int getLogLevel()
    {
        return m_logLevel;
    }
    
    /** \brief sets the log level*/
    void setLogLevel(int level)
    {
        m_logLevel = level;
    }
    private:
    
    /** \brief servers port num */
    int m_serverPort;
    
     /** \brief servers ip */
    string m_serverIP;
    
    /** \brief testlink URL */
    string m_testLinkURL;
    
    /** \brief log level */
    int m_logLevel;
    
    /** \brief SVN user name */
    string m_svnUsername;
    
    /** \brief SVN passwd */
    string m_svnPasswd;
    
};
};