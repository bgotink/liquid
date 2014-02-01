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
    expeted = %|  true  |
    assert_equal expeted, Template.parse(text).render
  end
  
  def test_multiline_tag_end
    text = %| {% if 1 > 0 \n %} true {% else \n\n %} false {% endif %} |
    expeted = %|  true  |
    assert_equal expeted, Template.parse(text).render
  end
end
