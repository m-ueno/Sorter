package Sorter::MergeSorter;
use Data::Dumper;
use base qw(Sorter);
#our @ISA = qw(Sorter);

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

1;

