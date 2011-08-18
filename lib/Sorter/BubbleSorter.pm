package Sorter::BubbleSorter;
use base qw(Sorter);

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

1;
