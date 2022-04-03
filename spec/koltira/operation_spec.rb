# frozen_string_literal: true

RSpec.describe Koltira::Operation do
  it "should create an operation" do
    class FooOperation < Koltira::Operation
      def call(args)
        Output.new(
          'bar' => args.fetch('input')
        )
      end
    end
  end

  it 'should create an operation and call it' do
    class FooOperation < Koltira::Operation
      def call(args)
        Output.new(
          'bar' => args.fetch('input')
        )
      end
    end

    output = FooOperation.call('input' => 'hello world')
    expect(output['bar']).to eq('hello world')
  end

  it 'should create an operation, assign a context, call it and add a context value' do
    class FooOperation < Koltira::Operation
      def call(args)
        context['hello'] = 'world'
        Output.new(
          'bar' => args.fetch('input')
        )
      end
    end

    context = Koltira::Context.new('foo' => 'bar')
    operation = FooOperation.new(context)
    operation.call('input' => 'hello world')
    expect(context['hello']).to eq('world')
  end
end
