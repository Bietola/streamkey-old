#!/usr/bin/env perl

use Modern::Perl '2015';
use autodie;

# TODO: Replace with config file
my %sym2press = (
    '1' => 'super+1',
    '2' => 'super+2',
    '3' => 'super+3',
    '4' => 'super+4',
    '5' => 'super+5',
);

my $key_re = qr/Key\((?<text>.*)\)/;

while (my $line = <STDIN>) {
    chomp $line;

    if ($line =~ /$key_re/) {
        say "key event: $line, [$+{text}]";

        my $text = $+{text};
        my $to_press;

        if ($text =~ /[a-zA-Z]+/) {
            $to_press = $text;
        } else {
            $to_press = $sym2press{$text} // 'NONE';
        }

        say "text: $text; pressing: $to_press";

        if ($to_press ne 'NONE') {
            `xdotool key $to_press`;
        }
    }
}
