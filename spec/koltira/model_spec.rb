# frozen_string_literal: true

RSpec.describe Koltira::Operation do
  it 'should create a model klass' do
    class FooModel < Koltira::Model
      attribute :name, :string
    end

    expect(FooModel).to be < Koltira::Model
  end

  it 'should create a model klass and create an instance of it' do
    class FooModel < Koltira::Model
      attribute :name, :string
    end

    foo = FooModel.new(name: 'Hello World')
    expect(foo).to be_a(Koltira::Model)
    expect(foo).to be_a(FooModel)
    expect(foo.name).to eq('Hello World')
  end

  it 'should create a model from database attributes' do
    class FooDatabaseModel < Koltira::Model
      attribute :name, :string

      def name=(arg)
        super(arg&.upcase)
      end
    end

    inst = FooDatabaseModel.from_database(name: 'toto')
    expect(inst.name).to eq('toto')
  end
end
