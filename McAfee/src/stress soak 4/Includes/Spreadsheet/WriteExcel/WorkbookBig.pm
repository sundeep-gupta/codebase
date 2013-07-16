package Spreadsheet::WriteExcel::WorkbookBig;

###############################################################################
#
# WorkbookBig - A writer class for Excel Workbooks > 7MB.
#
#
# Used in conjunction with Spreadsheet::WriteExcel
#
# Copyright 2000-2004, John McNamara and Kawai Takanori.
#
# Documentation after __END__
#

use Exporter;
use strict;
use Carp;
use Spreadsheet::WriteExcel::Workbook;
use OLE::Storage_Lite;
use Spreadsheet::WriteExcel::Worksheet;
use Spreadsheet::WriteExcel::Format;


use vars qw($VERSION @ISA);
@ISA = qw(Spreadsheet::WriteExcel::Workbook Exporter);

$VERSION = '2.01';

###############################################################################
#
# new()
#
# Constructor. Creates a new WorkbookBig object from a Workbook object.
#
sub new {

    my $class = shift;
    my $self  = Spreadsheet::WriteExcel::Workbook->new(@_);

    bless $self, $class;
    return $self;
}


###############################################################################
#
# _store_OLE_file(). Over-ridden.
#
# Store the workbook in an OLE container using OLE::Storage_Lite.
#
sub _store_OLE_file {

    my $self = shift;

    my $tmp;
    my $OLE = OLE::Storage_Lite::PPS::File->newFile(
                                           OLE::Storage_Lite::Asc2Ucs('Book'));


    $OLE->append($tmp) while $tmp = $self->get_data();

    foreach my $worksheet (@{$self->{_worksheets}}) {
        $OLE->append($tmp) while $tmp = $worksheet->get_data();
    }

    my @ltime = localtime();
    splice(@ltime, 6);
    my $date = OLE::Storage_Lite::PPS::Root->new(\@ltime, \@ltime,[$OLE,]);
    $date->save($self->{_filename});
}


1;


__END__


=head1 NAME

WorkbookBig - A writer class for Excel Workbooks > 7MB.


=head1 SYNOPSIS

See the documentation for Spreadsheet::WriteExcel.


=head1 DESCRIPTION

This module is used in conjunction with Spreadsheet::WriteExcel.

It is a sub-class of the Spreadsheet::WriteExcel::Workbook module.


=head1 REQUIREMENTS

IO::Stringy and OLE::Storage_Lite


=head1 AUTHORS

John McNamara jmcnamara@cpan.org

Kawai Takanori kwitknr@cpan.org


=head1 COPYRIGHT

� MM-MMIV, John McNamara and Kawai Takanori.

All Rights Reserved. This module is free software. It may be used, redistributed and/or modified under the same terms as Perl itself.
