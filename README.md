# <img src="https://rawgithub.com/briangonzalez/cabi-gem/master/data/cabi.svg" width=30 style="margin-right: 10px"> Cabi

A simple, flat-file datastore for Ruby.

### Getting Started

Cabi is a flat-file datastore where data is stored by directory stucture and accessed by colon-delimited strings. Here's how to get started:

``` bash
$ gem install cabi
$ cabi init --mock    # use --mock to init cabi data with some fake data
```

Then access your data like so:

```bash
$ irb
  > require 'cabi'
  > Cabi.read('pages:about:body')
    => "<h1>Hello, Cabi!</h1>"
```

### Usage

Assuming your `cabi-data` folder has the following structure:

    .
    ├── info.yml
    ├── nav.yml
    ├── pages
    │   └── about
    │       ├── body.html
    │       ├── meta.yml
    │       ├── person-1.html
    │       ├── person-2.html
    │       └── person-3.html
    └── posts
        └── random-article
            ├── index.html
            └── nav.html
            

You could then query your data like so:

```ruby
# Simple selection
Cabi.read('pages:about:body')                 # contents of page/about/body.html

# Selection with/without explicit file extension
Cabi.read('posts:some-article:index')         # contents of posts/some-article/index.html
Cabi.read('posts:some-article:index.html')    # contents of posts/some-article/index.html

# Bulk selection - since Cabi uses dir globbing 
# under the hood, any valid dir glob in your 
# selection will work.
Cabi.read('pages:about:*')                    # an array of body.html and meta.yml contents
Cabi.read('pages:about:person-*')             # an array of all person-* html files
Cabi.read('**/*')                             # an array of all files in data

# Selection within YAML files
Cabi.read('pages:about:meta:foo:bar')         # contents of ['foo']['bar'] in page/about/meta.yml hash
Cabi.read('info:foo:bar:baz')                 # contents of ['foo']['bar']['baz'] in info.yml hash
```

### Custom Data Directory

Cabi assumes that your data directory is either a folder at the top level of your project with a `.cabi-data` file in it (to indicate that it's the data directory). If one is not found, the data directory defaults to `./cabi-data`.

For instance, if you had a folder called `super-data` located inside of your project's root that had a file called `.cabi-data` inside of it, this folder would be treated as your data directory.

### Icon <img src="https://rawgithub.com/briangonzalez/cabi-gem/master/data/cabi.svg" width=20 style="margin-right: 10px">

[Cabi Icon](http://thenounproject.com/noun/file-cabinet/#icon-No22117) designed by Michela Tannoia, from The Noun Project.

### Tests
Run the test suite by running `rake test` in the parent directory.

### Building Gem Manually
```bash
$ gem build cabi.gemspec
$ gem install ./cabi-<VERSION>.gem
```

### Questions?
Find me online [@brianmgonzalez](http://twitter.com/brianmgonzalez)