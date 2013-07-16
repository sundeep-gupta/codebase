/************************************************************************
 * ErrorCodes.h - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
 * Copyright (C) 2010 McAfee Inc. All rights reserved. 
 ************************************************************************/
#ifndef ERRORCODES_H
#define ERRORCODES_H
namespace TestAutomationFramework 
{
    enum TAF_ERROR_CODES
    {
        TAF_SUCCESS=1,
        TAF_FAILURE,
        TAF_DUPLICATE_NODE, // When we get an add nodefor a node already present
        TAF_INVALID_NODE, // When we get a add node request and we can't ping it
        TAF_UNKNOWN_NODE, // when we get a delete node for a node which we dont have.
        LAST_ERROR
    };
};
#endif