class firewall_rules {
	Firewall {
		before  => Class['firewall_rules::post'],
		require => Class['firewall_rules::pre'],
	}
	class { ['firewall_rules::pre', 'firewall_rules::post']: }
	class { 'firewall': }

	class { 'fail2ban':
		bantime => 86400,
		config_file_source => template("fail2ban/${::lsbdistcodename}/etc/fail2ban/jail.conf.erb"),
	}
}