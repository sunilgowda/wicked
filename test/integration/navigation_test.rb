require 'test_helper'

class IncludeNavigationTest < ActiveSupport::IntegrationCase
  test 'index forwards to first step by default' do
    visit(bar_index_path)
    assert has_content?("first")
  end

  test 'index forwards params to first step' do
    visit(bar_index_path(:foo =>  "first"))
    assert has_content?("params[:foo] first")
  end

  test 'show first' do
    step = :first
    visit(bar_path(step))
    assert has_content?(step.to_s)
  end

  test 'show second' do
    step = :second
    visit(bar_path(step))
    assert has_content?(step.to_s)
  end

  test 'skip first' do
    step = :first
    visit(bar_path(step, :skip_step => 'true'))
    assert has_content?(:second.to_s)
  end

  test 'pointer to first' do
    visit(bar_path(:wizard_first))
    assert has_content?('first')
  end

  test 'pointer to last' do
    visit(bar_path(:wizard_last))
    assert has_content?('last_step')
  end

  test 'invalid step' do
    step = :notastep
    assert_raise(ActionView::MissingTemplate) do
      visit(bar_path(step))
    end
  end

  test 'finish' do
    step = :finish
    visit(bar_path(step))
    assert has_content?('home')
  end
end


