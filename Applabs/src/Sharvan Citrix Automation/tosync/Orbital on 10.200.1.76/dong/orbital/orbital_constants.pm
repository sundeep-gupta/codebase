#!/usr/bin/perl -w

use strict;

######################################################################
#
# This file holds all system constants and settings
#
######################################################################

use constant TRUE => 1;
use constant FALSE => 0;

use constant UP_LEFT_BUTTON  =>  "a";
use constant UP_RIGHT_BUTTON   		=>  "b";
use constant BOTTOM_LEFT_BUTTON  	=>  "c";
use constant BOTTOM_RIGHT_BUTTON   	=>  "d";

#use constant RPC_URL => "http://localhost:2050/RPC2";
use constant DONG_HOST => "http://10.200.38.50:2050/RPC2";
use constant DEBUG => TRUE;
use constant BACKLIGHT_OFF_TIME => 600;

use constant FRONT_PAGE_NORMAL_IMAGE => "front_page_boxed.bmp";
use constant FRONT_PAGE_ERROR_IMAGE => "front_page_boxed_error.bmp";


1;
