package cfd_trading_club::View::MHTML;

use strict;
use warnings;

use parent 'Catalyst::View::Mason';

__PACKAGE__->config(
    use_match => 0,
    comp_root => cfd_trading_club->path_to('templates'),
    template_extension => '.mhtml',
);

=head1 NAME

cfd_trading_club::View::MHTML - Mason View Component for cfd_trading_club

=head1 DESCRIPTION

Mason View Component for cfd_trading_club

=head1 SEE ALSO

L<cfd_trading_club>, L<HTML::Mason>

=head1 AUTHOR

Zane Moser,,,

=head1 LICENSE

This library is free software . You can redistribute it and/or modify it under
the same terms as perl itself.

=cut

1;
