class firewall_rules {
	resources { "firewall":
		purge => true
	}
	Firewall {
		before  => Class['firewall_rules::post'],
		require => Class['firewall_rules::pre'],
	}
	class { ['firewall_rules::pre', 'firewall_rules::post']: }
	class { 'firewall': }

	class { 'denyhosts': }
}