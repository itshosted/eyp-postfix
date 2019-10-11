class postfix::service(
                        $ensure                = 'running',
                        $manage_service        = true,
                        $manage_docker_service = true,
                        $enable                = true,
                      ) inherits postfix::params {

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
    $manage_docker_service)
  {
    if($manage_service)
    {
      service { 'postfix':
        ensure  => $ensure,
        enable  => $enable,
        require => Package['postfix'],
      }
    }
  }
}
