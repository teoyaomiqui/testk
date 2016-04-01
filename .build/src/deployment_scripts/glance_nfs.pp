notice('MODULAR: glance_nfs.pp')
$glance_nfs = hiera('glancenfs', {})
$server_ip = pick($glance_nfs['server_ip'], {})
$path_to_mnt = pick($glance_nfs['path_to_mnt'], {})
$glance = ['glance-registry', 'glance-api']

package { 'nfs-common':
    ensure  => installed,
}

service { $glance:
    ensure  => 'running',
}

file { '/var/lib/glance/images':
    ensure  => 'directory',
    owner   => 'glance',
    group   => 'glance',
    mode    => '0755',
}

mount { '/var/lib/glance/images':
    require => [
      Package['nfs-common'],
      File['/var/lib/glance/images'],
      ],
    device  => "$server_ip:$path_to_mnt",
    fstype  => "nfs",
    ensure  => "mounted",
    options => "defaults",
    atboot  => "true",
}
Glance_api_config<||> ~> Service['glance-api']
glance_api_config {
    'glance_store/filesystem_store_datadir':     value   => '/var/lib/glance/images';
    'glance_store/default_store':                value   => 'file';
    'glance_store/stores':                       value   => 'file,http';
}

