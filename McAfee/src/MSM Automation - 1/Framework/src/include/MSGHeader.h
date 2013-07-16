/************************************************************************
 * MSGHeader.h - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
 * Copyright (C) 2010 McAfee Inc. All rights reserved. 
 ************************************************************************/
#ifndef MSGHEADER_H
#define MSGHEADER_H
#include <stddef.h>
namespace TestAutomationFramework
{
    /*! All the messages types supported by TAF */
    enum MessageType
    {
        NODE_ADDITION_REQUEST=1, /* Node object of TestNode will be sent to Harness server*/
        NODE_ADDITION_RESPONSE,  /* bool value will be sent */
        NODE_DELETION_REQUEST,  /* host name will be sent which one to be deleted*/
        NODE_DELETION_RESPONSE,  /* bool value will be sent */
        NODE_LIST_REQUEST,    /* CLI will make the request with Message type with no data*/
        NODE_LIST_RESPONSE,   /* TestNodeDetails Object will be responded by Harness server*/
        START_TEST_REQUEST,   /* CLI will send TestNode Execution  object will be sent to Harness server*/
        START_TEST_RESPONSE,  /* TestRun stats  object will be returned */
        STOP_TEST_REQUEST,    /* send the run ID to stop*/
        STOP_TEST_RESPONSE,    /* bool value  will be the responce*/
        LIST_TESTS_REQUEST,    /* CLI will make the request with Message type with no data*/
        LIST_TESTS_RESPONSE,   /* Object of TestRunStats will be returned*/
        SERVER_CONFIG_REQUEST,  /* Structure of Testlink Server IP and or SMTP IP */
        SERVER_CONFIG_RESPONSE, /* bool value*/
        INVALID_TYPE   /*invalid request type*/
        
    };
    /*! \brief This will be the preambple for any IPC comm to and from FMP. */
    class MSGHeader
    {

        public :
        MSGHeader():
            m_type(INVALID_TYPE),
            m_dataSize(0),
            m_hdrMagic(0x1234)
        {
        }
        MessageType m_type;
        size_t m_dataSize;
        int m_hdrMagic;
    };
}
#endif
