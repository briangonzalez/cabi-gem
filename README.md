# <img src="https://rawgithub.com/briangonzalez/calle-app/master/assets/images/icon-truck-grey.svg" width=30 style="margin-right: 10px"> Cabi

A simple, flat-file datastore for Ruby.

## Getting Started

``` bash
$ gem install cabi
$ cabi init --mock
```

Then access your data like so:

```
$ irb
$ > require 'cabi'
$ > Cabi::Cache.read('pages:about:body')
$   => "<h1>Hello, Cabi!</h1>"
```

## Usage

Assuming your `cabi-cache` folder has the following structure:

    my-project
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
Cabi::Cache.read('pages:about:body')                # returns contents of page/about/body.html
Cabi::Cache.read('pages:about:meta:foo:bar')        # returns contents of ['foo']['bar'] in page/about/meta.yml hash
Cabi::Cache.read('info:foo:bar:baz')                # returns contents of ['foo']['bar']['baz'] in info.yml hash
Cabi::Cache.read('posts:some-article:index')        # returns contents of posts/some-article/index.html
Cabi::Cache.read('posts:some-article:index.html')   # returns contents of posts/some-article/index.html
```

# Custom Cache Directory

Cabi assumes that your cache directory is either a folder at the top level of your project with a `.cabi-cache` file in it. If one is not found, the cache directory defaults to `./cabi-cache`.

For instance, if you had a folder called `super-cache` inside of your project's root that had a file called `.cabi-cache` inside of it, this folder would be treated as your cache directory.

## Questions?

Find me online [@brianmgonzalez](http://twitter.com/brianmgonzalez)

# Icon

[Cabi Icon](http://thenounproject.com/noun/file-cabinet/#icon-No22117) designed by Michela Tannoia, from The Noun Project.