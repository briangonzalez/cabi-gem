
require 'test/unit'
require './lib/cabi'

class CabiTest < Test::Unit::TestCase

  # 
  # => Run this test suite by calling "rake test"
  #

  BIN         = '../bin/cabi'
  DATA_PATH   = File.expand_path('data')

  def setup
    Dir.chdir( DATA_PATH )
    teardown
    `#{BIN} init --mock`
  end

  def teardown
    `#{BIN} clean --force`
  end

  def test_yml_hash
    assert_equal  'baz', 
                  Cabi.read('pages:about:meta:foo')['bar']

    links = ["Home", "About", "Contact", "Services"]
    assert_equal  links, 
                  Cabi.read('nav:links')      

    assert_equal  links, 
                  Cabi.read('nav.yml:links')                   
  end

  def test_explicit_and_non_explicit_query
    assert_equal  Cabi.read('pages:about:body'),
                  Cabi.read('pages:about:body.html')
  end

  def test_bulk_selection
    string = "Hello, Cabi!"
    Cabi.write('pages:about:body', string)

    selection = Cabi.read('pages:about:*')

    assert_equal  5, selection.length  
    assert_equal  string, selection[0]  

    assert_equal  1, Cabi.read('pages:about:*.yml').length
    assert_equal  4, Cabi.read('pages:about:*.html').length
    assert_equal  9, Cabi.read('**/*').length
    assert_equal  6, Cabi.read('**/*.html').length
    assert_equal  1, Cabi.read('**/body.*').length
    assert_equal  3, Cabi.read('pages:about:**/person-*').length
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

  def test_creation
    string = "Hello, Cabi!"
    Cabi.write('some:random:output.html', string)

    assert_equal  Cabi.read('some:random:output'),
                  string
  end

  def test_not_found
    assert_nil Cabi.read('some:random:not-found:output')
  end

  def test_missing_data_dir
    teardown

    assert_raise LoadError do
      Cabi.read('some:random:not-found:output')
    end

  end

  def test_data_dir

    assert_equal  File.expand_path(Cabi::CABI_DATA_DIR), Cabi.data_dir

    user_data = './my-data'
    teardown
    `#{BIN} init --mock --target=#{user_data}`
    Cabi.reset_data_dir

    assert_equal  File.expand_path(user_data), Cabi.data_dir

    `rm -rf #{user_data}`
    `#{BIN} init --mock`
    Cabi.reset_data_dir

    assert_equal  File.expand_path(Cabi::CABI_DATA_DIR),
                  Cabi.data_dir

  end

  def test_file_selection
    file = File.expand_path File.join( 'cabi-data', 'pages', 'about', 'body.html' )

    assert_equal  file,
                  Cabi.file('pages:about:body')

    assert_nil    Cabi.file('some:random:not-found:output')
  end

  def test_bulk_file_selection

    assert_equal  5,
                  Cabi.file('pages:about:**/*').length

  end

  def test_clean_data_dir
    old_dir = Dir.pwd
    Dir.chdir Cabi::CABI_DATA_DIR

    `pwd && .#{BIN} clean --force`
    Dir.chdir old_dir

    assert File.exists? Cabi::CABI_DATA_DIR

  end

end



