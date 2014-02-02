require 'test_helper'

class MultilineTagTest < Test::Unit::TestCase
  include Liquid

  def test_multiline_variable_start
    text = %| {{ \n\n foo }} |
    expected = %| bar |
    assert_equal expected, Template.parse(text).render('foo' => 'bar')
  end
  
  def test_multiline_variable_end
    text = %| {{ foo \n\n }} |
    expected = %| bar |
    assert_equal expected, Template.parse(text).render('foo' => 'bar')
  end
  
  def test_multiline_tag_start
    text = %| {% \n if 1 > 0 %} true {% \n\n else %} false {% endif %} |
    expected = %|  true  |
    assert_equal expected, Template.parse(text).render
  end
  
  def test_multiline_tag_end
    text = %| {% if 1 > 0 \n %} true {% else \n\n %} false {% endif %} |
    expected = %|  true  |
    assert_equal expected, Template.parse(text).render
  end
  
  # now test individual tags
  
  def test_multiline_assign
    text = %| {% \n assign\nfoo \n\n = \n'bar' \n%}{{ foo }} |
    expected = %| bar |
    assert_equal expected, Template.parse(text).render
  end
  
  def test_multiline_if
    text = %| {% if \n 1 \n >\n0 %} true {% else %} false {% endif %} |
    expected = %|  true  |
    assert_equal expected, Template.parse(text).render
  end
  
  def test_multiline_for
    text = %| {% for \n i\nin\n\n\r\n(1..2) %} toot {% endfor %} |
    expected = %|  toot  toot  |
    assert_equal expected, Template.parse(text).render
  end
end
