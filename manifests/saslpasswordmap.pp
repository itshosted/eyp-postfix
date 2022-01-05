define postfix::saslpasswordmap(
                            $destination = undef,
                            $username    = undef,
                            $password    = undef,
                            $order       = '55',
                          ) {

  concat::fragment{ "${postfix::smtp_sasl_password_maps} ${destination} ${username} ${password}":
    target  => $postfix::smtp_sasl_password_maps,
    order   => $order,
    content => template("${module_name}/sasl_password_map.erb"),
  }
}
