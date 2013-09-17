# <img src="https://rawgithub.com/briangonzalez/cabi-gem/master/data/cabi.svg" width=30 style="margin-right: 10px"> Cabi

A simple, flat-file datastore for Ruby.

### Getting Started

Cabi is a flat-file datastore where data is stored by directory stucture and accessed by colon-delimited strings. Here's how to get started:

``` bash
$ gem install cabi
$ cabi init --mock
```

Then access your data like so:

```bash
$ irb
  > require 'cabi'
  > Cabi::Cache.read('pages:about:body')
    => "<h1>Hello, Cabi!</h1>"
```

### Usage

Assuming your `cabi-cache` folder has the following structure:

    - my-project
      |
      |--cabi-cache
        |-- info.yml
        |-- pages
        |    |-- about 
        |         |-- body.html
        |         |-- meta.yml
        |         
        |-- posts
          |-- some-article
                |-- index.html
                |-- nav.html
            

You could then query your data like so:

```ruby
Cabi.read('pages:about:body')                # returns contents of page/about/body.html
Cabi.read('pages:about:meta:foo:bar')        # returns contents of ['foo']['bar'] in page/about/meta.yml hash
Cabi.read('info:foo:bar:baz')                # returns contents of ['foo']['bar']['baz'] in info.yml hash
Cabi.read('posts:some-article:index')        # returns contents of posts/some-article/index.html
Cabi.read('posts:some-article:index.html')   # returns contents of posts/some-article/index.html
```

### Custom Cache Directory

Cabi assumes that your cache directory is either a folder at the top level of your project with a `.cabi-cache` file in it (to indicate that it's the cache directory). If one is not found, the cache directory defaults to `./cabi-cache`.

For instance, if you had a folder called `super-cache` located inside of your project's root that had a file called `.cabi-cache` inside of it, this folder would be treated as your cache directory.

### Questions?

Find me online [@brianmgonzalez](http://twitter.com/brianmgonzalez)

### Icon <img src="https://rawgithub.com/briangonzalez/cabi-gem/master/data/cabi.svg" width=20 style="margin-right: 10px">

[Cabi Icon](http://thenounproject.com/noun/file-cabinet/#icon-No22117) designed by Michela Tannoia, from The Noun Project.

### Tests
Run the test suite by running `rake test` in the parent directory.