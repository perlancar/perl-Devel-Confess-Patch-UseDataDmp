package Devel::Confess::Patch::UseDataDmp;

# DATE
# VERSION

use 5.010001;
use strict;
no warnings;

use Module::Patch 0.12 qw();
use base qw(Module::Patch);

our %config;

sub patch_data {
    return {
        v => 3,
        patches => [
            {
                action      => 'replace',
                #mod_version => qr/^/,
                sub_name    => '_ref_formatter',
                code        => sub {
                    require Data::Dmp;
                    local $SIG{__WARN__} = sub {};
                    local $SIG{__DIE__} = sub {};
                    no warnings 'once';
                    local $Data::Dmp::OPT_REMOVE_PRAGMAS = 1;
                    Data::Dmp::dmp($_[0]);
                },
            },
        ],
   };
}

1;
# ABSTRACT: Use Data::Dmp to stringify reference

=for Pod::Coverage ^()$

=head1 SYNOPSIS

 % PERL5OPT=-MDevel::Confess::Patch::UseDataDmp -MDevel::Confess=dump yourscript.pl


=head1 DESCRIPTION



=head1 SEE ALSO
