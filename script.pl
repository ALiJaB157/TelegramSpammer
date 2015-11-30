#!/usr/bin/env perl -w
use strict;
use warnings;

use Data::Random::WordList;
use Data::Random qw(:all);
use WWW::Telegram::BotAPI;
use Data::Dumper;

my $api = WWW::Telegram::BotAPI->new (
    token => '144666850:AAEzPUXg6_nd56RShh6eQXgxZkO07jhgjjKpY'
);

my $wl = new Data::Random::WordList( wordlist => 'words' );
for (my $j=0;$j<100;$j++){
  my @randWords = rand_words( wordlist=> $wl, min => 5, max => 10 );
  my $str='';
  for (my $i=0;$i<@randWords;$i++){
    if ($i>0 && $i<@randWords-1){
        if (int(rand(4))==0){
            $str .= "pipin";
        }
        if(int(rand(2))==0){
            $str .= " ";
        }
    }
    $str .= $randWords[$i];
  }
  $str.="$str\n";
  print $str;
  $api->sendMessage ({
      chat_id => 1231332,
      text    => $str
  }, sub {
      my ($ua, $tx) = @_;
      die "Something bad happened!" unless $tx->success;
      say $tx->res->json->{ok} ? "YAY!" : ":(";
  });
}
$wl->close();
