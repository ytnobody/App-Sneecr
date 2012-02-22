package App::Sneecr;
use strict;
use warnings;
our $VERSION = '0.01';

use JSON;
use Data::DPath qw( dpath );

sub new { bless { json => JSON->new->utf8 }, __PACKAGE__ };

sub json { shift->{json} };

sub search {
    my ( $self, $data, @pathes ) = @_;
    unless ( @pathes ) {
        return $self->json->pretty->encode( $self->json->decode( $data ) );
    }
    else {
        my @rtn;
        my $hashref = $self->json->decode( $data );
        for my $path ( @pathes ) {
            push @rtn, $self->json->pretty->encode( $hashref ~~ dpath $path );
        }
        return @rtn;
    }
}

1;
__END__

=head1 NAME

App::Sneecr - JSON walker tool and library

=head1 SYNOPSIS

  use App::Sneecr;
  my $sneecr = App::Sneecr->new;
  my @jsons = $sneecr->search( $json, '/user/name', '/*/items/name' );

=head1 DESCRIPTION

App::Sneecr is a tool as sneaker shoes for walking on JSON data.

=head1 METHODS 

=head2 new

A constructor-method.

=head2 search

A method for searching elements that matched specified DPath from json-data.

 @matched_json_string = $sneecr->search( $source_json_string, @search_dpath_list );

See Data::DPath for DPath syntax.

=head1 COMMAND-LINE INTERFACE

App::Sneecr provides "sneecr" as command-line inteface.

=head2 USAGE

 sneecr [DPath-List]

sneecr reads json-data from STDIN.

See Data::DPath for DPath syntax.

=head2 EXAMPLE

 sneecr /*/items/name /*/user/name < some.json

=head1 AUTHOR

satoshi azuma E<lt>ytnobody at gmail dot comE<gt>

=head1 SEE ALSO

Data::DPath

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
