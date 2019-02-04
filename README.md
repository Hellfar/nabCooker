# README

## System dependencies

```
sudo apt-get install nginx nodejs git build-essential libffi-dev libssl-dev libreadline-dev zlib1g-dev libsqlite3-dev libpq-dev
```

## Install Ruby

Do not install Ruby from your package manager, use RBEnv or RVM.

```
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
git clone https://github.com/maljub01/rbenv-bundle-exec.git ~/.rbenv/plugins/rbenv-bundle-exec
source ~/.bash_profile

# Installe Ruby
rbenv install 2.3.0
rbenv global 2.3.0
```

## Application dependencies

```
gem install bundler --no-ri
bundle install
```
## Database creation and initialization

```
rake db:create
rake db:migrate
rake db:seed
```

## Local server

```
rails server -b 0.0.0.0
```

And then access it at http://0.0.0.0:3000/

## Run the test suite

```
rake
```

## Developments logs

```
tail -f log/developments.log
```
