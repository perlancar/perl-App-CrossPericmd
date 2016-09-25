package App::CrossPericmd;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

our %SPEC;

$SPEC{cross} = {
    v => 1.1,
    summary => 'Output the cross product of two or more sets',
    description => <<'_',

This is more or less the same as the `cross` CLI on CPAN (from
`Set::CrossProduct`) except that this CLI is written using the
`Perinci::CmdLine` framework. It returns table data which might be more easily
consumed by other tools.

_
    args => {
        aoaos => {
            schema => ['array*', of=>{
                ['array*', of=>'str*',
                 'x.perl.coerce_rules' => ['str_comma_sep']],
            }],
            req => 1,
            pos => 0,
            greedy => 1,
        },
    },
};
sub cross {
    require Set::CrossProduct;

    my %args = @_;

    my $iter = Set::CrossProduct->new($args{aoaos});
    my @res;
    while (my $tuple = $iter->get) {
        push @res, $tuple;
    }

    [200, "OK", \@res];
}

1;
#ABSTRACT:
