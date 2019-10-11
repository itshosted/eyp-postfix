define postfix::instance(
                                $type,
                                $command,
                                $service = $name,
                                $opts    = {},
                                $args    = [],
                                $private = '-',
                                $unpriv  = '-',
                                $chroot  = '-',
                                $wakeup  = '-',
                                $maxproc = '-',
                                $comment = undef,
                                $order   = '42',
  ) {

  concat::fragment{ "/etc/postfix/master.cf ${service} ${type} ${command}":
    target  => '/etc/postfix/master.cf',
    order   => $order,
    content => template("${module_name}/mastercf/masterservice.erb"),
  }
}
