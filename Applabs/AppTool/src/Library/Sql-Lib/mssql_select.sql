SELECT ResultsID, TestCaseID, TestSuiteID, Result, FailureDetail, Build, AnalysisType, StartTime, EndTime, Date, TestStatus, InitiateType, Timestamp, SessionID FROM adodb_results WHERE (Result = 'fail')