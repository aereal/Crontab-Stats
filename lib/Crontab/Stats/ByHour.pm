package Crontab::Stats::ByHour;

use strict;
use warnings;

use Crontab::Stats::Record::Weekday;

sub new {
  my ($class, $jobs) = @_;
  my $self = bless { _weekdays => {} }, $class;

  for my $job (@$jobs) {
    for my $weekday (@{$job->day_of_week->expanded}) {
      for my $hour (@{$job->hour->expanded}) {
        $self->for_weekday($weekday)->for_hour($hour)->incr;
      }
    }
  }

  return $self;
}

sub for_weekday {
  my ($self, $weekday) = @_;
  $self->{_weekdays}->{$weekday} //= Crontab::Stats::Record::Weekday->new($weekday);
}

sub weekdays {
  my ($self) = @_;
  my $keys = [ sort keys %{$self->{_weekdays}} ];
  return [ map { $self->{_weekdays}->{$_} } @$keys ];
}

sub as_series {
  my ($self) = @_;
  my $series = [ map {
    my $weekday = $_;
    map {
      my $hour = $_;
      ['', $hour->hour+0, $weekday->weekday+0, $hour->count+0, $hour->count+0];
    } @{$weekday->hours};
  } @{$self->weekdays} ];
  return $series;
}

1;
