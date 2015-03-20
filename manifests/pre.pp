class firewall_rules::pre {

	Firewall {
		require => undef,
	}

	# Default firewall rules
	firewall { '000 accept all icmp':
		proto   => 'icmp',
		action  => 'accept',
	}

	firewall { '001 accept all to lo interface':
		proto   => 'all',
		iniface => 'lo',
		action  => 'accept',
	}

	firewall { '002 accept related established rules':
		proto   => 'all',
		state   => ['RELATED', 'ESTABLISHED'],
		action  => 'accept',
	}

	firewall { '010 allow ssh from all':
		dport   => '22',
		proto  => 'tcp',
		action => 'accept',
	}

	define firewall_rule_all_from_ip {
		firewall { "011 allow traffic from ip: ${name}":
			proto  => 'all',
			action => 'accept',
			source => "${name}",
		}
	}

	$allowed_hosts = hiera('firewall::allowed_hosts', [])
	firewall_rule_all_from_ip { $allowed_hosts: }

}