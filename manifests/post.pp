class firewall_rules::post {

	firewallchain { 'INPUT:filter:IPv4':
	  purge  => true,
	  ignore => [
		 # ignore the fail2ban jump rule
		 '-j fail2ban-ssh',
		 # ignore any rules with "ignore" (case insensitive) in the comment in the rule
		 '--comment "[^"](?i:ignore)[^"]"',
		 ],
	}->

	firewall { '900 log all drop connections':
		proto   => 'all',
		jump  => 'LOG',
		limit => '5/min',
		log_prefix => 'IPTables-Rejected: ',
	}->

	firewall { '950 drop udp':
		proto   => 'udp',
		reject => 'icmp-port-unreachable',
		action  => 'reject',
	}->

	firewall { '951 drop tcp':
		proto   => 'tcp',
		reject => 'tcp-reset',
		action  => 'reject',
	}->

	firewall { '952 drop icmp':
		proto   => 'icmp',
		action  => 'drop',
	}->

	firewall { '999 drop everything else - this is the failsafe rule':
		proto   => 'all',
		action  => 'drop',
		before  => undef,
	}

}