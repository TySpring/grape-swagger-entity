require 'spec_helper'
require_relative '../../../spec/support/shared_contexts/this_api'

describe GrapeSwagger::Entity::Parser do
  include_context 'this api'

  describe '#call' do
    subject(:parsed_entity) { described_class.new(ThisApi::Entities::Something, endpoint).call }

    context 'when no endpoint is passed' do
      let(:endpoint) { nil }

      it 'parses the model with the correct :using definition' do
        expect(parsed_entity[:kind]['$ref']).to eq('#/definitions/Kind')
        expect(parsed_entity[:kind2]['$ref']).to eq('#/definitions/Kind')
        expect(parsed_entity[:kind3]['$ref']).to eq('#/definitions/Kind')
      end
    end

    context "when 'required' is passed into the documentation hash" do
      let(:endpoint) { nil }

      it "includes the 'required' field for those attributes" do
        expect(parsed_entity[:text][:required]).to eq(true)
        expect(parsed_entity[:kind][:required]).to eq(true)
        expect(parsed_entity[:colors][:required]).to be_nil
      end
    end
  end
end
