package Catalyst::Plugin::CDN;

use Moose::Role;
use HTTP::CDN;
use Path::Class;
use HTTP::Date;

=head3 EXPIRES

Approximately 10 years

=cut

use constant EXPIRES => 315_576_000;

around dispatch => sub {
    my $orig = shift;
    my ($c) = @_;

    # TODO - this path match should be using the configurable 'base' below
    if ( $c->req->path =~ m{ \A cdn/ (.*) \z }xms ) {
        my $uri = $1;
        unless ( $uri =~ s/\.([0-9A-F]{12})\.([^.]+)$/\.$2/ ) {
            $c->res->status( 404 );
            $c->res->content_type( 'text/html' );
            return;
        }
        my $hash = $1;
        my $info = eval { HTTP::CDN::dynamic->info($uri) };
        unless ( $info and $info->{hash} eq $hash ) {
            $c->res->status( 404 );
            $c->res->content_type( 'text/html' );
            return;
        }

        if ( $c->log->can('abort') ) {
            $c->log->abort(1);
        }

        $c->res->status( 200 );
        $c->res->content_type( $info->{mime} );
        $c->res->headers->header('Last-Modified' => HTTP::Date::time2str($info->{mtime}));
        $c->res->headers->header('Expires' => HTTP::Date::time2str(time + EXPIRES));
        $c->res->headers->header('Cache-Control' => 'max-age=' . EXPIRES . ', public');
        $c->res->body(HTTP::CDN::dynamic->content($uri));
        return;
    }
    else {
        return $orig->(@_);
    }
};

before setup_finalize => sub {
    my ($c) = @_;


    # TODO - this should be configurable
    my $root = dir($c->config->{home}, 'cdn');

    HTTP::CDN->dynamic_manifest('dynamic', $root, {
        # TODO, this should be better? configurable?
        base => '/cdn/',
    });
};

=head2 cdn

=cut

sub cdn {
    my ($c, $uri) = @_;

    return $c->uri_for(HTTP::CDN::dynamic->uri($uri));
}

1;
__END__
