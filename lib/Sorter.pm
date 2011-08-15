package Sorter;
use strict;
use warnings;
sub new{
    my ($class) = @_;
    bless { values=>[] }, $class;
}
sub set_values{
    my ($self, @nums) = @_;
    $self->{values} = \@nums;
    return $self;
}
sub get_values{
    my ($self) = @_;
    return @{ $self->{values} };
}
sub sort{
    my ($self) = @_;
    $self->{values} = $self->_sort( $self->{values} );
}
sub _sort{
    # quicksort
    my ($self,$nums) = @_;
    return [] if not @$nums;
    my $pivot = shift @$nums;

    return [$pivot] if not @$nums;

    my (@l,@r);
    foreach my $i (@$nums) {
        ($i<=$pivot) ? push(@l,$i) : push(@r,$i);
    }
    return [ @{ $self->_sort([@l]) },
             $pivot,
             @{ $self->_sort([@r]) } ];
}
# ----------------
package Sorter::BubbleSorter;
our @ISA = qw(Sorter);
sub _sort{
    my ($self,$nums) = @_;
    return [] if not @$nums;

    my $temp;
    for my $i (0..$#$nums){
        for my $j ($i+1..$#$nums){
            if ( $nums->[$i] > $nums->[$j] ) {
                $temp = $nums->[$i];
                $nums->[$i] = $nums->[$j];
                $nums->[$j] = $temp;
            }
        }
    }
    $nums;
}
# ----------------
package Sorter::MergeSorter;
use Data::Dumper;
our @ISA = qw(Sorter);

sub _sort{
    my ($self,$nums) = @_;
    my $len = @$nums;
    my $mid = int($len/2);
    if ( $len==2 ) {
        my ($a,$b) = @$nums;
        ($a<$b ? return [$a,$b] : return [$b,$a]);
    }elsif( $len==1 ){
        return $nums;                   #ref
    }elsif( $len == 0 ){
        return [];
    }
    _merge( $self->_sort( [@$nums[0..$mid]]    ),
            $self->_sort( [@$nums[$mid+1..$len-1]] ));
}

# _merge: 配列リファレンス2つ -> 配列リファレンス1つ
sub _merge{
    my ($a,$b) = @_;
    my @ret = ();
    my @a = @$a;                        # 疑問
    my @b = @$b;

    # merge部分
    while (@a && @b) {
        if( $a[0] < $b[0] ){
            push( @ret, shift @a );
        } else {
            push( @ret, shift @b );
        }
    }
    return [@ret, @b] if not @a;
    return [@ret, @a] if not @b;
    warn "error";
}
# ----------------
package Main;
use strict;
use warnings;
use 5.10.0;
use Data::Dumper;
local $Data::Dumper::Indent = 1;
local $Data::Dumper::Terse = 1;

sub test{
    # say "Sorter";
    # my $s = Sorter->new;

    # say "BubbleSorter";
    # my $s = Sorter::BubbleSorter->new;
    say "MergeSorter";
    my $s = Sorter::MergeSorter->new;

    $s->set_values();

    say Dumper "get_values", [$s->get_values()];

    $s->sort();
    say Dumper "dbg_test", $s->{values};

    my @ans = $s->get_values();
    say Dumper "get_values(after)", [@ans];
}

#test();

1;
