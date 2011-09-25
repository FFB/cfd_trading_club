package cfd_trading_club::Model::DB;
#use Moose;
#use namespace::autoclean;

use strict;
use warnings;
use parent 'Catalyst::Model::DBI';

__PACKAGE__->config(
    options       => {
        RaiseError      => 1,
        AutoCommit      => 1,
        PrintError      => 0,
        pg_enable_utf8  => 1,
    },
);

#extends 'Catalyst::Model';

=head1 NAME

cfd_trading_club::Model::DB - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=head1 AUTHOR

Zane Moser,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
