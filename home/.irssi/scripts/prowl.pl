#   Copyright 2011 Josh Kearney
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

use strict;
use warnings;

use Irssi;
use LWP::Simple;
use vars qw($VERSION %IRSSI);

$VERSION = "0.0.1";

%IRSSI = (
    authors => "Josh Kearney",
    contact => "josh\@jk0.org",
    name => "irssi-prowl",
    description => "Send Prowl notifications upon new mentions or PMs when away.",
    license => "Apache License, Version 2.0",
    url => "https://github.com/jk0/irssi-prowl"
);

sub is_away {
    my ($server) = @_;

    return $server->{usermode_away} ? 1 : 0;
}

sub msg_public {
    my ($server, $data, $nick, $mask, $target) = @_;

    if(is_away($server) && ($data =~ /$server->{nick}/i)) {
        send_notification($server->{chatnet}, "[$target:$nick] $data");
    }
}

sub msg_private {
    my ($server, $text, $nick, $host, $channel) = @_;

    if(is_away($server)) {
        send_notification($server->{chatnet}, "[$nick] $text");
    }
}

sub send_notification {
    my ($chatnet, $notice) = @_;
    my $enabled = Irssi::settings_get_bool("prowl_enabled");
    my $api_key = Irssi::settings_get_str("prowl_api_key");

    return unless($enabled && (length($api_key) > 0));

    $notice =~ s/([^A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg;

    my $url = sprintf("http://prowlapp.com/publicapi/add?apikey=%s&"
                      . "application=Irssi&event=%s&description=%s",
                      $api_key, $chatnet, $notice);
    get($url);
}

sub proxy_connect {
    my (@servers) = Irssi::servers();

    foreach my $server (@servers) {
        if(is_away($server)) {
            $server->command("AWAY -one");
        }
    }
}

sub proxy_disconnect {
    my (@servers) = Irssi::servers();
    my $away_msg = Irssi::settings_get_str("prowl_away_msg");

    foreach my $server (@servers) {
        if(!is_away($server)) {
            $server->command("AWAY -one $away_msg");
        }
    }
}

Irssi::settings_add_str("prowl", "prowl_api_key", "");
Irssi::settings_add_str("prowl", "prowl_away_msg", "afk");
Irssi::settings_add_bool("prowl", "prowl_enabled", 0);

Irssi::signal_add_last("message public", "msg_public");
Irssi::signal_add_last("message private", "msg_private");
Irssi::signal_add_last("proxy client connected", "proxy_connect");
Irssi::signal_add_last("proxy client disconnected", "proxy_disconnect");
