#!/usr/bin/perl -w
use strict;
use lib 'include';
use MSM::UI;

my $msm_ui = MSM::UI->new();

$msm_ui->open();
$msm_ui->open_preferences();

$msm_ui->quit();

