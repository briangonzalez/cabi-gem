
require 'test/unit'
require './lib/cabi'

class CabiTest < Test::Unit::TestCase

  # 
  # => Run this test suite by calling "rake test"
  #

  def setup
    teardown
    `./bin/cabi init --mock`
  end

  def teardown
    `./bin/cabi clean --force`
  end

  def test_yml_hash
    assert_equal  'baz', 
                  Cabi.read('pages:about:meta:foo')['bar']
  end

  def test_explicit_and_non_explicit_query
    assert_equal  Cabi.read('pages:about:body'),
                  Cabi.read('pages:about:body.html')
  end

  def test_write
    old = Cabi.read('pages:about:body')
    Cabi.write('pages:about:body', "test")
    
    assert_equal  'test', Cabi.read('pages:about:body')
    assert_equal  'test', Cabi.read('pages:about:body.html')

    Cabi.write('pages:about:body', old)

    assert_equal  old, Cabi.read('pages:about:body')    
    assert_equal  old, Cabi.read('pages:about:body.html')
  end

  def test_cache_dir

    assert_equal Cabi::CABI_CACHE_DIR, './' + Cabi.cache_dir

    user_cache = './cache'
    teardown
    `./bin/cabi init --mock --target=#{user_cache}`
    Cabi.reset_cache_dir

    assert_equal user_cache, './' + Cabi.cache_dir

    `rm -rf #{user_cache}`
    `./bin/cabi init --mock`
    Cabi.reset_cache_dir

    assert_equal Cabi::CABI_CACHE_DIR, './' + Cabi.cache_dir

  end

  def test_creation
    string = "Hello, Cabi!"
    Cabi.write('some:random:output.html', string)

    assert_equal  Cabi.read('some:random:output'),
                  string
  end

  def test_not_found
    assert_equal  nil,
                  Cabi.read('some:random:not-found:output')
  end

end