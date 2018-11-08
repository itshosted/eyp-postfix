define postfix::headercheck (
                              $action,
                              $regex = $name,
                              $order    = '42',
                            ) {
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  if(!defined(Concat['/etc/postfix/sender_canonical_maps']))
  {
    concat { '/etc/postfix/header_checks':
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package[$postfix::params::package_name],
      notify  => Exec['reload postfix header_checks'],
    }

    concat::fragment{ '/etc/postfix/sender_canonical_maps header':
      target  => '/etc/postfix/sender_canonical_maps',
      order   => '00',
      content => template("${module_name}/generic_header.erb"),
    }

    exec { 'reload postfix header_checks':
      command     => "postmap ${postfix::params::baseconf}/header_checks",
      refreshonly => true,
      notify      => Class['postfix::service'],
      require     => Package[$postfix::params::package_name],
    }

    concat::fragment{ '/etc/postfix/main.cf header_checks':
      target  => '/etc/postfix/main.cf',
      order   => '62',
      content => "\n# header_checks\nheader_checks = hash:/etc/postfix/header_checks\n",
    }
  }

  concat::fragment{ "/etc/postfix/header_checks ${regex} ${action}":
    target  => '/etc/postfix/header_checks',
    order   => $order,
    content => template("${module_name}/header_checks.erb"),
  }

}
