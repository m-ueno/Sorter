package Sorter;

use strict;
use warnings;
use 5.10.0;
use Data::Dumper;
local $Data::Dumper::Indent = 1;
local $Data::Dumper::Terse = 1;

sub new{
#    bless {values=>[]},shift; #この1行で済ませられる
    my $class = shift;
    my $self = bless {values=>[1,2,3]}, $class;
    return $self;
}
sub set_values{
    my ($self, @args) = @_;
    $self->{values} = \@args;
    return $self;
}
sub get_values{
    my $self = shift;
    return @{ $self->{values} };          # デリファレンス
}
sub sort{
    my $self = shift;
    $self->{values} = [ qsort(@{ $self->{values} })]; # ソートして代入
}
sub qsort{
#    say "qsort",Dumper @_; #reference to array
    say "qsort";
    say Dumper @_;
    return () if not @_;
    say "qsort2";
    my $pivot = shift @_;
    say "pivot: ",$pivot,' @_ ', Dumper @_;
    return ($pivot) if not (@_);

    my (@l,@r);
    foreach my $i (@_){
        ($i<=$pivot)? push(@l,$i) : push(@r,$i);
    say "l:",@l," r:",@r;
    }
    return (qsort(@l), $pivot, qsort(@r));
}

my $s = Sorter->new;
say "initial value", Dumper $s->{values};

$s->set_values(5,4,3,2,1,2,3,4,5);

say "get_values", Dumper $s->get_values();
$s->sort();

my @ans = $s->get_values();
say "get_values(after)", Dumper [@ans];

