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
# ----------------

1;
