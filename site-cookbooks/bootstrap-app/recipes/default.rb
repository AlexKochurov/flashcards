bash "create file" do
  user "vagrant"
  code <<-EOC
    cd /home/vagrant/flashcards
    cp config/database.yml.example config/database.yml
    bundle install
    bundle exec rake db:reset

    sudo /usr/local/rbenv/shims/bundle exec foreman export upstart /etc/init -a rails -u vagrant
    sudo service rails start
  EOC
end