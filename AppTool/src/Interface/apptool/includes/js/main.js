//
// Copyright:     AppLabs Technologies, 2006
// Created By:    Author: Jason Smallcanyon $
// Revision:      $Revision: $
// Last Modified: $Date: $
// Modified By:   $Author: $
// Source:        $Source: $
//


//
// Define global date/time variables.
//

DaysofWeek = new Array()
DaysofWeek[0] = "Sunday"
DaysofWeek[1] = "Monday"
DaysofWeek[2] = "Tuesday"
DaysofWeek[3] = "Wednesday"
DaysofWeek[4] = "Thursday"
DaysofWeek[5] = "Friday"
DaysofWeek[6] = "Saturday"

Months = new Array()
Months[0] = "January"
Months[1] = "February"
Months[2] = "March"
Months[3] = "April"
Months[4] = "May"
Months[5] = "June"
Months[6] = "July"
Months[7] = "August"
Months[8] = "September"
Months[9] = "October"
Months[10] = "November"
Months[11] = "December"

var dayVal;
var timeVal = new Date();
var m = timeVal.getMinutes();
var h = timeVal.getHours();
var fixed_hour = fixPMHours(h);
var da = timeVal.getDate();
var mo = timeVal.getMonth();

if (document.selection) {
    var year = timeVal.getYear();            // Internet Explorer, Opera
}
else {
    var year = timeVal.getYear() + 1900;     // Netscape Navigator
}

var showDay = DaysofWeek[timeVal.getDay()];
var showMonth = Months[timeVal.getMonth()];
var fixed_minute = fixNumber(m);
var the_time = fixed_hour + ":" + fixed_minute;
var the_date = (showDay+",&nbsp;&nbsp;"+showMonth+"&nbsp;"+da+",&nbsp;&nbsp;"+year+"");

// Define our stop clock variables
var timerID = null;
var timerRunning = false;
var secondsElapsed = 0;

//
// Define date/time functions.
//

function fixNumber(the_number) {
    if (the_number < 10) {
        the_number = "0" + the_number;
    }
    return the_number;
}

function fixPMHours(the_number) {
    if (the_number > 12) {
        the_number = the_number - 12;
    }
    return the_number;
}

function showYear() {
    document.write(year);
}

function showLongDate() {
    document.write(the_date);
}

function startclock() {
    // Make sure the clock is stopped
    stopclock();
    showtime();
}

function stopclock() {
    if (timerRunning) {
        clearTimeout(timerID);
    }
    timerRunning = false;
}

function showtime() {
    var hours   = Math.floor(secondsElapsed / 3600);
    var remainingTime = secondsElapsed - hours * 3600;
    var minutes = Math.floor(secondsElapsed / 60);
    var seconds = remainingTime - minutes * 60;
    var timeValue = "" + ((hours < 10) ? "0" : "") + hours;
    timeValue += ((minutes < 10) ? ":0" : ":") + minutes;
    timeValue += ((seconds < 10) ? ":0" : ":") + seconds;
    
    document.clockform.clocktimer.value = timeValue;
    
    timerID = setTimeout("showtime()",1000);
    secondsElapsed++;
    timerRunning = true;
}
