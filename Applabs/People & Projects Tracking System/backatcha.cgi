#!/usr/local/bin/perl

use CGI ':standard';

    print header();
    print start_html();

    for $i (param()) {
        print "<b>", $i, "</b>: ", param($i), "<br>\n";
    }

    print end_html();

