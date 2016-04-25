package Crontab::Stats::Record::Hour;

use strict;
use warnings;

sub new {
  my ($class, $hour) = @_;
  my $self = bless { hour => $hour, count => 0 }, $class;
  return $self;
}

sub hour { $_[0]->{hour} }

sub count { $_[0]->{count} }

sub incr {
  my ($self) = @_;
  $self->{count}++;
  return;
}

1;
