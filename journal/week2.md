# Terraform Beginner Bootcamp 2023 - Week 2

## Working with Ruby


#### Bundler

Bundler is a package manager for ruby. It is the primary way to install ruby packages (known as gems) for ruby. 

#### Install Gems

You need to create a Gemfile and define your gems in that file.  

```rb

source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'

```

Then you need to run the `bundle install ` command. This will install the gems on the system globally. A Gemfile.lock will be created to lock down the gem versions used in this project.

#### Executing ruby scripts in the context of bundler

We use `bundler exec` to tell future ruby scripts to use thegem we installed.


#### Sianatra

Sinatra is a micro web-framework for ruby tobuild web-apps.

Its great for mock or development servers for very simple project. Creating a webserver in a single file.

```rb
source "https://sinatrarb.com/"

```


## Terratowns Mock Server



### Running the web server

We can run the web server by execting the following command:

```rb
bundle install
bundle exce ruby server.rb
```


All of the code for our server is stored in the `server.rb` file.


## CRUD

Terraform provider resources use CRUD

CRUD stands for Create, Read, Update and Delete.

https://en.wikipedia.org/wiki/Create,_read,_update_and_delete

