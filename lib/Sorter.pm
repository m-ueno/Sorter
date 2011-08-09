package Sorter;
use strict;
use warnings;

sub new{
#    bless {values=>[]},shift; #この1行で済ませられる
    my ($class) = @_;
    bless {values=>[]}, $class;
}
sub set_values{
    my ($self, @nums) = @_;
    $self->{values} = \@nums;           # [@nums]でも同じ
    return $self;
}
sub get_values{
    my ($self) = @_;
    return @{ $self->{values} };          # デリファレンス=>配列
}
sub sort{
    my $self = shift;
    $self->{values} = [ _sort(@{ $self->{values} })];
}
sub _sort{
    return () if not @_;
    my $pivot = shift;

    return ($pivot) if not (@_);

    my (@l,@r);
    foreach my $i (@_){
        ($i<=$pivot) ? push(@l,$i) : push(@r,$i);
    }
    return( _sort(@l), $pivot, _sort(@r) );
}

package Sorter::BubbleSorter;
our @ISA = qw(Sorter);  # メソッド探索が行われるようになる
sub _sort{
    return () if not @_;
    my @nums = @_;
    for( my $i=0;$i<@nums;$i++ ){
        for( my $j=$i;$j<@nums;$j++ ){
            if( $nums[$i] > $nums[$j] ){
                my $temp = $nums[$i];
                $nums[$i] = $nums[$j];
                $nums[$j] = $temp;
            }
        }
    }
}
package Sorter::MergeSorter;
our @ISA = qw(Sorter);
sub _sort{
    my $len = length @_;
    my $mid = int($len/2);

    if( $len<=2 ){
        my ($a,$b) = @_;
        $a<$b ? return ($a,$b) : return ($b,$a);
    }
    _merge( _sort(@_[0..$mid]),
            _sort(@_[$mid..$len-1]) )
}
sub _merge{                             # 配列2つ→配列1つ
    my (@a,@b) = @_;
    my @ret=();
    my ($head_a, $head_b);
    while(@a && @b){
        return (@ret, @b) if not (@a);
        return (@ret, @a) if not (@b);
        $head_a ||= shift @a;
        $head_b ||= shift @b;
        if( $head_a<$head_b ){
            push @ret,$head_a;
            $head_a = shift @a;
        }else{
            push @ret,$head_b;
            $head_b = shift @b;
        }
    }
}

# ----------------------------------------------------------------
package Main;
use strict;
use warnings;
use 5.10.0;
use Data::Dumper;
local $Data::Dumper::Indent = 1;
local $Data::Dumper::Terse = 1;

sub test{
    say "Sorter::MergeSorter";
    my $s = Sorter::MergeSorter->new;

    $s->set_values(5,4,3,2,1,2,3,4,5);
    say Dumper "get_values", [$s->get_values()];

    $s->sort();

    my @ans = $s->get_values();
    say Dumper "get_values(after)", [@ans];
}

#test();

1;
