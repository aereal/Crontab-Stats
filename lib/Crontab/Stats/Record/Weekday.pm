package Crontab::Stats::Record::Weekday;

use strict;
use warnings;

use List::Util ();

use Crontab::Stats::Record::Hour;

sub new {
  my ($class, $weekday) = @_;
  my $self = bless { weekday => $weekday, _hours => {} }, $class;
  return $self;
}

sub weekday { $_[0]->{weekday} }

sub for_hour {
  my ($self, $hour) = @_;
  return $self->{_hours}->{$hour} //= Crontab::Stats::Record::Hour->new($hour);
}

sub hours {
  my ($self) = @_;
  my $keys = [ sort keys %{$self->{_hours}} ];
  return [ map { $self->{_hours}->{$_} } @$keys ];
}

sub count {
  my ($self) = @_;
  return List::Util::sum map { $_->count } @{$self->hours};
}

1;
