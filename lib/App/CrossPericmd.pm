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
            'x.name.is_plural' => 1,
            'x.name.singular' => 'aos',
            schema => ['array*', {
                min_len => 2,
                of => ['array*', {
                    of => 'str*',
                    'x.perl.coerce_rules' => ['str_comma_sep']
                }],
            }],
            req => 1,
            pos => 0,
            greedy => 1,
        },
    },
    examples => [
        {
            argv => ['1,2,3','4,5'],
        },
        {
            src => '[[prog]] 1,2,3 4,5 --json',
            src_plang => 'bash',
            summary => 'Same as previous example, but output JSON',
        },
        {
            src => '[[prog]] 1,2 foo,bar --format json-pretty --naked-res',
            src_plang => 'bash',
        },
    ],
    links => [
        {url=>'prog:cross', summary => 'The original script'},
        {url=>'prog:setop', summary => 'Can also do cross product aside from other set operations'},
    ],
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
