apt_update 'update' do
  action :update
end

apt_package 'ruby' do
  options '--auto-remove'
  action :purge
end

execute 'Setup ChefDK as default ruby' do
  command "echo 'eval \"$(chef shell-init bash)\"' >> /root/.bashrc"
  user 'root'
  environment({ 'HOME' => '/root' })
  not_if "grep 'chef shell-init' /root/.bashrc"
end

include_recipe 'ntp'

include_recipe 'dev-lxc-platform::byobu'

include_recipe 'dev-lxc-platform::helpful-addons'

include_recipe 'dev-lxc-platform::sysdig'

include_recipe 'dev-lxc-platform::btrfs'

include_recipe 'dev-lxc-platform::mount-lxc-btrfs'

include_recipe 'dev-lxc-platform::mount-lxd-btrfs'

include_recipe 'dev-lxc-platform::lxd'

include_recipe 'dev-lxc-platform::lxc-helpful-addons'

include_recipe 'dev-lxc-platform::tinyproxy'

include_recipe 'dev-lxc-platform::dev-lxc'

include_recipe 'dev-lxc-platform::mount-docker-btrfs'

# docker cookbook 2.15.20 has the following bug
# https://github.com/chef-cookbooks/docker/issues/898
#include_recipe 'dev-lxc-platform::docker'

include_recipe 'dev-lxc-platform::habitat'
